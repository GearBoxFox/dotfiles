-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Menubar library
local menubar = require("menubar")

-- Resource Configuration
-- local modkey = RC.user.modkey
local modkey = "Mod4"
local shiftkey = RC.vars.shiftkey
local controlkey = RC.vars.ctrlkey

local terminal = RC.vars.terminal

--Custom Widgets
local brightness_osd = require("popups.osds.brightness_osd")
local volume_osd = require("popups.osds.volume_osd")
local powermenu = require("popups.powermenu.main")

-- Local helper functions
local helpers = require("helpers")

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
----------------------------
--Volume Osd functionality--
----------------------------
-- timer
local volume_timer = gears.timer {
	timeout = 2,
	autostart = true,
	callback = function()
		volume_osd.visible = false
	end
}

volume_osd:connect_signal("mouse::enter", function()
	volume_timer:stop()      -- Stop the timer when the mouse enters the dock
	volume_osd.visible = true -- Show the dock immediately
end)

-- Attach the timer to a signal that triggers when the mouse leaves the dock
volume_osd:connect_signal("mouse::leave", function()
	volume_timer:again() -- Restart the timer when the mouse leaves the dock
end)

-------------------------------
--Brightness Osd functionality-
-------------------------------
local brightness_timer = gears.timer {
	timeout = 2,
	autostart = true,
	callback = function()
		brightness_osd.visible = false
	end
}

brightness_osd:connect_signal("mouse::enter", function()
	brightness_timer:stop()      -- Stop the timer when the mouse enters the dock
	brightness_osd.visible = true -- Show the dock immediately
end)

-- Attach the timer to a signal that triggers when the mouse leaves the dock
brightness_osd:connect_signal("mouse::leave", function()
	brightness_timer:again() -- Restart the timer when the mouse leaves the dock
end)


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
	local globalkeys = gears.table.join(

		awful.key {
			modifiers   = { modkey },
			key         = 's',
			description = 'Show Keybindings',
			group       = 'awesome',
			on_press    = hotkeys_popup.show_help
		},


		----------------------------------
		--Tag Switching-------------------
		----------------------------------

		-- Go to previous tag by index
		awful.key {
			modifiers   = { modkey },
			key         = "q",
			description = 'view previous',
			group       = 'tag',
			on_press    = awful.tag.viewprev
		},

		-- Go to next tag by index
		awful.key {
			modifiers   = { modkey },
			key         = "w",
			description = 'view next',
			group       = 'tag',
			on_press    = awful.tag.viewnext
		},

		-- Go to previously focused tag
		awful.key {
			modifiers   = { modkey },
			key         = "Escape",
			description = 'go back',
			group       = 'tag',
			on_press    = awful.tag.history.restore
		},


		----------------------------------
		--Window focus switch-------------
		----------------------------------

		-- Focus next window right
		awful.key {
			modifiers   = { modkey },
			key         = 'Right',
			description = 'focus next right',
			group       = 'client focus',
			on_press    = function()
				awful.client.focus.bydirection("right")
			end,
		},

		-- Focus next window left
		awful.key {
			modifiers   = { modkey },
			key         = 'Left',
			description = 'focus next left',
			group       = 'client focus',
			on_press    = function()
				awful.client.focus.bydirection("left")
			end,
		},

		-- Focus next window up
		awful.key {
			modifiers   = { modkey },
			key         = 'Up',
			description = 'focus next up',
			group       = 'client focus',
			on_press    = function()
				awful.client.focus.bydirection("up")
			end,
		},

		-- Focus next window down
		awful.key {
			modifiers   = { modkey },
			key         = 'Down',
			description = 'focus next down',
			group       = 'client focus',
			on_press    = function()
				awful.client.focus.bydirection("down")
			end,
		},

		-- Focus urgent window
		awful.key {
			modifiers   = { modkey },
			key         = 'u',
			description = 'focus urgent window',
			group       = 'client focus',
			on_press    = awful.client.urgent.jumpto
		},

		-- Focus previously focused window
		awful.key {
			modifiers   = { modkey },
			key         = 'Tab',
			description = 'go back',
			group       = 'client focus',
			on_press    = function()
				awful.client.focus.history.previous()
				if client.focus then
					client.focus:raise()
				end
			end
		},

		-----------------------------------------
		-- Open right click menu-----------------
		-----------------------------------------
		awful.key {
			modifiers   = { modkey },
			key         = 'e',
			description = 'show right click menu',
			group       = 'awesome',
			on_press    = function()
				RC.mainmenu:show()
				-- awful.spawn("gpick -s -o")
			end,
		},

		-----------------------------------------
		-- Window manipulation-------------------
		-----------------------------------------

		awful.key {
			modifiers   = { modkey, shiftkey },
			key         = 'j',
			description = 'Swap with next client by index',
			group       = 'client move',
			on_press    = function()
				awful.client.swap.byidx(1)
			end,
		},

		awful.key {
			modifiers   = { modkey, "Shift" },
			key         = 'k',
			description = 'Swap with previous client by index',
			group       = 'client move',
			on_press    = function()
				awful.client.swap.byidx(-1)
			end,
		},

		-- Increase window width
		awful.key {
			modifiers   = {modkey, shiftkey},
			key         = "Right",
			description = 'Decrease the window width',
			group       = 'client resize',
			on_press    = function()
				helpers.resize_dwim(client.focus, "right")
			end,
		},

		-- Decreases window width
		awful.key {
			modifiers   = {modkey, shiftkey},
			key         = "Left",
			description = 'Decrease the window width',
			group       = 'client resize',
			on_press    = function()
				helpers.resize_dwim(client.focus, "left")
			end,
		},

		-- Increase window height
		awful.key {
			modifiers   = {modkey, shiftkey},
			key         = "Up",
			description = 'Decrease the window height',
			group       = 'client resize',
			on_press    = function()
				helpers.resize_dwim(client.focus, "up")
			end,
		},

		-- Decreases window height
		awful.key {
			modifiers   = {modkey, shiftkey},
			key         = "Down",
			description = 'Decrease the window heigt',
			group       = 'client resize',
			on_press    = function()
				helpers.resize_dwim(client.focus, "down")
			end,
		},

		-- Move windows right
		awful.key {
			modifiers   = {modkey, controlkey},
			key         = "Right",
			description = 'Decrease the window width',
			group       = 'client resize',
			on_press    = function()
				helpers.move_client_dwim(client.focus, "right")
			end,
		},

		-- Move windows left
		awful.key {
			modifiers   = {modkey, controlkey},
			key         = "Left",
			description = 'Decrease the window width',
			group       = 'client resize',
			on_press    = function()
				helpers.move_client_dwim(client.focus, "left")
			end,
		},

		-- Move windows up
		awful.key {
			modifiers   = {modkey, controlkey},
			key         = "Up",
			description = 'Decrease the window height',
			group       = 'client resize',
			on_press    = function()
				helpers.move_client_dwim(client.focus, "up")
			end,
		},

		-- Move windows down
		awful.key {
			modifiers   = {modkey, controlkey},
			key         = "Down",
			description = 'Decrease the window heigt',
			group       = 'client resize',
			on_press    = function()
				helpers.move_client_dwim(client.focus, "down")
			end,
		},

		------------------------------------
		--Screen Switching------------------
		------------------------------------
		awful.key {
			modifiers   = { modkey, controlkey },
			key         = 'j',
			description = 'Focus next screen',
			group       = 'screen',
			on_press    = function()
				awful.screen.focus_relative(1)
			end,
		},

		awful.key {
			modifiers   = { modkey, controlkey },
			key         = 'k',
			description = 'Focus previous screen',
			group       = 'screen',
			on_press    = function()
				awful.screen.focus_relative(-1)
			end,
		},

		-----------------------------------------
		-- Standard program----------------------
		-----------------------------------------

		--Open terminal
		awful.key {
			modifiers   = { modkey },
			key         = 'Return',
			description = 'Open a terminal',
			group       = 'launcher',
			on_press    = function()
				awful.spawn(terminal)
			end,
		},

		-----------------------------------------
		-- Reload and Quit-----------------------
		-----------------------------------------

		-- Reload awesome
		awful.key {
			modifiers   = { modkey, controlkey },
			key         = 'r',
			description = 'reload awesome',
			group       = 'awesome',
			on_press    = function()
				awesome.restart()
			end,
		},

		--Toggle powermenu
		awful.key {
			modifiers   = { modkey, "Shift" },
			key         = 'c',
			description = 'Powermenu',
			group       = 'awesome',
			on_press    = function()
				powermenu.visible = not powermenu.visible
			end,
		},

		--Lock Screen
		awful.key {
			modifiers   = { modkey, shiftkey },
			key         = 's',
			description = 'Lockscreen',
			group       = 'awesome',
			on_press    = function()
				awesome.emit_signal("screen::lock")
			end,
		},

		-- Brightness Control
		awful.key {
			modifiers   = {},
			key         = "XF86MonBrightnessUp",
			description = 'Brightness Up',
			group       = 'hotkeys',
			on_press    = function()
				awful.spawn("light -A 5")
				brightness_osd.visible = true
				brightness_timer:again()
			end,
		},

		awful.key {
			modifiers   = {},
			key         = "XF86MonBrightnessDown",
			description = 'Brightness Down',
			group       = 'hotkeys',
			on_press    = function()
				awful.spawn("light -U 5")
				brightness_osd.visible = true
				brightness_timer:again()
			end,
		},

		---------------------------------
		-- Audio Controls----------------
		---------------------------------


		awful.key {
			modifiers   = {},
			key         = "XF86AudioRaiseVolume",
			description = 'volume up',
			group       = 'hotkeys',
			on_press    = function()
				awful.spawn("amixer set Master 5%+")
				volume_osd.visible = true
				volume_timer:again()
			end,
		},

		awful.key {
			modifiers   = {},
			key         = "XF86AudioLowerVolume",
			description = 'volume down',
			group       = 'hotkeys',
			on_press    = function()
				awful.spawn("amixer set Master 5%-")
				volume_osd.visible = true
				volume_timer:again()
			end,
		},

		awful.key {
			modifiers   = {},
			key         = "XF86AudioMute",
			description = 'togglemute',
			group       = 'hotkeys',
			on_press    = function()
				awful.spawn("amixer -q set Master toggle")
			end,
		},


		--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
		-- Layout manipulation
		awful.key({ modkey, shiftkey }, "h", function()
			awful.tag.incnmaster(1, nil, true)
		end, { description = "increase the number of master clients", group = "layout" }),
		awful.key({ modkey, shiftkey }, "l", function()
			awful.tag.incnmaster(-1, nil, true)
		end, { description = "decrease the number of master clients", group = "layout" }),
		awful.key({ modkey, controlkey }, "h", function()
			awful.tag.incncol(1, nil, true)
		end, { description = "increase the number of columns", group = "layout" }),
		awful.key({ modkey, controlkey }, "l", function()
			awful.tag.incncol(-1, nil, true)
		end, { description = "decrease the number of columns", group = "layout" }),
		awful.key({ modkey }, "space", function()
			awful.layout.inc(1)
		end, { description = "select next", group = "layout" }),
		awful.key({ modkey, shiftkey }, "space", function()
			awful.layout.inc(-1)
		end, { description = "select previous", group = "layout" }),

		awful.key({ modkey, controlkey }, "n", function()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:emit_signal("request::activate", "key.unminimize", { raise = true })
			end
		end, { description = "restore minimized", group = "client" }),

		--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
		awful.key(
			{ modkey }, "d", function()
				awesome.emit_signal("widget::launcher")
			end,
			{ description = "show launcher", group = "awesome" }
		),

		-- ScreenShot
		awful.key({ "Mod1" }, "Print", function()
			awful.util.spawn("cd Pictures && scrot")
		end, { description = "take a screenshot", group = "screenshots" }),

		--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

		-- Toggle Dock
		awful.key({ "Mod4" }, "z", function()
				dock.visible = not dock.visible
				dock2.visible = not dock2.visible
			end,
			{ description = "Toggle Dock", group = "custom" }),

		--Toggle control_center
		awful.key({ "Mod4" }, "x", function() control_center.visible = not control_center.visible end,
			{ description = "Open Control Center", group = "custom" }),


		-- Menubar
		awful.key({ modkey }, "p", function()
			menubar.show()
		end, { description = "show the menubar", group = "launcher" })
	)

	return globalkeys
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, {
	__call = function(_, ...)
		return _M.get(...)
	end,
})
