local util = require "rmm/util"

local M = {}

M.rg_opts = {
  "--line-number",
  "--column",
  "--no-messages",
  "--color=always"
}

M.rg_fzf_opts = {
  "--ansi",
  "--delimiter", ":",
  "--nth", "1,4.."
}

M.filepreview_fd_fzf_opts = {
  [1] = "--preview=bat " ..
    "--color=always " ..
    "--style=numbers " ..
    "--line-range=:$FZF_PREVIEW_LINES {+}"
}

M.filepreview_rg_fzf_opts = {
  [1] = "--preview=bat-fzf-preview {2} {+1}"
}

M.multi_fzf_opts = {
  "--multi",
  "--expect=ctrl-t,ctrl-v,ctrl-x",
  "--bind=ctrl-a:select-all,ctrl-d:deselect-all",
  "--color=hl:68,hl+:110"
}

function M.handle_fzf_files_gen(lines)
  if #lines < 2 then
    return
  end

  local cmds = {
    ["ctrl-x"] = "split",
    ["ctrl-v"] = "vertical split",
    ["ctrl-t"] = "tabedit"
  }
  local cmd = cmds[lines[1]] or "edit"
  local hits = {}
  for i = 2, #lines do
    hits[i-1] = util.parse_file_line_column(lines[i])
  end
  return cmd, hits
end

function M.handle_fzf_files(lines)
  local cmd, hits = M.handle_fzf_files_gen(lines)
  for i = 1, #hits do
    util.visit_hit(cmd, hits[i])
  end
end

function M.handle_fzf_files_qf(lines)
  local cmd, hits = M.handle_fzf_files_gen(lines)
  util.visit_hit(cmd, hits[1])
  vim.fn.setqflist(hits)
end

return M
