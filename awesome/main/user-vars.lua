local home = os.getenv("HOME")

local _M = {
    -- This is used later as the default terminal and editor to run.
    terminal = "alacritty",
    browser = "firefox",
    file_manager = "dolphine",
    editor = os.getenv("EDITOR") or "code",
    editor_cmd = "alacritty code",

    modkey = "Mod4",
    shiftkey = "Shift",
    ctrlkey = "Control",

    wallpaper = home .. "/.config/awesome/wallpapers/jjkItadori.png"
}

return _M
