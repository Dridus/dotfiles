vim.keymap.set(
  "n", "<leader>E",
  vim.diagnostic.open_float,
  { silent = true, desc = "Open diagnostics in floating window" }
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

vim.keymap.set(
  "n", "[h",
  function()
    vim.diagnostic.goto_prev {
      severity = vim.diagnostic.severity.HINT
    }
  end,
  { silent = true, desc = "Previous hint diagnostic" }
)

vim.keymap.set(
  "n", "]d",
  function()
    vim.diagnostic.goto_next {
      severity = vim.diagnostic.severity.HINT
    }
  end,
  { silent = true, desc = "Next hint diagnostic" }
)

vim.keymap.set(
  "n", "<leader>q",
  vim.diagnostic.setqflist,
  { silent = true, desc = "Add diagnostics to quickfix" }
)
