local align = require "align"

vim.keymap.set(
  "x", "<leader>xa1",
  function()
    align.align_to_char(1, true)
  end,
  { desc = "Align to an entered character" }
)

vim.keymap.set(
  "x", "<leader>xa2",
  function()
    align.align_to_char(2, true)
  end,
  { desc = "Align to entered couplet" }
)

vim.keymap.set(
  "x", "<leader>xa=",
  function()
    align.align("=")
  end,
  { desc = "Align equals" }
)

vim.keymap.set(
  "v", "<leader>xa:",
  function()
    align.align("::")
  end,
  { desc = "Align ::" }
)

vim.keymap.set(
  "v", "<leader>xa,",
  function()
    align.align(",")
  end,
  { desc = "Align commas" }
)

vim.keymap.set(
  "v", "<leader>xa<bar>",
  function()
    align.align("|")
  end,
  { desc = "Align vertical bars (pipes)" }
)

vim.keymap.set(
  "v", "<leader>xap",
  function()
    align.align_to_string(true)
  end,
  { desc = "Align to an entered lua pattern" }
)

vim.keymap.set(
  "v", "<leader>xas",
  function()
    align.align_to_string(false)
  end,
  { desc = "Align to an entered string" }
)
