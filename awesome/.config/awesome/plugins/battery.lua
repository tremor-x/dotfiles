local vicious    = require('vicious')
local wibox      = require('wibox')
local string     = { format = string.format }
local mybat      = wibox.widget.progressbar()
local batid      = "bat0"
local styles     = {
    background = "#df740c",
    border     = "#f58c4b",
    bottom     = "#6fc3df",
    top        = "#e6ffff"
}

local batwidget = wibox.widget {
    {
        {
            widget        = wibox.widget.textbox,
            forced_height = 18,
            valign        = 'center',
            markup        = string.format("<small>%s</small>", batid)
        },
        direction = 'east',
        layout = wibox.container.rotate
    },
    {
        {
            {
                widget        = mybat,
                max_value     = 1,
                border_width  = 0.4,
                border_color  = styles.border,
                forced_height = 5,
                color         = {
                    type = 'linear',
                    from = { 0, 0 },
                    to = { 15, 1 },
                    stops = {
                        { 0, styles.bottom },
                        { 1, styles.top }
                    }
                }
            },
            direction = 'east',
            layout = wibox.container.rotate
        },
        left = 0, right = 1, top = 1, bottom = 0,
        layout = wibox.container.margin
    },
    layout = wibox.layout.fixed.horizontal
}

mybat.background_color = styles.background
-- Register battery widget
vicious.register(mybat, vicious.widgets.bat, '$2', 30, batid)

return batwidget
