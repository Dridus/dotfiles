require("bufferline").setup {
  options = {
    show_buffer_close_icons = false,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    tab_size = 1,
    numbers = "ordinal"
  },
  highlights = {
    buffer_selected = { bold = true },
    numbers_selected = { bold = true },
    diagnostic_selected = { bold = true },
    hint_selected = { bold = true },
    hint_diagnostic_selected = { bold = true },
    info_selected = { bold = true },
    info_diagnostic_selected = { bold = true },
    warning_selected = { bold = true },
    warning_diagnostic_selected = { bold = true },
    error_selected = { bold = true },
    error_diagnostic_selected = { bold = true },
    duplicate_selected = {},
    duplicate_visible = {},
    duplicate = {},
    pick_selected = { bold = true },
    pick_visible = { bold = true },
    pick = { bold = true },
  }
}

for n = 1, 9 do
  vim.keymap.set(
    "n", "<leader>" .. n,
    ":BufferLineGoToBuffer " .. n .. "<cr>",
    { desc = "Jump to buffer " .. n, silent = true }
  )
end

vim.keymap.set(
  "n", "<leader>b.",
  ":BufferLinePick<cr>",
  { desc = "Jump to buffer", silent = true }
)

