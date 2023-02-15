if not pcall(require, "colorbuddy") then
  return
end

local Color, colors, Group, groups, styles = require('colorbuddy').setup {}

Group.new('LspReferenceText', nil, colors.gray1)
Group.new('LspReferenceRead', nil, colors.gray1)
Group.new('LspReferenceWrite', nil, colors.gray1)
