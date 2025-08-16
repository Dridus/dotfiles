local lsp_status = require "lsp-status"
lsp_status.config {
  current_function = false,
  diagnostics = false,
  status_symbol = "",
}

lsp_status.register_progress()
