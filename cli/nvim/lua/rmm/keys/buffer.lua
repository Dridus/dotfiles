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
