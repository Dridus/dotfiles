local attach = require "rmm/lsp/attach"

require("lspconfig")["pylsp"].setup {
  on_attach = attach.on_attach,
  settings = {
    pylsp = { placeholder = {} }
  }
}


