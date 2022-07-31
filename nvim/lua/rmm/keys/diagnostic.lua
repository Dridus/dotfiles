local telescope_builtin = require "telescope.builtin"

vim.keymap.set(
  "n", "<leader>dl",
  function()
    vim.diagnostic.open_float { border = "rounded" }
  end,
  { silent = true, desc = "Open diagnostic for current line in floating window" }
)

vim.keymap.set(
  "n", "<leader>db",
  function()
    telescope_builtin.diagnostics {
      bufnr = 0,
    }
  end,
  { silent = true, desc = "Telescope diagnostics applying to the current buffer" }
)

vim.keymap.set(
  "n", "<leader>dw",
  function()
    telescope_builtin.diagnostics {
      bufnr = 0,
    }
  end,
  { silent = true, desc = "Telescope diagnostics applying to all open buffers" }
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
