vim.keymap.set(
  "n", "<leader>oo",
  ":OverseerToggle<cr>",
  { desc = "Toggle the Overseer task list", silent = true }
)

vim.keymap.set(
  "n", "<leader>ot",
  ":OverseerRun<cr>",
  { desc = "Prompt for a template task to add and run.", silent = true }
)

vim.keymap.set(
  "n", "<leader>or",
  ":OverseerQuickAction restart<cr>",
  { desc = "Restart the current task.", silent = true }
)

vim.keymap.set(
  "n", "<leader>oq",
  ":OverseerQuickAction<cr>",
  { desc = "Prompt for a quick action against the current task.", silent = true }
)

