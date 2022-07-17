local gitsigns_head = require("rmm/lualine/gitsigns_head") 
local gitsigns_diff = require("rmm/lualine/gitsigns_diff") 

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "onedark",
    component_separators = { left = "\u{E0B5}", right = "\u{E0B7}" },
    -- component_separators = { left = "%246F\u{E0B5}", right = "%246F\u{E0B7}" },
    section_separators = { left = "\u{E0B4}", right = "\u{E0B6}" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { { gitsigns_head } },
    lualine_c = { "filename" },
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
    lualine_a = {
      {
        "buffers",
        mode = 2,
        show_filename_only = false,
        symbols = {
          modified = " \u{f8ea} ",
          alternate_file = " \u{f811} ",
          directory = " \u{f755} "
        }
      }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}

  },
  extensions = {
    "fugitive",
    "fzf",
    "man",
    "mundo",
    "quickfix"
  }
}

for n = 1, 9 do
  vim.keymap.set(
    "n", "<leader>" .. n,
    ":LualineBuffersJump " .. n .. "<cr>",
    { desc = "Jump to buffer " .. n }
  )
end

