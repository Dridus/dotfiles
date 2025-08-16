local attach = require "rmm/lsp/attach"

require("lspconfig")["rust_analyzer"].setup {
  on_attach = attach.on_attach,
  settings = {
    ["rust-analyzer"] = {}
  }
}

