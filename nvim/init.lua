-- --------------------------------------------------------------------------
-- Basic options
-- --------------------------------------------------------------------------

vim.opt.backup = true -- Turn on regular backups
vim.opt.colorcolumn = "96"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.cursorline = true -- Highlight the current line
vim.opt.expandtab = true -- Use spaces not tabs
vim.opt.exrc = true -- Read ./.vimrc
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 5
vim.opt.foldlevelstart = 99
vim.opt.grepprg = "rg"
vim.opt.hidden = true -- Allow buffers to be hidden when not visible
vim.opt.ignorecase = true -- Case fold when searching
vim.opt.lazyredraw = true -- Don't draw while executing macros and similar
vim.opt.list = true -- Show whitespace (trailing -s and >s)'
vim.opt.listchars = { tab = "▸\\ ", trail = "·", nbsp = "_", extends = "…" }
vim.opt.matchtime = 2 -- Highlight matching bracket for 2/10ths of a second
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.number = true -- Instead of showing 0 at the cursor line, show the actual line
vim.opt.relativenumber = true -- Show line number distance from cursor for easy j/k
vim.opt.scrolloff = 7 -- Keep 7 lines visible when moving through file
vim.opt.secure = true -- Only allow safe things in ./.vimrc
vim.opt.shiftwidth = 2 -- 2 space indent stops
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.showtabline = 2 -- Always show the tabline
vim.opt.smartcase = true -- But don't case fold uppercase
vim.opt.splitbelow = true -- Put new splits down
vim.opt.splitright = true -- Put new vsplits right
vim.opt.termguicolors = true -- Use true color support in terminals
vim.opt.timeoutlen = 2000 -- Set multikey timeout to 2 seconds
vim.opt.undofile = true -- Persist undo information across sessions
vim.opt.wildmode = "list:longest,full" -- Configure wildmenu
vim.opt.wrap = false -- Don't wrap lines by default
vim.opt.writebackup = false -- No need to be too safe

-- --------------------------------------------------------------------------
-- Plugin loading
-- --------------------------------------------------------------------------

local Plug = vim.fn["plug#"]

vim.fn["plug#begin"](vim.fn.stdpath("data") .. "/plugged")

-- Colorz
Plug "lsdr/monokai"
Plug "kergoth/vim-hilinks"

-- Syntaxes
Plug "1995parham/vim-spice"
Plug "Dridus/nc.vim"
Plug "elzr/vim-json"
Plug "hashivim/vim-terraform"
Plug "LnL7/vim-nix"
Plug "neovimhaskell/haskell-vim"
Plug "rust-lang/rust.vim"

-- SCM
Plug "tpope/vim-fugitive"
Plug "kristijanhusak/vim-dirvish-git"
Plug "int3/vim-extradite"

-- Tools and navigation
Plug "junegunn/fzf"
Plug "justinmk/vim-dirvish"
Plug "moll/vim-bbye"
Plug "neomake/neomake"
Plug "vim-scripts/gitignore"

-- LSP and completion
Plug "neovim/nvim-lspconfig"
Plug "hrsh7th/cmp-nvim-lsp"
Plug "hrsh7th/cmp-buffer"
Plug "hrsh7th/cmp-path"
Plug "hrsh7th/cmp-cmdline"
Plug "hrsh7th/nvim-cmp"
Plug "L3MON4D3/LuaSnip"
Plug "saadparwaiz1/cmp_luasnip"

-- Text manipulation
Plug "michaeljsmith/vim-indent-object"
Plug "tpope/vim-commentary"
Plug "tpope/vim-repeat"
Plug "tpope/vim-surround"
Plug "vim-scripts/Align"

-- UI
Plug "vim-airline/vim-airline"
Plug "vim-airline/vim-airline-themes"
Plug "simnalamburt/vim-mundo"

vim.fn["plug#end"]()

-- --------------------------------------------------------------------------
-- Plugin options
-- --------------------------------------------------------------------------

-- Colorscheme
vim.opt.background = "dark"
vim.cmd("colorscheme monokai")

-- Airline
vim.g["airline_theme"] = "molokai"
vim.g["airline_powerline_fonts"] = 1
vim.g["airline#extensions#tabline#buffer_idx_mode"] = 1
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#show_buffers"] = 1
vim.g["airline#extensions#tabline#fnamemod"] = ":t"
vim.g["airline#extensions#tabline#fnamecollapse"] = 0
vim.g["airline#extensions#tabline#formatter"] = "unique_tail_improved"
vim.g["airline#extensions#tagbar#enabled"] = 0

-- Haskell
vim.g["haskell_backpack"] = 1                -- to enable highlighting of backpack keywords
vim.g["haskell_enable_quantification"] = 1   -- to enable highlighting of `forall`
vim.g["haskell_enable_recursivedo"] = 1      -- to enable highlighting of `mdo` and `rec`
vim.g["haskell_enable_arrowsyntax"] = 1      -- to enable highlighting of `proc`
vim.g["haskell_enable_pattern_synonyms"] = 1 -- to enable highlighting of `pattern`
vim.g["haskell_enable_typeroles"] = 1        -- to enable highlighting of type roles
vim.g["haskell_enable_static_pointers"] = 1  -- to enable highlighting of `static`
vim.g["haskell_indent_disable"] = 1          -- get your dirty automation off my indents
vim.g["haskell_backpack"] = 1                -- to enable highlighting of backpack keywords

-- JSON
vim.g["vim_json_syntax_conceal"] = 0

-- reStructuredText
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.rst",
  callback = function()
    vim.bo.shiftwidth = 3
    vim.bo.makeprg = "make html"
  end
})

-- Markdown

-- NC (G-code)
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.mpf", "*.MPF", "*.spf", "*.SPF"},
  callback = function()
    vim.bo.syntax = "sinumerik"
  end
})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.ngc", "*.NGC"},
  callback = function()
    vim.bo.syntax = "linuxcnc"
  end
})

-- --------------------------------------------------------------------------
-- Leader key mappings
-- --------------------------------------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Buffer management
vim.keymap.set(
  "n", "<Leader>bp",
  ":bp<cr>",
  { desc = "Previous buffer" }
)
vim.keymap.set(
  "n", "<Leader>bn",
  ":bn<cr>",
  { desc = "Next buffer" }
)
vim.keymap.set(
  "n", "<Leader>bd",
  ":Bd<cr>",
  { desc = "Delete buffer without closing window" }
)
vim.keymap.set(
  "n", "<Leader>bD",
  ":1,$bd<cr>",
  { desc = "Delete all buffers" }
)

-- Alignment
vim.keymap.set(
  "v", "<Leader>xa=",
  ":Align =<cr>",
  { desc = "Align equals" }
)
vim.keymap.set(
  "v", "<Leader>xa:",
  ":Align ::<cr>",
  { desc = "Align ::" }
)
vim.keymap.set(
  "v", "<Leader>xa,",
  ":Align ,<cr>",
  { desc = "Align commas" }
)
vim.keymap.set(
  "v", "<Leader>xa<bar>",
  ":Align <bar><cr>",
  { desc = "Align vertical bars (pipes)" }
)
vim.keymap.set(
  "v", "<Leader>xar",
  ":Align",
  { desc = "Align some arbitrary regex" }
)

-- Git
vim.keymap.set(
  "n", "<Leader>gs",
  ":Git<cr>",
  { desc = "Git status" }
)
vim.keymap.set(
  "n", "<Leader>gl",
  ":Git log<cr>",
  { desc = "Git log" }
)
vim.keymap.set(
  "n", "<Leader>gd",
  ":Git diff<cr>",
  { desc = "Git diff" }
)
vim.keymap.set(
  "n", "<Leader>gb",
  ":Git blame<cr>",
  { desc = "Git blame" }
)


-- Miscellaneous
vim.keymap.set(
  {"n", "v", "o"}, "<Leader>sc",
  ":nohlsearch<cr>",
  { silent = true, desc = "Clear search highlight" }
)
vim.keymap.set(
  "n", "<Leader>e",
  ":e <c-r>=expand('%:p:h') . '/'<cr>",
  { desc = "Open a file relative to the current file's path" }
)

-- --------------------------------------------------------------------------
-- FZF
-- --------------------------------------------------------------------------

local rg_opts = {
  "--line-number",
  "--column",
  "--no-messages",
  "--color=always"
}
local rg_fzf_opts = {
  "--ansi",
  "--delimiter", ":",
  "--nth", "1,4.."
}
local filepreview_fd_fzf_opts = {
  [1] = "--preview=bat " ..
    "--color=always " ..
    "--style=numbers " ..
    "--line-range=:$FZF_PREVIEW_LINES {+}"
}
local filepreview_rg_fzf_opts = {
  [1] = "--preview=bat-fzf-preview {2} {+1}"
}
local multi_fzf_opts = {
  "--multi",
  "--expect=ctrl-t,ctrl-v,ctrl-x",
  "--bind=ctrl-a:select-all,ctrl-d:deselect-all",
  "--color=hl:68,hl+:110"
}

-- really, lua?
local function list_concat(...)
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

local function shellopts(opts)
  local res = ""
  for i = 1, #opts do
    if i ~= 1 then res = res .. " " end
    res = res .. vim.fn.shellescape(opts[i])
  end
  return res
end

local function parse_file_line_column(line)
  local toks = vim.split(line, ":")
  local res = { filename = toks[1] }
  if #toks > 1 then res.lnum = toks[2] end
  if #toks > 2 then res.col  = toks[3] end
  if #toks > 3 then
    res.text = string.match(line, "^[^:]+:[^:]+:[^:]+:(.*)")
  end
  return res
end

local function visit_hit(cmd, hit)
  vim.cmd(cmd .. " " .. vim.fn.escape(hit.filename, " %#\\"))
  if hit.lnum then vim.cmd(hit.lnum) end
  if hit.col then vim.cmd("normal! " .. hit.col .. "|") end
end

local function handle_fzf_files_gen(lines)
  if #lines < 2 then
    return
  end

  local cmds = {
    ["ctrl-x"] = "split",
    ["ctrl-v"] = "vertical split",
    ["ctrl-t"] = "tabedit"
  }
  local cmd = cmds[lines[1]] or "edit"
  local hits = {}
  for i = 2, #lines do
    hits[i-1] = parse_file_line_column(lines[i])
  end
  return cmd, hits
end

local function handle_fzf_files(lines)
  local cmd, hits = handle_fzf_files_gen(lines)
  for i = 1, #hits do
    visit_hit(cmd, hits[i])
  end
end

local function handle_fzf_files_qf(lines)
  local cmd, hits = handle_fzf_files_gen(lines)
  visit_hit(cmd, hits[1])
  vim.fn.setqflist(hits)
end
  
vim.keymap.set(
  "n", "<Leader>.",
  function()
    vim.fn["fzf#run"] {
      ["sink*"] = handle_fzf_files,
      source = "fd --type f",
      options = list_concat(filepreview_fd_fzf_opts, multi_fzf_opts)
    }
  end,
  { desc = "Find files by name under the current CWD" }
)

vim.keymap.set(
  "n", "<Leader>f.",
  function()
    local dir = vim.fn.expand("%:h") 
    if dir == "" then dir = "." end
    vim.fn["fzf#run"] {
      ["sink*"] = handle_fzf_files,
      source = "fd --type f --search-path " .. vim.fn.shellescape(dir),
      options = list_concat(filepreview_fd_fzf_opts, multi_fzf_opts)
    }
  end,
  { desc = "Find files by name under the current file's directory" }
)

vim.keymap.set(
  "n", "<Leader>fr",
  function()
    local candidates = {}
    local offset = 1

    for i = 1, vim.fn.bufnr("$") do
      if vim.fn.buflisted(i) then
        candidates[offset] = vim.fn.bufname(i)
        offset = offset + 1
      end
    end

    for i = 1, #vim.v.oldfiles do
      local fn = vim.v.oldfiles[i]
      if
        string.match(fn, "^fugitive:") or
        string.match(fn, "^term:") or
        string.match(fn, "^NERD_tree") or
        string.match(fn, "^/tmp") or
        string.match(fn, "^.git")
        then
        else
          candidates[offset] = fn
          offset = offset + 1
        end
    end

    vim.fn["fzf#run"] {
      ["sink*"] = handle_fzf_files,
      source = candidates,
      options = list_concat(filepreview_fd_fzf_opts, multi_fzf_opts)
    }
  end,
  { desc = "Find recently opened files and buffers" }
)

vim.keymap.set(
  "n", "<Leader>ss",
  function()
    local res = {}
    local lines = vim.fn.getline(0, vim.fn.line("$"))

    for i = 1, #lines do
      res[i] = i .. ":" .. lines[i]
    end

    vim.fn["fzf#run"] {
      sink = function(line)
        vim.cmd(string.match(line, "^([^:]+):"))
      end,
      source = res,
      options = {
        "--no-multi",
        "--no-sort",
        "--delimiter", ":",
        "--nth", "2.."
      }
    }
  end,
  { desc = "Find lines in the current file" }
)

local function fzf_lines_in_files(ask_for_options, sink)
  return function()
    local options = ""
    if ask_for_options then options = vim.fn.input("options: ") end
    local query = vim.fn.input("query: ")
    vim.fn["fzf#run"]({
      ["sink*"] = sink,
      source =
        shellopts(list_concat({"rg"}, rg_opts)) ..
        " " .. options ..
        " -e " .. vim.fn.shellescape(query),
      options = list_concat(rg_fzf_opts, filepreview_rg_fzf_opts, multi_fzf_opts)
    })
  end
end

vim.keymap.set(
  "n", "<Leader>?",
  fzf_lines_in_files(true, handle_fzf_files),
  { desc = "Recursively search the CWD with rg, and prompt for additional options" }
)

vim.keymap.set(
  "n", "<Leader>/",
  fzf_lines_in_files(false, handle_fzf_files),
  { desc = "Recursively search the CWD with rg" }
)

vim.keymap.set(
  "n", "<Leader>f?",
  fzf_lines_in_files(true, handle_fzf_files_qf),
  { desc = [[
      Recursively search the CWD with rg, prompt for additional
      options, and collect the results in quickfix
    ]] }
)
vim.keymap.set(
  "n", "<Leader>f/",
  fzf_lines_in_files(false, handle_fzf_files_qf),
  { desc = "Recursively search the CWD with rg, and collect the results in quickfix" }
)
vim.keymap.set(
  "n", "<Leader>bb",
  function()
    local buffers = vim.api.nvim_exec("buffers", true)
    local buffer_lines = vim.split(buffers, "\n")
    vim.fn["fzf#run"]({
      sink = function(line)
        vim.cmd("buffer " .. string.match(line, "^ *(%d+)"))
      end,
      source = buffer_lines,
      options = { "--no-multi" }
    })
  end,
  { desc = "Find open buffers" }
)
vim.keymap.set(
  "n", "<Leader>hs",
  function()
    local candidates = {}
    local tagsfiles = vim.fn.globpath(vim.o.runtimepath, "doc/tags", false, true)
    for i = 1, #tagsfiles do
      vim.list_extend(candidates, vim.fn.readfile(tagsfiles[i]))
    end
    vim.fn["fzf#run"]({
      sink = function(line)
        vim.cmd("help " .. string.match(line, "^([^\t]+)"))
      end,
      source = candidates
    })
  end,
  { desc = "Find help" }
)

-- --------------------------------------------------------------------------
-- Other key mappings
-- --------------------------------------------------------------------------

vim.keymap.set(
  "n", "Q",
  "@q",
  { desc = "Execute the q macro (@q)" }
)

vim.keymap.set(
  "n", "<up>",
  ":copen 25<cr>",
  { desc = "Open quickfix", silent = true }
)
vim.keymap.set(
  "n", "<down>",
  ":cclose<cr>",
  { desc = "Close quickfix", silent = true }
)
vim.keymap.set(
  "n", "<right>",
  ":cnext<cr>",
  { desc = "Go to next quickfix entry", silent = true }
)
vim.keymap.set(
  "n", "<left>",
  ":cprevious<cr>",
  { desc = "Go to previous quickfix entry", silent = true }
)
vim.keymap.set(
  "n", "<cr>",
  ":cc<cr>",
  { desc = "Visit current quickfix entry", silent = true }
)

vim.keymap.set(
  "n", "<c-j>",
  "i<cr><esc>",
  { desc = "Insert line break" }
)

vim.keymap.set(
  {"n", "v", "o", "i"}, "<f10>",
  ":echo 'hi<' . synIDattr(synID(line('.'), col('.'), 1), 'name') . '> ' . " ..
  "'trans<' . synIDattr(synID(line('.'), col('.'), 0), 'name') . '> ' . " ..
  "'lo<' . synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name') . '>'<cr>",
  { desc = "Show hightlighting and syntax information at point" }
)

-- --------------------------------------------------------------------------
-- Completion and snippets?
-- --------------------------------------------------------------------------

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  window = {
  },
  mapping = cmp.mapping.preset.insert {
   ["<tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<s-tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<c-b>"] = cmp.mapping.scroll_docs(-4),
    ["<c-f>"] = cmp.mapping.scroll_docs(4),
    ["<c-space>"] = cmp.mapping.complete(),
    ["<c-e>"] = cmp.mapping.abort(),
    ["<cr>"] = cmp.mapping.confirm { select = true },
  },
  sources = cmp.config.sources(
    {
      { name = "nvim_lsp" },
      { name = "vsnip" }
    },
    {
      { name = "buffer" }
    }
  )
}

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    {
      { name = "path" }
    },
    {
      { name = "cmdline" }
    }
  )
})

-- --------------------------------------------------------------------------
-- LSP
-- --------------------------------------------------------------------------

local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities = require("cmp_nvim_lsp").update_capabilities(lsp_capabilities)

-- Mappings.
vim.keymap.set(
  "n", "<leader>E",
  vim.diagnostic.open_float,
  { silent = true, desc = "Open diagnostics in floating window" }
)

vim.keymap.set(
  "n", "[d",
  vim.diagnostic.goto_prev,
  { silent = true, desc = "Previous diagnostic" }
)
vim.keymap.set(
  "n", "]d",
  vim.diagnostic.goto_next,
  { silent = true, desc = "Next diagnostic" }
)

vim.keymap.set(
  "n", "[h",
  function()
    vim.diagnostic.goto_prev {
      severity = vim.diagnostic.severity.HINT
    }
  end,
  { silent = true, desc = "Previous hint diagnostic" }
)
vim.keymap.set(
  "n", "]d",
  function()
    vim.diagnostic.goto_next {
      severity = vim.diagnostic.severity.HINT
    }
  end,
  { silent = true, desc = "Next hint diagnostic" }
)

vim.keymap.set(
  "n", "<leader>q",
  vim.diagnostic.setqflist,
  { silent = true, desc = "Add diagnostics to quickfix" }
)

local function symbols_to_lines(symbols0, bufnr0)
  local function go(_symbols, items, bufnr)
    for _, symbol in ipairs(_symbols) do
      local kind = vim.lsp.protocol.SymbolKind[symbol.kind] or "Unknown"
      if symbol.location then -- SymbolInformation type
        local range = symbol.location.range
        local filename = vim.fn.fnamemodify(vim.uri_to_fname(symbol.location.uri), ":.")
        local lnum = range.start.line + 1
        local col = range.start.character + 1
        table.insert(items, filename..":"..lnum..":"..col..": "..kind..": " .. symbol.name)
      elseif symbol.selectionRange then -- DocumentSymbol type
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":.")
        local lnum = symbol.selectionRange.start.line + 1
        local col = symbol.selectionRange.start.character + 1
        local kind = kind
        table.insert(items, filename..":"..lnum..":"..col..": "..kind..": " .. symbol.name)
        if symbol.children then
          go(symbol.children, items, bufnr)
        end
      end
    end
    return items
  end
  return go(symbols0, {}, bufnr0 or 0)
end

local function response_to_fzf(entity, title_fn)
  return function(_, result, ctx, config)
    if not result or vim.tbl_isempty(result) then
      vim.notify('No ' .. entity .. ' found')
    else
      vim.fn["fzf#run"] {
        ["sink*"] = handle_fzf_files,
        source = symbols_to_lines(result, ctx.bufnr),
        options = list_concat(rg_fzf_opts, filepreview_rg_fzf_opts, multi_fzf_opts)
      }
    end
  end
end

vim.lsp.handlers["textDocument/documentSymbol"] = response_to_fzf(
  "document symbols",
  function(ctx)
    local fname = vim.fn.fnamemodify(vim.uri_to_fname(ctx.params.textDocument.uri), ":.")
    return string.format('Symbols in %s', fname)
  end
)

vim.lsp.handlers["workspace/symbol"] = response_to_fzf(
  symbols_to_lines,
  "symbols",
  function(ctx)
    return string.format("Symbols matching '%s'", ctx.params.query)
  end
)

local function get_lines(bufnr, rows)
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

  local filename = api.nvim_buf_get_name(bufnr)

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

function locations_to_lines(locations, offset_encoding)
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
    local lines = get_lines(vim.uri_to_bufnr(uri), uri_rows)

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

local function location_handler(_, result, ctx, _)
  if result == nil or vim.tbl_isempty(result) then
    local _ = log.info() and log.info(ctx.method, 'No location found')
    return nil
  end
  local client = vim.lsp.get_client_by_id(ctx.client_id)

  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1], client.offset_encoding)

    if #result > 1 then
      vim.fn["fzf#run"] {
        ["sink*"] = handle_fzf_files,
        source = locations_to_lines(result, client.offset_encoding),
        options = list_concat(rg_fzf_opts, filepreview_rg_fzf_opts, multi_fzf_opts)
      }
    end
  else
    vim.lsp.util.jump_to_location(result, client.offset_encoding)
  end
end

vim.lsp.handlers["textDocument/declaration"] = location_handler
vim.lsp.handlers["textDocument/definition"] = location_handler
vim.lsp.handlers["textDocument/typeDefinition"] = location_handler
vim.lsp.handlers["textDocument/implementation"] = location_handler

vim.lsp.handlers["textDocument/references"] = function(_, result, ctx, config)
  if not result or vim.tbl_isempty(result) then
    vim.notify("No references found")
  else
    local client = vim.lsp.get_client_by_id(ctx.client_id)

    vim.fn["fzf#run"] {
      ["sink*"] = handle_fzf_files,
      source = locations_to_lines(result, client.offset_encoding),
      options = list_concat(rg_fzf_opts, filepreview_rg_fzf_opts, multi_fzf_opts)
    }
  end
end
local function lsp_on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>sl", vim.lsp.buf.document_symbol, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
end

local function invoke_particular_code_action(kind)
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
        util.apply_workspace_edit(action.edit, client.offset_encoding)
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

require("lspconfig")["hls"].setup {
  on_attach = function(client, bufnr)
    lsp_on_attach(client, bufnr)

    vim.keymap.set(
      "n", "<leader>hf",
      function()
        invoke_particular_code_action("refactor.wingman.fillHole")
      end,
      { desc = "Attempt to automatically fill hole at point" }
    )

    vim.keymap.set(
      "n", "<leader>hr",
      function()
        invoke_particular_code_action("refactor.wingman.refine")
      end,
      { desc = "Refine hole at point" }
    )

    vim.keymap.set(
      "n", "<leader>hc1",
      function()
        invoke_particular_code_action("refactor.wingman.caseSplit")
      end,
      { desc = "Case split value hole at point" }
    )

    vim.keymap.set(
      "n", "<leader>hcp",
      function()
        invoke_particular_code_action("refactor.wingman.caseSplitPun")
      end,
      { desc = "Case split value hole at point with NamedFieldPuns" }
    )

    vim.keymap.set(
      "n", "<leader>hca",
      function()
        invoke_particular_code_action("refactor.wingman.splitFuncArgs")
      end,
      { desc = "Case split all arguments" }
    )

    vim.keymap.set(
      "n", "<leader>hil",
      function()
        invoke_particular_code_action("refactor.wingman.introduceLambda")
      end,
      { desc = "Introduce lambda for hole at point" }
    )

    vim.keymap.set(
      "n", "<leader>hid",
      function()
        invoke_particular_code_action("refactor.wingman.introduceAndDestruct")
      end,
      { desc = "Introduce destructuring lambda for hole at point" }
    )

  end,
  flags = lsp_flags,
  capabilities = lsp_capabilities,
  cmd = {"haskell-language-server", "lsp"}
}

require("lspconfig")["rust_analyzer"].setup {
  on_attach = lsp_on_attach,
  flags = lsp_flags,
  capabilities = lsp_capabilities,
  settings = {
    ["rust-analyzer"] = {}
  }
}
