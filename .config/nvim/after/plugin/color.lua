if not pcall(require, "colorbuddy") then
  return
end

local _Color, colors, Group, groups, _styles = require('colorbuddy').setup {}

Group.new('LspReferenceText', nil, colors.gray1)
Group.new('LspReferenceRead', nil, colors.gray1)
Group.new('LspReferenceWrite', nil, colors.gray1)

Group.new('FloatBorder', groups.Normal, nil)
Group.new('NormalFloat', groups.Normal, nil)
