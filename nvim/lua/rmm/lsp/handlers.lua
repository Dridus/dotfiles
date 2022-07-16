local fzf = require "rmm/fzf"
local util = require "rmm/util"
local lsp_util = require "rmm/lsp/util"

vim.lsp.handlers["textDocument/documentSymbol"] = lsp_util.response_to_fzf(
  "document symbols",
  function(ctx)
    local fname = vim.fn.fnamemodify(vim.uri_to_fname(ctx.params.textDocument.uri), ":.")
    return string.format('Symbols in %s', fname)
  end
)

vim.lsp.handlers["workspace/symbol"] = lsp_util.response_to_fzf(
  lsp_util.symbols_to_lines,
  "symbols",
  function(ctx)
    return string.format("Symbols matching '%s'", ctx.params.query)
  end
)

local function location_handler(_, result, ctx, _)
  if result == nil or vim.tbl_isempty(result) then
    local _ = log.info() and log.info(ctx.method, 'No location found')
    return nil
  end
  local client = vim.lsp.get_client_by_id(ctx.client_id)

  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1], client.offset_encoding)

    if #result > 1 then
      vim.fn["fzf#run"] {
        ["sink*"] = fzf.handle_fzf_files,
        source = lsp_util.locations_to_lines(result, client.offset_encoding),
        options = util.list_concat(fzf.rg_fzf_opts, fzf.filepreview_rg_fzf_opts, fzf.multi_fzf_opts)
      }
    end
  else
    vim.lsp.util.jump_to_location(result, client.offset_encoding)
  end
end

vim.lsp.handlers["textDocument/declaration"] = location_handler
vim.lsp.handlers["textDocument/definition"] = location_handler
vim.lsp.handlers["textDocument/typeDefinition"] = location_handler
vim.lsp.handlers["textDocument/implementation"] = location_handler

vim.lsp.handlers["textDocument/references"] = function(_, result, ctx, config)
  if not result or vim.tbl_isempty(result) then
    vim.notify("No references found")
  else
    local client = vim.lsp.get_client_by_id(ctx.client_id)

    vim.fn["fzf#run"] {
      ["sink*"] = fzf.handle_fzf_files,
      source = lsp_util.locations_to_lines(result, client.offset_encoding),
      options = util.list_concat(fzf.rg_fzf_opts, fzf.filepreview_rg_fzf_opts, fzf.multi_fzf_opts)
    }
  end
end
