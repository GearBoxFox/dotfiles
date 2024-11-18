-- Standard awesome library
local gears = require("gears")
local awful     = require("awful")

-- Wibox handling library
local wibox = require("wibox")

-- Custom Local Library: Common Functional Decoration
local deco = {
  wallpaper = require("deco.wallpaper"),
  taglist   = require("deco.taglist"),
  tasklist  = require("deco.tasklist")
}

local batteryarc_widget = require("deco.statusbar.batteryarc")

local taglist_buttons  = deco.taglist()
local tasklist_buttons = deco.tasklist()

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local tag_colors_empty = { "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000", "#00000000" }

local tag_colors_urgent = { x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground, x.foreground }

local tag_colors_focused = {
    x.color1.."fd",
    x.color5.."fd",
    x.color4.."fd",
    x.color6.."fd",
    x.color2.."fd",
    x.color3.."fd",
    x.color1.."fd",
    x.color5.."fd",
    x.color4.."fd",
    x.color6.."fd",
}

local tag_colors_occupied = {
    x.color1.."55",
    x.color5.."55",
    x.color4.."55",
    x.color6.."55",
    x.color2.."55",
    x.color3.."55",
    x.color1.."55",
    x.color5.."55",
    x.color4.."55",
    x.color6.."55",
}

-- Helper function that updates a taglist item
local update_taglist = function (item, tag, index)
  if tag.selected then
      item.bg = tag_colors_focused[index]
  elseif tag.urgent then
      item.bg = tag_colors_urgent[index]
  elseif #tag:clients() > 0 then
      item.bg = tag_colors_occupied[index]
  else
      item.bg = tag_colors_empty[index]
  end
end

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock(
  '<span color="' .. "#ffffff" .. '" font="Ubuntu Nerd Font Bold 13"> %a %b %d, %H:%M </span>', 10
)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
    layout = {
        spacing = 10,
        spacing_widget = {
            color  = '#30303045',
            shape  = gears.shape.line,
            widget = wibox.widget.separator,
        },
        layout = wibox.layout.flex.horizontal,
    },
    widget_template = {
        widget = wibox.container.background,
        create_callback = function(self, tag, index, _)
            update_taglist(self, tag, index)
        end,
        update_callback = function(self, tag, index, _)
            update_taglist(self, tag, index)
        end,
    }
  }

  -- battery widget
  local battery_widget = batteryarc_widget({
    show_current_level = true,
    arc_thickness = 3,
    size = 26,
    font = "Ubuntu Nerd Font Bold 10",
    margins = 55,
    timeout = 10,
  })

  -- Create the wibox
  s.mywibox = awful.wibar({ 
    position = "top", 
    screen = s,
    visible = true,
    ontop = false,
    type = "dock",
    bg = "#ffffff45"
  })

  --Spacer
  local separator = wibox.widget.textbox("     ")

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mylayoutbox,
      separator,
    },
    s.mytaglist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      separator,
      mykeyboardlayout,
      wibox.widget.systray(),
      mytextclock,
      battery_widget,
    },
  }
end)
-- }}}
