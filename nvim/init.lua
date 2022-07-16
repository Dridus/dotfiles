require "rmm/options"
require "rmm/plugins"
require "rmm/win32yank"

vim.opt.background = "dark"
vim.cmd("colorscheme onehalfdark")

require "rmm/airline"
require "rmm/cmp"
require "rmm/haskell"
require "rmm/json"
require "rmm/lsp"
require "rmm/nc"
require "rmm/restructuredtext"

require "rmm/keys/align" -- <leader>a
require "rmm/keys/buffer" -- <leader>b
require "rmm/keys/diagnostic" -- <leader>E, <leader>q, brackets d, brackets h
require "rmm/keys/git" -- <leader>g
require "rmm/keys/misc"
require "rmm/keys/fzf"
