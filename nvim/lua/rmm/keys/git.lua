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
  "n", "<Leader>gbd",
  ":Git diff<cr>",
  { desc = "Git diff" }
)
vim.keymap.set(
  "n", "<Leader>gbb",
  ":Git blame<cr>",
  { desc = "Git blame" }
)
