local M = {}

function M.list_concat(...)
  local res = {}
  local offset = 1
  for i = 1, select("#", ...) do
    local l = select(i, ...)
    for j = 1, #l do
      res[offset] = l[j]
      offset = offset + 1
    end
  end
  return res
end

function M.shellopts(opts)
  local res = ""
  for i = 1, #opts do
    if i ~= 1 then res = res .. " " end
    res = res .. vim.fn.shellescape(opts[i])
  end
  return res
end

function M.parse_file_line_column(line)
  local toks = vim.split(line, ":")
  local res = { filename = toks[1] }
  if #toks > 1 then res.lnum = toks[2] end
  if #toks > 2 then res.col  = toks[3] end
  if #toks > 3 then
    res.text = string.match(line, "^[^:]+:[^:]+:[^:]+:(.*)")
  end
  return res
end

function M.visit_hit(cmd, hit)
  vim.cmd(cmd .. " " .. vim.fn.escape(hit.filename, " %#\\"))
  if hit.lnum then vim.cmd(hit.lnum) end
  if hit.col then vim.cmd("normal! " .. hit.col .. "|") end
end

return M
