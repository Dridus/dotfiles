local builtin = require "telescope.builtin"
local utils = require "telescope.utils"

vim.keymap.set(
  "n", "<leader>.",
  function()
    builtin.find_files {
      find_command = { "fd", "--type", "f" },
    }
  end,
  { desc = "Find files by name under the current CWD" }
)

vim.keymap.set(
  "n", "<leader>f.",
  function()
    builtin.find_files {
      find_command = { "fd", "--type", "f" },
      cwd = utils.buffer_dir(),
    }
  end,
  { desc = "Find files by name under the current file's directory" }
)

vim.keymap.set(
  "n", "<leader>fr",
  function()
    builtin.oldfiles {
    }
  end,
  { desc = "Find recently opened files" }
)

vim.keymap.set(
  "n", "<leader>st",
  function()
    builtin.treesitter {
    }
  end,
  { desc = "Find symbols in the current buffer discovered by treesitter." }
)

vim.keymap.set(
  "n", "<leader>ss",
  function()
    builtin.current_buffer_fuzzy_find {
    }
  end,
  { desc = "Find lines in the current file" }
)

vim.keymap.set(
  "n", "<leader>gld",
  function()
    builtin.git_commits {
    }
  end,
  { desc = "Show commit log of the cwd." }
)

vim.keymap.set(
  "n", "<leader>glb",
  function()
    builtin.git_bcommits {
    }
  end,
  { desc = "Show commit log of the current buffer." }
)

vim.keymap.set(
  "n", "<leader>?",
  function()
    local glob = vim.fn.input("glob: ")
    local type = vim.fn.input("type: ")
    builtin.live_grep {
      glob_pattern = glob,
      type_filter = type,
    }
  end,
  { desc = "Recursively search the CWD with vimgrep, and prompt for glob/type" }
)

vim.keymap.set(
  "n", "<leader>/",
  function()
    builtin.live_grep {
    }
  end,
  { desc = "Recursively search the CWD with vimgrep" }
)

vim.keymap.set(
  "n", "<leader>r",
  function()
    builtin.resume {
    }
  end,
  { desc = "Resume the last fuzzy find." }
)

vim.keymap.set(
  "n", "<leader>bb",
  function()
    builtin.buffers {
      sort_lastused = true,
    }
  end,
  { desc = "Find open buffers" }
)

vim.keymap.set(
  "n", "<leader>hs",
  function()
    builtin.help_tags {
    }
  end,
  { desc = "Find help" }
)


