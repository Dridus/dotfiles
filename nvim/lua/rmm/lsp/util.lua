local util = require "rmm/util"

local M = {}


function M.invoke_particular_code_action(kind)
  local bufnr = vim.api.nvim_get_current_buf()
  local params = vim.lsp.util.make_range_params()

  params.context = {
    diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr),
    only = {kind}
  }

  local ctx = {
    bufnr = bufnr,
    method = "textDocument/codeAction",
    params = params
  }

  vim.lsp.buf_request_all(bufnr, ctx.method, params, function(results)
    local action_tuple = nil
    for client_id, result in pairs(results) do
      for _, action in pairs(result.result or {}) do
        if action_tuple ~= nil then
          vim.notify("Expected only one code action but got a second one " .. vim.inspect(action), vim.log.levels.WARN)
          return
        end

        action_tuple = { client_id = client_id, action = action }
      end
    end

    if action_tuple == nil then
      vim.notify('No code actions available', vim.log.levels.INFO)
      return
    end

    local function apply_action(action, client)
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
      end
      if action.command then
        local command = type(action.command) == 'table' and action.command or action
        local fn = client.commands[command.command] or vim.lsp.commands[command.command]
        if fn then
          local enriched_ctx = vim.deepcopy(ctx)
          enriched_ctx.client_id = client.id
          fn(command, enriched_ctx)
        else
          -- Not using command directly to exclude extra properties,
          -- see https://github.com/python-lsp/python-lsp-server/issues/146
          local params = {
            command = command.command,
            arguments = command.arguments,
            workDoneToken = command.workDoneToken,
          }
          client.request('workspace/executeCommand', params, nil, ctx.bufnr)
        end
      end
    end

    local client = vim.lsp.get_client_by_id(action_tuple.client_id)
    local action = action_tuple.action
    if not action.edit
        and client
        and type(client.resolved_capabilities.code_action) == 'table'
        and client.resolved_capabilities.code_action.resolveProvider then

      client.request('codeAction/resolve', action, function(err, resolved_action)
        if err then
          vim.notify(err.code .. ': ' .. err.message, vim.log.levels.ERROR)
          return
        end
        apply_action(resolved_action, client)
      end)
    else
      apply_action(action, client)
    end
  end)
end

function M.get_lines(bufnr, rows)
  rows = type(rows) == "table" and rows or { rows }

  -- This is needed for bufload and bufloaded
  if bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end

  ---@private
  local function buf_lines()
    local lines = {}
    for _, row in pairs(rows) do
      lines[row] = (vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false) or { "" })[1]
    end
    return lines
  end

  local uri = vim.uri_from_bufnr(bufnr)

  -- load the buffer if this is not a file uri
  -- Custom language server protocol extensions can result in servers sending URIs with custom schemes. Plugins are able to load these via `BufReadCmd` autocmds.
  if uri:sub(1, 4) ~= "file" then
    vim.fn.bufload(bufnr)
    return buf_lines()
  end

  -- use loaded buffers if available
  if vim.fn.bufloaded(bufnr) == 1 then
    return buf_lines()
  end

  local filename = vim.api.nvim_buf_get_name(bufnr)

  -- get the data from the file
  local fd = uv.fs_open(filename, "r", 438)
  if not fd then return "" end
  local stat = uv.fs_fstat(fd)
  local data = uv.fs_read(fd, stat.size, 0)
  uv.fs_close(fd)

  local lines = {} -- rows we need to retrieve
  local need = 0 -- keep track of how many unique rows we need
  for _, row in pairs(rows) do
    if not lines[row] then
      need = need + 1
    end
    lines[row] = true
  end

  local found = 0
  local lnum = 0

  for line in string.gmatch(data, "([^\n]*)\n?") do
    if lines[lnum] == true then
      lines[lnum] = line
      found = found + 1
      if found == need then break end
    end
    lnum = lnum + 1
  end

  -- change any lines we didn't find to the empty string
  for i, line in pairs(lines) do
    if line == true then
      lines[i] = ""
    end
  end
  return lines
end

function M.locations_to_lines(locations, offset_encoding)
  if offset_encoding == nil then
    vim.notify_once("locations_to_items must be called with valid offset encoding", vim.log.levels.WARN)
  end

  local items = {}
  local grouped = setmetatable({}, {
    __index = function(t, k)
      local v = {}
      rawset(t, k, v)
      return v
    end;
  })
  for _, d in ipairs(locations) do
    -- locations may be Location or LocationLink
    local uri = d.uri or d.targetUri
    local range = d.range or d.targetSelectionRange
    table.insert(grouped[uri], {start = range.start})
  end
  
  local position_sort = function(a, b)
    if a.start.line == b.start.line then
      return a.start.character < b.start.character
    else
      return a.start.line < b.start.line
    end
  end

  local keys = vim.tbl_keys(grouped)
  table.sort(keys)
  -- TODO(ashkan) I wish we could do this lazily.
  for _, uri in ipairs(keys) do
    local rows = grouped[uri]
    print(vim.inspect(rows))
    table.sort(rows, position_sort)
    local filename = vim.fn.fnamemodify(vim.uri_to_fname(uri), ":.")

    -- list of row numbers
    local uri_rows = {}
    for _, temp in ipairs(rows) do
      local pos = temp.start
      local row = pos.line
      table.insert(uri_rows, row)
    end

    -- get all the lines for this uri
    local lines = M.get_lines(vim.uri_to_bufnr(uri), uri_rows)

    for _, temp in ipairs(rows) do
      local pos = temp.start
      local row = pos.line
      local line = lines[row] or ""
      local col = vim.lsp.util._str_byteindex_enc(line, pos.character, offset_encoding)
      table.insert(items, filename..":"..(row+1)..":"..(col+1)..": "..line)
    end
  end
  return items
end


return M
