local Plug = vim.fn["plug#"]

vim.fn["plug#begin"](vim.fn.stdpath("data") .. "/plugged")

-- Colorz
Plug("sonph/onehalf", { rtp = "vim" })
Plug "kergoth/vim-hilinks"

-- Syntaxes
Plug "1995parham/vim-spice"
Plug "Dridus/nc.vim"
Plug "elzr/vim-json"
Plug "hashivim/vim-terraform"
Plug "LnL7/vim-nix"
Plug "neovimhaskell/haskell-vim"
Plug "rust-lang/rust.vim"

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
Plug "vim-airline/vim-airline"
Plug "vim-airline/vim-airline-themes"
Plug "simnalamburt/vim-mundo"

vim.fn["plug#end"]()