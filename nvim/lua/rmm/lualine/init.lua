local gitsigns_head = require("rmm/lualine/gitsigns_head")
local gitsigns_diff = require("rmm/lualine/gitsigns_diff")
local lsp_status = require("lsp-status")

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "onedark",
    component_separators = { left = "\u{E0B5}", right = "\u{E0B7}" },
    section_separators = { left = "\u{E0B4}", right = "\u{E0B6}" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { { gitsigns_head } },
    lualine_c = {
      "filename",
      "require'lsp-status'.status()"
    },
    lualine_x = {
      "diagnostics",
      { gitsigns_diff }
    },
    lualine_y = { "fileformat", "encoding", "filetype" },
    lualine_z = { "progress", "location" }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { { gitsigns_head } },
    lualine_c = { "filename" },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "progress", "location" }
  },
  tabline = {
  },
  extensions = {
    "fugitive",
    "fzf",
    "man",
    "mundo",
    "quickfix"
  }
}

