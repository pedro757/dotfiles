if not pcall(require, "lualine") then
  return
end
if not pcall(require, "colorbuddy") then
  return
end
if not pcall(require, "noirbuddy") then
  return
end

local noirbuddy_lualine = require "noirbuddy.plugins.lualine"
-- local theme = noirbuddy_lualine.theme
local inactive_sections = noirbuddy_lualine.inactive_sections

local c = require("noirbuddy.colors").all()

local theme = {
  normal = {
    a = { fg = c.noir_2, bg = c.noir_8 },
    b = { fg = c.noir_3, bg = c.noir_9 },
    c = { fg = c.noir_3, bg = c.noir_8 },
  },
  insert = { a = { fg = c.background, bg = c.noir_2 } },
  visual = { a = { fg = c.background, bg = c.diagnostic_warning } },
}


require("lualine").setup {
  options = {
    theme = theme,
    icons_enabled = true,
    component_separators = "",
    section_separators = "",
  },
  sections = {
    lualine_a = { { "filename", path = 1, color = { bg = c.noir7 } } },
    lualine_c = {
      { "branch", color = { bg = c.noir7 } },
      { "diff", color = { bg = c.noir7 } },
      { "diagnostics", color = { bg = c.noir7 } },
    },
    lualine_b = {},
    lualine_y = {},
    lualine_x = { { "progress", color = { bg = c.noir7 } } },
    lualine_z = { { "location", color = { bg = c.noir7 } } },
  },
  inactive_sections = inactive_sections,
}

--[[{
  background = "#121212",
  diagnostic_error = "#ff0038",
  diagnostic_hint = "#47eae0",
  diagnostic_info = "#47eae0",
  diagnostic_warning = "#ff7700",
  diff_add = "#00ff77",
  diff_change = "#47eae0",
  diff_delete = "#ff0038",
  gray0 = "#111111",
  gray1 = "#282a2e",
  gray2 = "#373b41",
  gray3 = "#969896",
  gray4 = "#b4b7b4",
  gray5 = "#c5c8c6",
  gray6 = "#e0e0e0",
  gray7 = "#ffffff",
  noir_0 = "#ffffff",
  noir_1 = "#f5f5f5",
  noir_2 = "#d5d5d5",
  noir_3 = "#b4b4b4",
  noir_4 = "#a7a7a7",
  noir_5 = "#949494",
  noir_6 = "#737373",
  noir_7 = "#535353",
  noir_8 = "#323232",
  noir_9 = "#212121",
  none = "none",
  primary = "#ff0088",
  secondary = "#d5d5d5"
}

]]
