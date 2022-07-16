local fzf = require "rmm/fzf"
local util = require "rmm/util"

vim.keymap.set(
  "n", "<Leader>.",
  function()
    vim.fn["fzf#run"] {
      ["sink*"] = fzf.handle_fzf_files,
      source = "fd --type f",
      options = util.list_concat(fzf.filepreview_fd_fzf_opts, fzf.multi_fzf_opts)
    }
  end,
  { desc = "Find files by name under the current CWD" }
)

vim.keymap.set(
  "n", "<Leader>f.",
  function()
    local dir = vim.fn.expand("%:h") 
    if dir == "" then dir = "." end
    vim.fn["fzf#run"] {
      ["sink*"] = fzf.handle_fzf_files,
      source = "fd --type f --search-path " .. vim.fn.shellescape(dir),
      options = util.list_concat(fzf.filepreview_fd_fzf_opts, fzf.multi_fzf_opts)
    }
  end,
  { desc = "Find files by name under the current file's directory" }
)

vim.keymap.set(
  "n", "<Leader>fr",
  function()
    local candidates = {}
    local offset = 1

    for i = 1, vim.fn.bufnr("$") do
      if vim.fn.buflisted(i) then
        candidates[offset] = vim.fn.bufname(i)
        offset = offset + 1
      end
    end

    for i = 1, #vim.v.oldfiles do
      local fn = vim.v.oldfiles[i]
      if
        string.match(fn, "^fugitive:") or
        string.match(fn, "^term:") or
        string.match(fn, "^NERD_tree") or
        string.match(fn, "^/tmp") or
        string.match(fn, "^.git")
        then
        else
          candidates[offset] = fn
          offset = offset + 1
        end
    end

    vim.fn["fzf#run"] {
      ["sink*"] = fzf.handle_fzf_files,
      source = candidates,
      options = util.list_concat(fzf.filepreview_fd_fzf_opts, fzf.multi_fzf_opts)
    }
  end,
  { desc = "Find recently opened files and buffers" }
)

vim.keymap.set(
  "n", "<Leader>ss",
  function()
    local res = {}
    local lines = vim.fn.getline(0, vim.fn.line("$"))

    for i = 1, #lines do
      res[i] = i .. ":" .. lines[i]
    end

    vim.fn["fzf#run"] {
      sink = function(line)
        vim.cmd(string.match(line, "^([^:]+):"))
      end,
      source = res,
      options = {
        "--no-multi",
        "--no-sort",
        "--delimiter", ":",
        "--nth", "2.."
      }
    }
  end,
  { desc = "Find lines in the current file" }
)

local function fzf_lines_in_files(ask_for_options, sink)
  return function()
    local options = ""
    if ask_for_options then options = vim.fn.input("options: ") end
    local query = vim.fn.input("query: ")
    vim.fn["fzf#run"]({
      ["sink*"] = sink,
      source =
        util.shellopts(util.list_concat({"rg"}, fzf.rg_opts)) ..
        " " .. options ..
        " -e " .. vim.fn.shellescape(query),
      options = util.list_concat(fzf.rg_fzf_opts, fzf.filepreview_rg_fzf_opts, fzf.multi_fzf_opts)
    })
  end
end

vim.keymap.set(
  "n", "<Leader>?",
  fzf_lines_in_files(true, fzf.handle_fzf_files),
  { desc = "Recursively search the CWD with rg, and prompt for additional options" }
)

vim.keymap.set(
  "n", "<Leader>/",
  fzf_lines_in_files(false, fzf.handle_fzf_files),
  { desc = "Recursively search the CWD with rg" }
)

vim.keymap.set(
  "n", "<Leader>f?",
  fzf_lines_in_files(true, fzf.handle_fzf_files_qf),
  { desc = [[
      Recursively search the CWD with rg, prompt for additional
      options, and collect the results in quickfix
    ]] }
)
vim.keymap.set(
  "n", "<Leader>f/",
  fzf_lines_in_files(false, fzf.handle_fzf_files_qf),
  { desc = "Recursively search the CWD with rg, and collect the results in quickfix" }
)

vim.keymap.set(
  "n", "<Leader>bb",
  function()
    local buffers = vim.api.nvim_exec("buffers", true)
    local buffer_lines = vim.split(buffers, "\n")
    vim.fn["fzf#run"]({
      sink = function(line)
        vim.cmd("buffer " .. string.match(line, "^ *(%d+)"))
      end,
      source = buffer_lines,
      options = { "--no-multi" }
    })
  end,
  { desc = "Find open buffers" }
)

vim.keymap.set(
  "n", "<Leader>hs",
  function()
    local candidates = {}
    local tagsfiles = vim.fn.globpath(vim.o.runtimepath, "doc/tags", false, true)
    for i = 1, #tagsfiles do
      vim.list_extend(candidates, vim.fn.readfile(tagsfiles[i]))
    end
    vim.fn["fzf#run"]({
      sink = function(line)
        vim.cmd("help " .. string.match(line, "^([^\t]+)"))
      end,
      source = candidates
    })
  end,
  { desc = "Find help" }
)
