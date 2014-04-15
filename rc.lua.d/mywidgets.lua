
---------------------------------------------------------------
-- File:    mywidgets.lua     PersonalWidgets                --
-- Version:                                                  --
-- Author:  Abdó Roig<abdo.roig@gmail.com>                   --
---------------------------------------------------------------

-----------------------------------
-- Module loading                --
-----------------------------------

-- require("awful")
local capi  = { timer = timer }

local wibox = require("wibox")
local beautiful = beautiful

local os = os

-----------------------------------
-- Timers                        --
-----------------------------------

local timers = {}
timers.slow    = timer({ timeout = 60 })
timers.normal  = timer({ timeout = 10 })
timers.fast    = timer({ timeout = 2 })

function start_widgets()
    for _,t in pairs(timers) do
        t:start()
        t:emit_signal("timeout")
    end
end

function stop_widgets()
    for _,t in pairs(timers) do
        t:stop()
    end
end

-----------------------------------
-- Convenience stuff             --
-----------------------------------

local scount = screen.count()

local gradcols = {}
local gradcols_rev = {}
local num = #beautiful.color_widget_gradient

for i, col in ipairs(beautiful.color_widget_gradient) do
    gradcols[i] = col
    gradcols_rev[num-i+1] = col
end

myw = {}



-----------------------------------
-- Spacers                       --
-----------------------------------

myw.spacer = wibox.widget.textbox()
myw.spacer:set_markup("<span>   </span>")

myw.separator = wibox.widget.textbox()
myw.separator:set_markup(string.format("<span color='%s'>  |  </span>", beautiful.color_widget))



-----------------------------------
-- Hardware                      --
-----------------------------------

myw.hdw = {}

myw.hdw.icon = wibox.widget.textbox()
myw.hdw.icon:set_markup(string.format('<span color="%s" font="%s">⚙ </span>',
                                      beautiful.color_widget, beautiful.font_symbol))

myw.hdw.cpu  = require("abdo.widget.cpu")
myw.hdw.mem  = require("abdo.widget.mem")
myw.hdw.temp = require("abdo.widget.thermal")

myw.hdw.cpuwdg = wibox.widget.textbox()
myw.hdw.memwdg = wibox.widget.textbox()
myw.hdw.tempwdg = wibox.widget.textbox()

myw.hdw.cpuval = "?"
myw.hdw.memval = "?"
myw.hdw.tempval = '?'

function myw.hdw.update()
    local args = myw.hdw.cpu(nil)
    if args[1] ~= myw.hdw.cpuval then
        local color = util.gradient(gradcols, 0, 100, args[1])
        local text = string.format("<span color='%s'>%s%% </span>", color, args[1])
        myw.hdw.cpuval = args[1]
        myw.hdw.cpuwdg:set_markup(text)
    end

    local args = myw.hdw.temp(nil, {"coretemp.0", "core"})
    if args[1] ~= myw.hdw.tempval then
        local color = util.gradient(gradcols, 35, 70, args[1])
        local text = string.format("<span color='%s'>%sºC </span>", color, args[1])
        myw.hdw.tempval = args[1]
        myw.hdw.tempwdg:set_markup(text)
    end

    local args = myw.hdw.mem(nil)
    if args[1] ~= myw.hdw.memval then
        local color = util.gradient(gradcols, 0, 100, args[1])
        local text = string.format("<span color='%s'>%s%% </span>", color, args[1])
        myw.hdw.memval = args[1]
        myw.hdw.memwdg:set_markup(text)
    end
end

timers.fast:connect_signal("timeout", myw.hdw.update)



-----------------------------------
-- Network Usage                 --
-----------------------------------

myw.net = {}
myw.net.src = require("abdo.widget.net")

myw.net.dwdg = wibox.widget.textbox()
myw.net.uwdg = wibox.widget.textbox()

myw.net.icon = wibox.widget.textbox()
myw.net.icon:set_markup(string.format('<span color="%s" font="%s"> 🔄 </span>',
                                      beautiful.color_widget, beautiful.font_symbol))

myw.net.value = { up=-1, down=-1 }

function myw.net.update()
    local args = myw.net.src(nil)
    local up = 0.0
    local down = 0.0

    -- loop over all interfaces except loopback
    for k, v in pairs(args) do
        if not string.match(k, "{lo .*}") then
            if string.match(k, "{.* up_kb}") then
                up = up + v
            end

            if string.match(k, "{.* down_kb}") then
                down = down + v
            end
        end
    end

    if up ~= myw.net.value.up or down ~= myw.net.value.down then
        local uptxt = string.format('<span color="%s">%.0f</span>', beautiful.color_widget, up)

        local downtxt = string.format('<span color="%s">%.0f</span>', beautiful.color_widget, down)

        myw.net.dwdg:set_markup(downtxt)
        myw.net.uwdg:set_markup(uptxt)
    end
    myw.net.value.up = up
    myw.net.value.down = down
end

timers.fast:connect_signal("timeout", myw.net.update)



-----------------------------------
-- Mail                          --
-----------------------------------

myw.mail = {}
myw.mail.src = require("abdo.widget.mutag")

myw.mail.icon = wibox.widget.textbox()

myw.mail.outwdg = wibox.widget.textbox()
myw.mail.inwdg = wibox.widget.textbox()

myw.mail.tooltip = awful.tooltip({ objects = {myw.mail.icon, myw.mail.outwdg, myw.mail.inwdg}})

myw.mail.num_inbox = -1
myw.mail.num_queue = -1

function myw.mail.update()
    local args = myw.mail.src(nil)
    local mail = args[1]
    local num = #mail
    if num ~= myw.mail.num_inbox then
        local color = beautiful.color_widget

        -- Note: From miscelaneous symbols and pictographs. Not yet standard.
        local icon_empty = string.format('<span color="%s" weight="bold" font="%s"> 🖂 </span>',
                                         beautiful.color_widget, beautiful.font_symbol)

        local icon_full = string.format('<span color="%s" weight="bold" font="%s"> 🖄 </span>',
                                        beautiful_color_widget_alert, beautiful.font_symbol)

        local icon = icon_empty
        if num == nil then
            color = beautiful.color_widget_alert
            icon = icon_full
            num = "?"
        elseif num == 0 then
            color = beautiful.color_widget
            icon = icon_empty
        elseif num > 0 then
            color = beautiful.color_widget_alert
            icon = icon_full
        end

        local text = string.format("<span color='%s'>%s</span>",
                                   color, tostring(num))

        myw.mail.icon:set_markup(icon)
        myw.mail.inwdg:set_markup(text)
        myw.mail.num_inbox = num
    end

    local queue = args[2]
    local num = #queue
    if num ~= myw.mail.num_queue then
        local color = beautiful.color_widget
        if num == nil then
            color = beautiful.color_widget_alert
            num = "?"
        elseif num == 0 then
            color = beautiful.color_widget
        else
            color = beautiful.color_widget_alert
        end

        local text = string.format("<span color='%s'>%s</span>",
                                   color, tostring(num))

        myw.mail.outwdg:set_markup(text)
        myw.mail.num_queue = num
    end

    myw.mail.tooltip.textbox:set_text(table.concat(mail, '\n'))
end

myw.mail.icon:buttons(awful.util.table.join(awful.button({ }, 1,
    function () exec(apps.mail) end)))

myw.mail.inwdg:buttons(myw.mail.icon:buttons())
myw.mail.outwdg:buttons(myw.mail.icon:buttons())

timers.normal:connect_signal("timeout", myw.mail.update)



-----------------------------------
-- Music                         --
-----------------------------------

myw.mpd = {}
myw.mpd.src  = require("abdo.widget.mpd")
myw.mpd.path = os.getenv("AB2_MUSIC_DIR")

myw.mpd.icon = wibox.widget.textbox()
myw.mpd.icon:set_markup(string.format("<span color='%s' weight='bold' font='%s'>♫ </span>",
                                      beautiful.color_widget, beautiful.font_symbol))


myw.mpd.stateicon = wibox.widget.textbox()

myw.mpd.current = { ['{file}'] = nil,
                    ['{state}'] = nil}

function myw.mpd.notify_song(args)
    if args['{file}'] ~= nil then
        local parentdir=string.gsub(args['{file}'], '/[^/]+$', '')
        local cover=parentdir .. '/' .. 'cover.jpg'

        naughty.notify({title = args['{title}'],
                        text = string.format("%s\n%s",
                                             args['{album}'],
                                             args['{artist}']),
                        icon = myw.mpd.path .. '/' .. cover,
                        appname = "mpd"})
    end
end

function myw.mpd.update()
    local args = myw.mpd.src(nil)

    -- Note: From miscelaneous technical. Not yet standard.
    local play_icon = string.format("<span color='%s' weight='bold' font='%s'>⏵</span>",
                                    beautiful.color_widget_alert, beautiful.font_symbol)

    local stop_icon = string.format("<span color='%s' weight='bold' font='%s'>⏹</span>",
                                    beautiful.color_widget, beautiful.font_symbol)

    local pause_icon = string.format("<span color='%s' weight='bold' font='%s'>⏸</span>",
                                     beautiful.color_widget, beautiful.font_symbol)

    local icon = stop_icon

    if args['{state}'] == 'playing' then
        icon = play_icon
    elseif args['{state}'] == 'stopped' then
        icon = stop_icon
    elseif args['{state}'] == 'paused' then
        icon = pause_icon
    end

    if myw.mpd.current['{file}'] ~= args['{file}'] or
    myw.mpd.current['{state}'] ~= args['{state}'] then
        if args['{state}'] == "playing" then
            myw.mpd.notify_song(args)
        end

        if myw.mpd.current['{state}'] ~= args['{state}'] then
            myw.mpd.stateicon:set_markup(icon)
        end
    end

    myw.mpd.current = args
end

myw.mpd.icon:buttons(awful.util.table.join( awful.button({ }, 1,
                      function () myw.mpd.notify_song(myw.mpd.current) end)))
myw.mpd.stateicon:buttons(myw.mpd.icon:buttons())

timers.fast:connect_signal("timeout", myw.mpd.update)


-----------------------------------
-- Volume                        --
-----------------------------------

myw.vol = {}
myw.vol.src = require("abdo.widget.pvol")

myw.vol.icon = wibox.widget.textbox()

myw.vol.headphones_icon = string.format("<span color='%s' font='%s'>🎧 </span>",
                                        beautiful.color_widget, beautiful.font_symbol)

myw.vol.mute_icon = string.format("<span color='%s' font='%s'>🔇 </span>",
                                  beautiful.color_widget, beautiful.font_symbol)

myw.vol.speaker_icon = string.format("<span color='%s' font='%s'>🔊 </span>",
                                     beautiful.color_widget, beautiful.font_symbol)

myw.vol.widget = wibox.widget.textbox()
myw.vol.value = -1

function myw.vol.update()
    local args = myw.vol.src(nil)

    if args.port ~= myw.vol.port_value then
        if string.match(args.port, 'headphones') then
            myw.vol.icon:set_markup(myw.vol.headphones_icon)
        else
            myw.vol.icon:set_markup(myw.vol.speaker_icon)
        end
        myw.vol.port_value = args.port
    end

    if args.vol ~= myw.vol.vol_value then
        local color = util.gradient(gradcols, 0, 100, args.vol)
        local text = string.format("<span color='%s'>%s%%</span>", color, args.vol)
        myw.vol.widget:set_markup(text)
        myw.vol.vol_value = args.vol
    end
end

myw.vol.widget:buttons(awful.util.table.join(awful.button({ }, 1,
    function () exec("pavucontrol") end)))
myw.vol.icon:buttons(myw.vol.widget:buttons())

timers.fast:connect_signal("timeout", myw.vol.update)


-----------------------------------
-- Battery State                 --
-----------------------------------

myw.bat = {}
myw.bat.src = require("abdo.widget.bat")

myw.bat.icon = wibox.widget.textbox()
myw.bat.pcwidget = wibox.widget.textbox()
myw.bat.rtwidget = wibox.widget.textbox()

myw.bat.tooltip = awful.tooltip({ objects = {myw.bat.pcwidget, myw.bat.rtwidget, myw.bat.icon}})

myw.bat.percent = -1
myw.bat.rate = -1
myw.bat.time = -1

function myw.bat.update()
    local args = myw.bat.src(nil, "BAT0")
    if args.rate ~= myw.bat.rate then
        local color_rate = beautiful.color_widget

        if args.state == 'charging' then
            color_rate = util.gradient(gradcols_rev, 0, 40, args.rate)
        else
            color_rate = util.gradient(gradcols, 7, 30, args.rate)
        end

        local text = string.format("<span color='%s'>%4.1fW</span>", color_rate, args.rate)
        myw.bat.rtwidget:set_markup(text)
    end

    if args.percent ~= myw.bat.percent or args.state ~= myw.bat.state then
        local color_percent = util.gradient(gradcols_rev, 0, 100, args.percent)
        local text_icon = ""

        if args.state == 'charging' or args.state == 'charged' then
            text_icon = string.format('<span color="%s" weight="bold" font="%s">🔌 </span>',
                                            beautiful.color_widget, beautiful.font_symbol)
        else
            text_icon = string.format('<span color="%s" weight="bold" font="%s">🔋 </span>',
                                            beautiful.color_widget, beautiful.font_symbol)
        end

        local battery_state = {
            full        = "⚡",
            unknown     = "?",
            charged     = "⚡",
            charging    = "+",
            discharging = "-"
        }

        local text_state = string.format("<span color='%s' font='%s'>%s</span>",
                                         color_percent, beautiful.font_symbol, battery_state[args.state])

        local text_percent = string.format("<span color='%s'>%s%%</span>",
                                           color_percent, args.percent)

        myw.bat.pcwidget:set_markup(text_state .. text_percent)
        myw.bat.icon:set_markup(text_icon)

        if args.percent > 0 and args.percent <= 5 and args.state ~= 'charging' then
            naughty.notify({title="Low Battery", text="Hey, plug the power cord!",
                            appname="battery"})
        end
    end

    if args.time ~= myw.bat.time then
        myw.bat.tooltip.textbox:set_markup("<b>Time remaining:</b> " .. args.time)
    end

    myw.bat.rate = args.rate
    myw.bat.percent = args.percent
    myw.bat.time = args.time
end

myw.bat.rtwidget:buttons(awful.util.table.join(awful.button({ }, 1,
    function () exec("gnome-power-statistics") end)))
myw.bat.pcwidget:buttons(myw.bat.rtwidget:buttons())
myw.bat.icon:buttons(myw.bat.rtwidget:buttons())

timers.fast:connect_signal("timeout", myw.bat.update)


-----------------------------------
-- System                        --
-----------------------------------

myw.sys = {}
myw.sys.sync = require("abdo.widget.fileval")
myw.sys.priv = require("abdo.widget.filex")
myw.sys.syncwdg = wibox.widget.textbox()
myw.sys.privwdg = wibox.widget.textbox()

function myw.sys.update()
    local priv_state = myw.sys.priv(nil, {os.getenv("HOME") .. "/priv/README"})
    local sync_state = myw.sys.sync(nil, {os.getenv("XDG_RUNTIME_DIR") .. "/synced", false})

    if priv_state then
        myw.sys.privwdg:set_markup(string.format("<span color='%s' font='%s'> 🔒 </span>",
                                                 beautiful.color_widget, beautiful.font_symbol))
    else
        myw.sys.privwdg:set_markup(string.format("<span color='%s' font='%s'> 🔒 </span>",
                                                 beautiful.color_widget_alert, beautiful.font_symbol))
    end

    if sync_state then
        myw.sys.syncwdg:set_markup(string.format("<span color='%s' font='%s'> ☢ </span>",
                                                 beautiful.color_widget, beautiful.font_symbol))
    else
        myw.sys.syncwdg:set_markup(string.format("<span color='%s' font='%s'> ☢ </span>",
                                                 beautiful.color_widget_alert, beautiful.font_symbol))
    end
end

timers.normal:connect_signal("timeout", myw.sys.update)


-----------------------------------
-- Clock                         --
-----------------------------------

myw.clock = {}
myw.clock.icon = wibox.widget.textbox()
myw.clock.icon:set_markup(string.format("<span color='%s' font='%s'>📆 </span>",
                                        beautiful.color_widget, beautiful.font_symbol))

myw.clock.clockwdg = awful.widget.textclock(string.format('<span color="%s">%%a %%d %%b %%H:%%M </span>',
                                                          beautiful.color_widget))


-----------------------------------
-- Systray                       --
-----------------------------------

myw.systray = wibox.widget.systray()


-----------------------------------
-- Taglist                       --
-----------------------------------

myw.taglist = {}

myw.taglist.buttons = awful.util.table.join(
    awful.button({ }, 1, awful.tag.viewonly),
    awful.button({ }, 3, awful.tag.viewtoggle)
--   awful.button({ modkey }, 1, awful.client.movetotag),
--   awful.button({ modkey }, 3, awful.client.toggletag)
--                    awful.button({ }, 4, awful.tag.viewnext),
--                    awful.button({ }, 5, awful.tag.viewprev)
)

for s = 1, screen.count() do
    myw.taglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, myw.taglist.buttons)
end


-----------------------------------
-- Tasklist                      --
-----------------------------------

myw.tasklist = {}

myw.tasklist.buttons = awful.util.table.join(
    awful.button({ }, 1,
        function (c)
            if c == client.focus then
                c.minimized = true
            else
                if not c:isvisible() then
                    awful.tag.viewonly(c:tags()[1])
                end
                -- This will also un-minimize
                -- the client, if needed
                client.focus = c
                c:raise()
            end
        end),

--   awful.button({ }, 3, function ()
--			   if instance then
--			      instance:hide()
--			      instance = nil
--			   else
--			      instance = awful.menu.clients({ width=250 })
--			   end
--			end),

    awful.button({ }, 4,
        function ()
            awful.client.focus.byidx(1)
            if client.focus then client.focus:raise() end
        end),

    awful.button({ }, 5,
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end)
)

for s = 1, screen.count() do
   myw.tasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, myw.tasklist.buttons)

end


-----------------------------------
-- Layout box                    --
-----------------------------------

myw.layoutbox = {}

for s = 1, screen.count() do
   myw.layoutbox[s] = awful.widget.layoutbox(s)
   myw.layoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
 end


-----------------------------------
-- Prompt box                    --
-----------------------------------

myw.promptbox = {}
for s = 1, screen.count() do
    myw.promptbox[s] = awful.widget.prompt()
end



-----------------------------------
-- Start the widgets             --
-----------------------------------

start_widgets()
