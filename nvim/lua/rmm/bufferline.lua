require("bufferline").setup {
  options = {
    show_buffer_close_icons = false,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    numbers = "ordinal"
  },
  highlights = {
    buffer_selected = { gui = "bold" },
    numbers_selected = { gui = "bold" },
    diagnostic_selected = { gui = "bold" },
    hint_selected = { gui = "bold" },
    hint_diagnostic_selected = { gui = "bold" },
    info_selected = { gui = "bold" },
    info_diagnostic_selected = { gui = "bold" },
    warning_selected = { gui = "bold" },
    warning_diagnostic_selected = { gui = "bold" },
    error_selected = { gui = "bold" },
    error_diagnostic_selected = { gui = "bold" },
    duplicate_selected = { gui = nil },
    duplicate_visible = { gui = nil },
    duplicate = { gui = nil },
    pick_selected = { gui = "bold" },
    pick_visible = { gui = "bold" },
    pick = { gui = "bold" },
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

