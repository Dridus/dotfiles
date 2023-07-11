require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "c",
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
