
---------------------------------------------------------------
-- File:    mywidgets.lua     PersonalWidgets                --
-- Version:                                                  --
-- Author:  Abdó Roig<abdo.roig@gmail.com>                   --
---------------------------------------------------------------

-----------------------------------
-- Module loading                --
-----------------------------------

-- require("awful")

local wibox = require("wibox")
local vicious = require("vicious")

local widget = {}
widget.netctl  = require("abdo.widget.netctl")
widget.cpu = require("abdo.widget.cpu")
widget.bat = require("abdo.widget.bat")
widget.mem = require("abdo.widget.mem")
widget.net = require("abdo.widget.net")

widget.thermal = require("abdo.widget.thermal")     -- My thermal widget
widget.pvol    = require("abdo.widget.pvol")        -- My volume widget
widget.sheval = require("abdo.widget.sheval")      -- Get value from a file

local naughty = require("naughty")

local beautiful = beautiful


-----------------------------------
-- Convenience stuff             --
-----------------------------------

local scount = screen.count()

local gradcols = {beautiful.fg_grad1_widget, beautiful.fg_grad2_widget,
		  beautiful.fg_grad3_widget, beautiful.fg_grad4_widget}

local gradcols_rev = {beautiful.fg_grad4_widget, beautiful.fg_grad3_widget,
		      beautiful.fg_grad2_widget, beautiful.fg_grad1_widget}



myw = {}


-----------------------------------
-- Spacers                       --
-----------------------------------

myw.spacer = wibox.widget.textbox()
myw.spacer:set_markup("<span>   </span>")

myw.separator = wibox.widget.textbox()
myw.separator:set_markup(string.format("<span color='%s'>  |  </span>", beautiful.fg_widget))


-----------------------------------
-- Temperature sensors           --
-----------------------------------

myw.tempicon = wibox.widget.imagebox()
myw.tempicon:set_image(beautiful.widget_temp)


myw.cputemp = wibox.widget.textbox()
vicious.register(myw.cputemp, widget.thermal,
                 function (widget, args)
                     local color = util.gradient(gradcols, 35, 70, args[1])
                     return string.format("<span color='%s'>%sºC</span>", color, args[1])
                 end,
                 2, {"coretemp.0", "core"})



-----------------------------------
-- CPU Usage                     --
-----------------------------------

myw.cpuicon = wibox.widget.imagebox()
myw.cpuicon:set_image(beautiful.widget_cpu)

myw.cpuload = wibox.widget.textbox()

vicious.register(myw.cpuload, widget.cpu,
                 function (widget, args)
                     local color = util.gradient(gradcols, 0, 100, args[1])
                     return string.format("<span color='%s'>%s%%</span>", color, args[1])
                 end, 2)



-----------------------------------
-- Battery State                 --
-----------------------------------

myw.baticon = wibox.widget.imagebox()
myw.baticon:set_image(beautiful.widget_bat)
myw.batwidget = wibox.widget.textbox()
myw.ratewidget = wibox.widget.textbox()
myw.battooltip = awful.tooltip({ objects = {myw.batwidget, myw.ratewidget, myw.baticon}})

-- Register widget
vicious.register(myw.batwidget, widget.bat,
		 function (widget, args)
		    myw.battooltip:set_text("Time remaining: " .. args.time)

		    local color_percent = util.gradient(gradcols_rev, 0, 100, args.percent)
		    return string.format("<span color='%s'>%s%s%%</span>", color_percent, args.state, args.percent)
		 end,
		 4, "BAT0")

vicious.register(myw.ratewidget, widget.bat,
		 function (widget, args)
            local color_rate = beautiful.fg_green
            if args.state == '+' then
                color_rate = util.gradient(gradcols_rev, 0, 40, args.rate)
            else
                color_rate = util.gradient(gradcols, 7, 30, args.rate)
            end
            return string.format("<span color='%s'>%4.1fW</span>", color_rate, args.rate)
		 end,
		 4, "BAT0")


-- Register buttons
myw.batwidget:buttons(awful.util.table.join(
   awful.button({ }, 1, function () exec("gnome-power-statistics") end)))
myw.baticon:buttons(myw.batwidget:buttons())
myw.ratewidget:buttons(myw.batwidget:buttons())


-----------------------------------
-- Memory                        --
-----------------------------------

myw.memicon = wibox.widget.imagebox()
myw.memicon:set_image(beautiful.widget_mem)
myw.memused = wibox.widget.textbox()

vicious.register(myw.memused, widget.mem,
                 function (widget, args)
                     local color = util.gradient(gradcols, 0, 100, args[1])
                     return string.format("<span color='%s'>%s%%</span>", color, args[1])
                 end,
                 4)



-----------------------------------
-- Network Usage                 --
-----------------------------------

myw.neticon = wibox.widget.imagebox()
myw.dnicon = wibox.widget.imagebox()
myw.upicon = wibox.widget.imagebox()
myw.netwidget = wibox.widget.textbox()

myw.nettooltip = awful.tooltip({objects = {myw.neticon, myw.dnicon, myw.upicon, myw.netwidget}})

myw.neticon:set_image(beautiful.widget_net)
myw.dnicon:set_image(beautiful.widget_netdw)
myw.upicon:set_image(beautiful.widget_netup)

-- Register widget
vicious.register(myw.netwidget, widget.net,
                 function (widget, args)
                     local up = 0.0
                     local down = 0.0

                     if args["{eth0 up_kb}"] then  up = up + args["{eth0 up_kb}"] end
                     if args["{wlan0 up_kb}"] then up = up + args["{wlan0 up_kb}"] end

                     if args["{eth0 down_kb}"] then  down = down + args["{eth0 down_kb}"] end
                     if args["{wlan0 down_kb}"] then down = down + args["{wlan0 down_kb}"] end

                     local downtxt = string.format('<span color="%s">%.0f</span>', beautiful.fg_netdn_widget, down)
                     local uptxt =   string.format('<span color="%s">%.0f</span>', beautiful.fg_netup_widget, up)
                     local sep = string.format(' <span color="%s">\\</span> ', beautiful.fg_widget)
                     return downtxt .. sep .. uptxt
                 end, 2)

vicious.register(myw.nettooltip.widget, widget.netctl,
                 function (widget, args)
                     prf = ""
                     for _,line in ipairs(args) do
                         if prf ~= "" then
                             prf = prf .. ", "
                         end
                         prf = prf .. line
                     end
                     return "Networks: " .. prf
                 end,
                 4)



-----------------------------------
-- Gmail                         --
-----------------------------------

myw.mail = wibox.widget.textbox()
-- myw.mailtooltip = awful.tooltip({objects = {myw.mail}})
-- myw.mail_lastid = ""

myw.mailicon = wibox.widget.imagebox()
myw.mailicon:set_image(beautiful.widget_maile)

myw.mail_count = 0

vicious.register(myw.mail, widget.sheval,
                 function (widget, args)
                     local color
                     local num = tonumber(args[1])

                     if num == 0 or num == nil then
                         color = beautiful.fg_green_widget
                         myw.mailicon:set_image(beautiful.widget_maile)
                         if num == nil then
                             color = beautiful.fg_red_widget
                             myw.mailicon:set_image(beautiful.widget_mailf)
                             num = "?"
                         else
                             color = beautiful.fg_green_widget
                             myw.mailicon:set_image(beautiful.widget_maile)
                         end
                     else
                         if num ~= myw.mail_count then
                             local text
                             if num == 1 then
                                 text = "There is one new message"
                             else
                                 text = string.format("There are %d new messages", num)
                             end
                             naughty.notify({title = "New Mail",
                                             text  = text,
                                             icon  = beautiful.naughty_mail_icon})
                         end
                         myw.mail_count = num
                         color = beautiful.fg_red_widget
                         myw.mailicon:set_image(beautiful.widget_mailf)
                     end

                     return string.format("<span color='%s'>%s</span>", color, tostring(num))
                 end,
                 60, "mutag -C -p mail -q 'flag:unread AND tag:\\\\Inbox'")



--Vicious.register(myw.mail, widget.gmail,
--		 function (widget, args)
--		    if args["{id}"] ~= myw.mail_lastid then
--		       myw.mail_lastid = args["{id}"]
--		       naughty.notify({title = "New Mail",
--				       text  = string.format("%s\n%s", args["{from}"], args["{subject}"]),
--				       icon  = beautiful.naughty_mail_icon})
--		       myw.mailtooltip:set_text(args["{subject}"])
--		       myw.mailtooltip:add_to_object(myw.mailicon)
--		       myw.mailtooltip:add_to_object(myw.mail)
--		    end
--		    local color
--		    if args["{count}"] == 0 then
--		       color = beautiful.fg_green_widget
--		       myw.mailicon:set_image(beautiful.widget_maile)
--		    else
--		       color = beautiful.fg_red_widget
--		       myw.mailicon:set_image(beautiful.widget_mailf)
--		    end
--
--		    return string.format("<span color='%s'>%s</span>", color, args["{count}"])
--		 end, 120)

-- Register buttons
myw.mail:buttons(awful.util.table.join(
   awful.button({ }, 1, function () exec(apps.mail) end)))

myw.mailicon:buttons(myw.mail:buttons())



-----------------------------------
-- RSS News                      --
-----------------------------------

myw.rssicon = wibox.widget.imagebox()

myw.rss = wibox.widget.textbox()

--vicious.register(myw.rss, widget.sheval,
--		 function (widget, args)
--		    local color
--		    local num = tonumber(args[1])
--		    if num == nil then num = 0 end
--
--		    if num == 0 then
--		       color = beautiful.fg_green_widget
--		       myw.rssicon:set_image(beautiful.widget_rsse)
--		    else
--		       color = beautiful.fg_red_widget
--		       myw.rssicon:set_image(beautiful.widget_rssf)
--		    end
--
--		    return string.format("<span color='%s'>%d</span>", color, num)
--		 end, 60, "notmuch-news count tag:unread")


-- Register buttons
myw.rss:buttons(awful.util.table.join(
   awful.button({ }, 1, function () exec(apps.news) end)))

myw.rssicon:buttons(myw.rss:buttons())



-----------------------------------
-- Volume                        --
-----------------------------------

myw.volicon = wibox.widget.imagebox()
myw.volicon:set_image(beautiful.widget_vol)

-- Initialize widgets
myw.volbar    = awful.widget.progressbar()
myw.volwidget = wibox.widget.textbox()

-- Progressbar properties
myw.volbar:set_vertical(true):set_ticks(true)
myw.volbar:set_height(12):set_width(8):set_ticks_size(1)
myw.volbar:set_background_color(beautiful.fg_off_widget)
myw.volbar:set_color(beautiful.fg_widget)

--volbar:set_gradient_colors({ beautiful.fg_widget,
--   beautiful.fg_center_widget, beautiful.fg_end_widget
--})



vicious.register(myw.volwidget, widget.pvol,
		 function (widget, args)
		    local color = util.gradient(gradcols, 0, 100, args[1])
		    return string.format("<span color='%s'>%s%%</span>", color, args[1])
		 end,
		 2)

vicious.register(myw.volbar, widget.pvol,  "$1",  2)

-- Register buttons
myw.volwidget:buttons(awful.util.table.join(
   awful.button({ }, 1, function () exec("pavucontrol") end)
--   , awful.button({ }, 3, function () exec("gnome-power-statistics") end)
))
myw.volicon:buttons(myw.volwidget:buttons())
myw.volbar:buttons(myw.volwidget:buttons())


-- Register buttons
--volbar:buttons(awful.util.table.join(
--   awful.button({ }, 1, function () exec("kmix") end),
--   awful.button({ }, 4, function () exec("amixer -q set PCM 2dB+", false) end),
--   awful.button({ }, 5, function () exec("amixer -q set PCM 2dB-", false) end)
--)) -- Register assigned buttons
--volwidget:buttons(volbar:buttons())




-----------------------------------
-- Clock                         --
-----------------------------------

myw.textclock = awful.widget.textclock()


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
   awful.button({ }, 1, function (c)
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
   awful.button({ }, 4, function ()
			   awful.client.focus.byidx(1)
			   if client.focus then client.focus:raise() end
			end),
   awful.button({ }, 5, function ()
			   awful.client.focus.byidx(-1)
			   if client.focus then client.focus:raise() end
			end))


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
