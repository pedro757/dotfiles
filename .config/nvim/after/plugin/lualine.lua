if not pcall(require, "lualine") then
  return
end

local choco = "#291916"
local beige = "#A4895C"
local orange = "#FF8C00"
local light_brown = "#A67458"

local theme = {
  normal = {
    a = { fg = light_brown, bg = choco },
    b = { fg = light_brown, bg = choco },
    c = { fg = light_brown, bg = choco },
  },
  insert = { a = { fg = choco, bg = beige } },
  visual = { a = { fg = choco, bg = orange } },
}

require("lualine").setup {
  options = {
    theme = theme,
    icons_enabled = true,
    component_separators = "",
    section_separators = "",
  },
  sections = {
    lualine_a = { { "filename", path = 1 } },
    lualine_c = {
      { "branch", color = { bg = choco } },
      { "diff", color = { bg = choco } },
      { "diagnostics", color = { bg = choco } },
    },
    lualine_b = {},
    lualine_y = {},
    lualine_x = { { "progress", color = { bg = choco } } },
    lualine_z = { { "location", color = { bg = choco } } },
  },
}
