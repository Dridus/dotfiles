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

vim.keymap.set(
  "n", "<leader><tab>",
  ":b #<cr>",
  { desc = "Switch to last buffer" }
)
