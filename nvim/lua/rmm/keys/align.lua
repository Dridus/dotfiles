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
