vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.rst",
  callback = function()
    vim.bo.shiftwidth = 3
    vim.bo.makeprg = "make html"
  end
})
