local attach = require "rmm/lsp/attach"

require("lspconfig")["nil_ls"].setup {
  autostart = true,
  on_attach = attach.on_attach,
  settings = {
    ["nil"] = {
      formatting = {
        command = {"alejandra"}
      }
    }
  }
}

