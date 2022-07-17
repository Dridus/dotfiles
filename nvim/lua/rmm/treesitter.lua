require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "go",
    "haskell",
    "html",
    "javascript",
    "json",
    "lua",
    "nix",
    "proto",
    "python",
    "rust",
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
