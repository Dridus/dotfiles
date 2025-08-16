require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "c",
    "corn",
    "cpp",
    "css",
    "go",
    "haskell",
    "hjson",
    "html",
    "javascript",
    "json",
    "lua",
    "nix",
    "proto",
    "python",
    "rust",
    "terraform",
    "vim",
    "yaml"
  },
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  }
}

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.corn"},
  callback = function()
    vim.bo.filetype = "corn"
  end
})
