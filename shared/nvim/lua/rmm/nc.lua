vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.mpf", "*.MPF", "*.spf", "*.SPF"},
  callback = function()
    vim.bo.syntax = "sinumerik"
  end
})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.ngc", "*.NGC"},
  callback = function()
    vim.bo.syntax = "linuxcnc"
  end
})
