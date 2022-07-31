local lsp_lines = require "lsp_lines"

lsp_lines.setup()

vim.keymap.set(
  "n", "<leader>dt",
  function()
   local lines_enabled = not vim.diagnostic.config().virtual_lines
   vim.diagnostic.config {
      virtual_lines = lines_enabled,
      virtual_text = not lines_enabled
    }
  end,
  { desc = "Toggle showing diagnostics below the lines they affect or to the right" }
)

vim.diagnostic.config {
  virtual_lines = false,
  virtual_text = true
}
