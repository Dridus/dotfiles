local lsp_status = require "lsp-status"
local telescope_builtin = require "telescope/builtin"

local M = {}

function M.on_attach(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<leader>sf", function() telescope_builtin.lsp_workspace_symbols {} end, bufopts)
  vim.keymap.set("n", "<leader>D", function() telescope_builtin.lsp_type_defeinitions {} end, bufopts)
  vim.keymap.set("n", "<leader>sr", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>sl", function() telescope_builtin.lsp_document_symbols {} end, bufopts)
  vim.keymap.set("n", "gr", function() telescope_builtin.lsp_references {} end, bufopts)
  vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, bufopts)

  lsp_status.on_attach(client)
end

return M

