local Plug = vim.fn["plug#"]

vim.fn["plug#begin"](vim.fn.stdpath("data") .. "/plugged")

-- Colorz
Plug "navarasu/onedark.nvim"
Plug "kergoth/vim-hilinks"

-- Visualization
Plug "lukas-reineke/indent-blankline.nvim"
Plug "lewis6991/gitsigns.nvim"

-- Syntaxes
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
-- Plug "1995parham/vim-spice"
-- Plug "Dridus/nc.vim"
-- Plug "elzr/vim-json"
-- Plug "hashivim/vim-terraform"
-- Plug "LnL7/vim-nix"
-- Plug "neovimhaskell/haskell-vim"
-- Plug "rust-lang/rust.vim"

-- SCM
Plug "tpope/vim-fugitive"
Plug "kristijanhusak/vim-dirvish-git"
Plug "int3/vim-extradite"

-- Tools and navigation
Plug "junegunn/fzf"
Plug "justinmk/vim-dirvish"
Plug "moll/vim-bbye"
Plug "neomake/neomake"
Plug "vim-scripts/gitignore"

-- LSP and completion
Plug "neovim/nvim-lspconfig"
Plug "hrsh7th/cmp-nvim-lsp"
Plug "hrsh7th/cmp-buffer"
Plug "hrsh7th/cmp-path"
Plug "hrsh7th/cmp-cmdline"
Plug "hrsh7th/nvim-cmp"
Plug "L3MON4D3/LuaSnip"
Plug "saadparwaiz1/cmp_luasnip"

-- Text manipulation
Plug "michaeljsmith/vim-indent-object"
Plug "tpope/vim-commentary"
Plug "tpope/vim-repeat"
Plug "tpope/vim-surround"
Plug "vim-scripts/Align"

-- UI
Plug "kyazdani42/nvim-web-devicons"
Plug "nvim-lualine/lualine.nvim"
Plug "akinsho/bufferline.nvim"
Plug "simnalamburt/vim-mundo"

vim.fn["plug#end"]()
