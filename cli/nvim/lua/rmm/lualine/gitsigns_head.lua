local M = require("lualine.component"):extend()

function M:init(options)
  M.super.init(self, options)
end

function M:update_status(is_focused)
  local head = vim.b.gitsigns_head

  if head == nil then
    return ""
  end

  return " " .. head
end

return M
