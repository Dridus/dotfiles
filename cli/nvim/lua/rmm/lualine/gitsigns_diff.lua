local lualine_utils = require("lualine.utils.utils")

local M = require("lualine.component"):extend()

local function get_colors()
  return {
    added = {
      fg = lualine_utils.extract_color_from_hllist(
        'fg',
        { 'GitSignsAdd', 'GitGutterAdd', 'DiffAdded', 'DiffAdd' },
        '#90ee90'
      ),
    },
    changed = {
      fg = lualine_utils.extract_color_from_hllist(
        'fg',
        { 'GitSignsChange', 'GitGutterChange', 'DiffChanged', 'DiffChange' },
        '#f0e130'
      ),
    },
    removed = {
      fg = lualine_utils.extract_color_from_hllist(
        'fg',
        { 'GitSignsDelete', 'GitGutterDelete', 'DiffRemoved', 'DiffDelete' },
        '#ff0038'
      ),
    },
  }
end

local symbols = {
  added = "\u{f918} ",
  changed = "\u{f6c1} ",
  removed = "\u{f876} "
}

function M:init(options)
  M.super.init(self, options)
  local colors = get_colors()
  self.highlights = {
    added = self:create_hl(colors.added, 'added'),
    changed = self:create_hl(colors.changed, 'changed'),
    removed = self:create_hl(colors.removed, 'removed'),
  }
end

function M:update_status(is_focused)
  local status = vim.b.gitsigns_status_dict

  if status == nil then
    return ""
  end

  local colors = {}
  for name, highlight_name in pairs(self.highlights) do
    colors[name] = self:format_hl(highlight_name)
  end

  local result = {}
  for _, name in ipairs { "added", "changed", "removed" } do
    if status[name] and status[name] > 0 then
      table.insert(result, colors[name] .. symbols[name] .. status[name])
    end
  end
  if #result > 0 then
    return table.concat(result, " ")
  else
    return ""
  end
end

return M
