local lsp_util = require "rmm/lsp/util"

local function on_attach(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>sl", vim.lsp.buf.document_symbol, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities = require("cmp_nvim_lsp").update_capabilities(lsp_capabilities)

require("lspconfig")["hls"].setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    vim.keymap.set(
      "n", "<leader>hf",
      function()
        lsp_util.invoke_particular_code_action("refactor.wingman.fillHole")
      end,
      { desc = "Attempt to automatically fill hole at point" }
    )

    vim.keymap.set(
      "n", "<leader>hr",
      function()
        lsp_util.invoke_particular_code_action("refactor.wingman.refine")
      end,
      { desc = "Refine hole at point" }
    )

    vim.keymap.set(
      "n", "<leader>hc1",
      function()
        lsp_util.invoke_particular_code_action("refactor.wingman.caseSplit")
      end,
      { desc = "Case split value hole at point" }
    )

    vim.keymap.set(
      "n", "<leader>hcp",
      function()
        lsp_util.invoke_particular_code_action("refactor.wingman.caseSplitPun")
      end,
      { desc = "Case split value hole at point with NamedFieldPuns" }
    )

    vim.keymap.set(
      "n", "<leader>hca",
      function()
        lsp_util.invoke_particular_code_action("refactor.wingman.splitFuncArgs")
      end,
      { desc = "Case split all arguments" }
    )

    vim.keymap.set(
      "n", "<leader>hil",
      function()
        lsp_util.invoke_particular_code_action("refactor.wingman.introduceLambda")
      end,
      { desc = "Introduce lambda for hole at point" }
    )

    vim.keymap.set(
      "n", "<leader>hid",
      function()
        lsp_util.invoke_particular_code_action("refactor.wingman.introduceAndDestruct")
      end,
      { desc = "Introduce destructuring lambda for hole at point" }
    )

  end,
  capabilities = capabilities,
  cmd = {"haskell-language-server", "lsp"}
}

require("lspconfig")["rust_analyzer"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {}
  }
}
