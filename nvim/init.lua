-- --------------------------------------------------------------------------
-- Basic options
-- --------------------------------------------------------------------------

vim.opt.backup = true -- Turn on regular backups
vim.opt.colorcolumn = "96"
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

vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    vim.wo.wrap = false
  end
})

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
---- FIXME this doesn't work for re-visiting an open .md for some reason
vim.api.nvim_create_autocmd("BufWinEnter", { 
  pattern = "*.md",
  callback = function()
    vim.wo.wrap = true
  end
})

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
    vim.fn["fzf#run"]({
      ["sink*"] = handle_fzf_files,
      source = "fd --type f",
      options = list_concat(filepreview_fd_fzf_opts, multi_fzf_opts)
    })
  end,
  { desc = "Find files by name under the current CWD" }
)

vim.keymap.set(
  "n", "<Leader>f.",
  function()
    local dir = vim.fn.expand("%:h") 
    if dir == "" then dir = "." end
    vim.fn["fzf#run"]({
      ["sink*"] = handle_fzf_files,
      source = "fd --type f --search-path " .. vim.fn.shellescape(dir),
      options = list_concat(filepreview_fd_fzf_opts, multi_fzf_opts)
    })
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

    vim.fn["fzf#run"]({
      ["sink*"] = handle_fzf_files,
      source = candidates,
      options = list_concat(filepreview_fd_fzf_opts, multi_fzf_opts)
    })
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

    vim.fn["fzf#run"]({
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
    })
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
  "i", "<tab>",
  function()
    if vim.fn.pumvisible() then
      vim.api.nvim_select_popupmenu_item(0, true, true)
    end
  end,
  { desc = "Accept the first completion entry immediately", silent = true }
)

vim.keymap.set(
  {"n", "v", "o", "i"},
  "<f10>",
  ":echo 'hi<' . synIDattr(synID(line('.'), col('.'), 1), 'name') . '> ' . " ..
  "'trans<' . synIDattr(synID(line('.'), col('.'), 0), 'name') . '> ' . " ..
  "'lo<' . synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name') . '>'<cr>",
  { desc = "Show hightlighting and syntax information at point" }
)

