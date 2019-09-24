local vicious       = require("vicious")
vicious.contrib     = require("vicious.contrib")
local os            = { getenv = os.getenv }
local wibox	        = require("wibox")
local xresources    = require("beautiful.xresources")
local xrdb          = xresources.get_current_theme()
local awful         = require("awful")
local format        = string.format
local cmuswidget    = wibox.widget.textbox()
local cmus          = { widget = cmuswidget }

local cmus_socket = os.getenv("HOME") .. "/.config/cmus/socket"

vicious.register(cmuswidget, vicious.contrib.cmus, function (wid, args)
    return string.format("[<span color=%q>%s%s%s</span>] <span color=%q>%s > %s</span>",
            xrdb.color3,
            (args["{shuffle}"] == "on" and "S" or "-"),
            (args["{continue}"] == "on" and "C" or "-"),
            (args["{repeat}"] == "on" and "R" or "-"),
            (args["{status}"] == "playing" and xrdb.foreground or xrdb.color3),
            args["{artist}"],
            args["{title}"]
        )
--end)
end, 2, { host = cmus_socket } )

function cmus.stop()
    awful.util.spawn("cmus-remote --stop")
end
function cmus.toggle()
    awful.util.spawn("cmus-remote --pause")
end
function cmus.prev()
    awful.util.spawn("cmus-remote --prev")
end
function cmus.next()
    awful.util.spawn("cmus-remote --next")
end
function cmus.player()
    awful.util.spawn("xterm -title cmus -e cmus")
end

cmus.socket = cmus_socket

cmus.widget:buttons(awful.util.table.join(
    awful.button({ }, 4, cmus.next ),
    awful.button({ }, 5, cmus.prev ),
    awful.button({ }, 1, cmus.toggle )
))

return cmus
