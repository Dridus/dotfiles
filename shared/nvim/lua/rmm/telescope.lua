local telescope = require "telescope"

telescope.setup {
  defaults = {
    layout_strategy = "flex",
    layout_config  = {
      flex = {
        flip_columns = 220,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  },
}

telescope.load_extension("fzf")
