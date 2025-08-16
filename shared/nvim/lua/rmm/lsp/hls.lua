local lsp_util = require "rmm/lsp/util"
local attach = require "rmm/lsp/attach"

require("lspconfig")["hls"].setup {
  on_attach = function(client, bufnr)
    attach.on_attach(client, bufnr)

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
