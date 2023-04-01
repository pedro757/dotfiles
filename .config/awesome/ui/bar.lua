local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local gears = require "gears"

local bar = wibox {
  width = dpi(280),
  height = dpi(120),
  bg = beautiful.bg_normal,
  visible = false,
  ontop = true,
  shape = function(cr, width, height)
    gears.shape.rectangle(cr, width, height)
  end,
}

bar:setup {
  {
    {
      wibox.widget.textclock'<span font="Roboto Bold 18"> %a %b %dth, %H:%M </span>',
      height = dpi(40),
      strategy = "max",
      layout = wibox.layout.constraint,
    },
    margins = 16,
    layout = wibox.container.margin,
  },
  nil,
  {
    {
      wibox.widget.systray(),
      height = dpi(40),
      strategy = "max",
      layout = wibox.layout.constraint,
    },
    margins = 16,
    layout = wibox.container.margin,
  },
  layout = wibox.layout.align.vertical,
}

awesome.connect_signal("widget::bar", function()
  awful.placement.centered(bar)
  bar.visible = not bar.visible
end)

awesome.connect_signal("widget::bar::hide", function()
  awful.placement.centered(bar)
  bar.visible = false
end)
