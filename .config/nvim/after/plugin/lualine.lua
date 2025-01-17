if not pcall(require, "lualine") then
  return
end

local choco = "#0C0C0C"
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
local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

require("lualine").setup {
  options = {
    theme = "auto",
    icons_enabled = true,
    component_separators = "",
    section_separators = "",
  },
  sections = {
    lualine_a = {
      {
        "macro-recording",
        fmt = show_macro_recording,
      },
      { "filename", path = 1 },
    },
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
