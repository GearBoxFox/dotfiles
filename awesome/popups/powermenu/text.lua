local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local text = wibox.widget {
  markup = '<span color="' .. x.color8 .. '" font="Ubuntu Nerd Font Bold 28">' .. " " .. '</span>',
  font = "Ubuntu Nerd Font Bold ",
  widget = wibox.widget.textbox,
  forced_width = dpi(1110),
  align = "center"
}

return text