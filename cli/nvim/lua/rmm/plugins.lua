local Plug = vim.fn["plug#"]

vim.fn["plug#begin"](vim.fn.stdpath("data") .. "/plugged")

-- Colorz
Plug "navarasu/onedark.nvim"
Plug "kergoth/vim-hilinks"

-- UI support
Plug "rcarriga/nvim-notify"

-- Visualization
Plug "lewis6991/gitsigns.nvim"

-- Syntaxes
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("rhaiscript/vim-rhai")

-- SCM
Plug "tpope/vim-fugitive"
Plug "kristijanhusak/vim-dirvish-git"

-- Tools and navigation
Plug "nvim-lua/plenary.nvim"
Plug("nvim-telescope/telescope.nvim", { tag = "0.1.4" })
Plug("nvim-telescope/telescope-fzf-native.nvim", { ["do"] = "make" })
Plug "justinmk/vim-dirvish"
Plug "moll/vim-bbye"
Plug "stevearc/overseer.nvim"
Plug "vim-scripts/gitignore"

-- LSP and completion
Plug "neovim/nvim-lspconfig"
Plug "tamago324/nlsp-settings.nvim"
Plug "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
Plug "nvim-lua/lsp-status.nvim"
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
Plug "Vonr/align.nvim"

-- UI
Plug("kyazdani42/nvim-web-devicons", { tag = "313d9e7193354c5de7cdb1724f9e2d3f442780b0" })
Plug "onsails/lspkind-nvim"
Plug "nvim-lualine/lualine.nvim"
Plug "stevearc/dressing.nvim"
Plug "ojroques/nvim-osc52"

vim.fn["plug#end"]()
