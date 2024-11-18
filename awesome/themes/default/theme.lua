---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi

local home = os.getenv("HOME")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir() .. ""

local theme = {}

theme.font          = "CaskaydiaCove Nerd Font 12"

theme.bg_dark       = x.background
theme.bg_normal     = x.color0
theme.bg_focus      = x.color8
theme.bg_urgent     = x.color8
theme.bg_minimize   = x.color8
theme.bg_systray    = x.background

theme.fg_normal     = x.color8
theme.fg_focus      = x.color4
theme.fg_urgent     = x.color9
theme.fg_minimize   = x.color8

theme.useless_gap         = dpi(5)
theme.border_width        = dpi(5)
theme.border_color_normal = x.color2
theme.border_color_active = x.color4
theme.border_color_marked = x.color4


--Default wallpaper
theme.wallpaper = os.getenv("HOME") .. "/.config/awesome/wallpapers/wallpaper.png"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Other Taglist settings
theme.taglist_spacing             = 0
theme.taglist_shape_border_width  = 0
theme.taglist_shape_border_radius = 20
theme.taglist_shape_border_color  = "#00000040"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

--Close Button
theme.titlebar_close_button_normal                    = "~/.config/awesome/themes/default/titlebar_icons/inactive.png"
theme.titlebar_close_button_focus                     = "~/.config/awesome/themes/default/titlebar_icons/close.png"
theme.titlebar_close_button_normal_hover              = "~/.config/awesome/themes/default/titlebar_icons/close_hover.png"
theme.titlebar_close_button_focus_hover               = "~/.config/awesome/themes/default/titlebar_icons/close_hover.png"

--Maximized Button
theme.titlebar_maximized_button_normal_inactive       = "~/.config/awesome/themes/default/titlebar_icons/inactive.png"
theme.titlebar_maximized_button_focus_inactive        = "~/.config/awesome/themes/default/titlebar_icons/maximize.png"
theme.titlebar_maximized_button_normal_active         = "~/.config/awesome/themes/default/titlebar_icons/inactive.png"
theme.titlebar_maximized_button_focus_active          = "~/.config/awesome/themes/default/titlebar_icons/maximize.png"
theme.titlebar_maximized_button_normal_inactive_hover =
"~/.config/awesome/themes/default/titlebar_icons/maximize-hover.png"
theme.titlebar_maximized_button_focus_inactive_hover  =
"~/.config/awesome/themes/default/titlebar_icons/maximize-hover.png"
theme.titlebar_maximized_button_normal_active_hover   =
"~/.config/awesome/themes/default/titlebar_icons/maximize-hover.png"
theme.titlebar_maximized_button_focus_active_hover    = "~/.config/awesome/themes/default/titlebar_icons/maximize-hover.png"

--Minimize Button
theme.titlebar_minimize_button_normal                 = "~/.config/awesome/themes/default/titlebar_icons/inactive.png"
theme.titlebar_minimize_button_focus                  = "~/.config/awesome/themes/default/titlebar_icons/minimize.png"
theme.titlebar_minimize_button_normal_hover           = "~/.config/awesome/themes/default/titlebar_icons/minimize_hover.png"

theme.titlebar_minimize_button_focus_hover            = "~/.config/awesome/themes/default/titlebar_icons/minimize_hover.png"



--Sticky Button
theme.titlebar_sticky_button_normal_inactive = "~/.config/awesome/themes/default/titlebar_icons/inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "~/.config/awesome/themes/default/titlebar_icons/pin.png"
theme.titlebar_sticky_button_normal_active   = "~/.config/awesome/themes/default/titlebar_icons/inactive.png"
theme.titlebar_sticky_button_focus_active    = "~/.config/awesome/themes/default/titlebar_icons/pin2.png"

-- Default layout icons
theme.layout_fairh                = "/usr/share/awesome/themes/default/layouts/fairhw.png"
theme.layout_fairv                = "/usr/share/awesome/themes/default/layouts/fairvw.png"
theme.layout_floating             = "/usr/share/awesome/themes/default/layouts/floatingw.png"
theme.layout_magnifier            = "/usr/share/awesome/themes/default/layouts/magnifierw.png"
theme.layout_max                  = "/usr/share/awesome/themes/default/layouts/maxw.png"
theme.layout_fullscreen           = "/usr/share/awesome/themes/default/layouts/fullscreenw.png"
theme.layout_tilebottom           = "/usr/share/awesome/themes/default/layouts/tilebottomw.png"
theme.layout_tileleft             = "/usr/share/awesome/themes/default/layouts/tileleftw.png"
theme.layout_tile                 = "/usr/share/awesome/themes/default/layouts/tilew.png"
theme.layout_tiletop              = "/usr/share/awesome/themes/default/layouts/tiletopw.png"
theme.layout_spiral               = "/usr/share/awesome/themes/default/layouts/spiralw.png"
theme.layout_dwindle              = "/usr/share/awesome/themes/default/layouts/dwindlew.png"
theme.layout_cornernw             = "/usr/share/awesome/themes/default/layouts/cornernw.png"
theme.layout_cornerne             = "/usr/share/awesome/themes/default/layouts/cornerne.png"
theme.layout_cornersw             = "/usr/share/awesome/themes/default/layouts/cornersw.png"
theme.layout_cornerse             = "/usr/share/awesome/themes/default/layouts/cornerse.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

---------------------------------------
-----Notifications---------------------
---------------------------------------
theme.notification_font                 = "Ubuntu Nerd Font 14"
theme.notification_fg                   = "#a9b1d6"
theme.notification_position             = 'top_right'
theme.notification_margin               = dpi(10)
theme.notification_border_width         = dpi(0)
theme.notification_spacing              = dpi(15)
theme.notification_icon_resize_strategy = 'center'
theme.notification_icon_size            = dpi(300)

--Shortcut key list popup theme
theme.hotkeys_font                      = "Ubuntu Nerd font bold 12"
theme.hotkeys_description_font          = "Ubuntu nerd font 12"
theme.hotkeys_group_margin              = dpi(20)
theme.hotkeys_modifiers_fg              = x.color1

--Theme
theme.font                              = "Ubuntu Nerd Font 14"
theme.icon_empty_notibox                = "~/.config/awesome/themes/mytheme/icons/mail-receive.svg"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
