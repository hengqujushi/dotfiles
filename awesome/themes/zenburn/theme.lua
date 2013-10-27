-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
--    License:  GNU GPL v2   --
-------------------------------

local util = require("awful.util")

-- {{{ Main
theme = {}
theme.confdir = util.getdir("config") .. "/themes/zenburn"
-- }}}


-- {{{ Styles
theme.font      = "Ubuntu Light 10"
theme.font_mono = "Ubuntu Mono 11"
theme.font_box =  "Ubuntu Mono 11"
theme.font_naughty =  "Overlock 12"


-- {{{ Named Colors
theme.fg_grey   = "#777777"
theme.fg_red    = "#CC9393"
theme.fg_green  = "#7f9f7f"
theme.fg_white  = "#DCDCCC"
theme.fg_orange = "#dfaf8f"
theme.fg_blue   = "#8cd0d3"
-- }}}


-- {{{ Org priority colors
theme.fg_org_priority = {
   ["[#1]"] = "#cd3333",
   ["[#2]"] = "#dd7621",
   ["[#3]"] = "#d0bf8f",
   ["[#4]"] = "#8fb28f",
   ["[#5]"] = "#1e90ff",
}

-- }}}


-- {{{ Colors
theme.fg_normal = "#DCDCCC"
theme.fg_focus  = "#F0DFAF"
theme.fg_urgent = "#CC9393"
theme.bg_normal = "#3F3F3F"
theme.bg_focus  = "#1E2320"
theme.bg_urgent = "#3F3F3F"
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = "#3F3F3F"
theme.border_focus  = "#DD5650"
theme.border_marked = "#DD5650"

theme.border_naughty  = "#15BA4B"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
-- theme.titlebar_[normal|focus]
-- }}}

-- {{{ Widgets

theme.fg_grad1_widget  = "#AECF96"
theme.fg_grad2_widget  = "#88A175"
theme.fg_grad3_widget  = "#DC9435"
theme.fg_grad4_widget  = "#FF5656"

theme.fg_widget        = "#AECF96"
theme.fg_center_widget = "#88A175"
theme.fg_end_widget    = "#FF5656"
theme.fg_off_widget    = "#494B4F"
theme.fg_netup_widget  = "#7F9F7F"
theme.fg_netdn_widget  = "#CC9393"
theme.bg_widget        = "#3F3F3F"
theme.border_widget    = "#3F3F3F"

theme.fg_red_widget    = "#CC9393"
theme.fg_green_widget  = "#7F9F7F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- theme.mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Tooltips
-- theme.tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- }}}

-- {{{ Taglist and Tasklist
-- theme.[taglist|tasklist]_[bg|fg]_[focus|urgent]
-- }}}

-- {{{ Menu
-- theme.menu_[height|width]
-- theme.menu_[bg|fg]_[normal|focus]
-- theme.menu_[border_color|border_width]
-- }}}
-- }}}


theme.naughty_mail_icon   = theme.confdir .. "/icons/naughty/mail.svg"
theme.naughty_news_icon   = theme.confdir .. "/icons/naughty/news.svg"
theme.naughty_chat_icon   = theme.confdir .. "/icons/naughty/chat.svg"
theme.naughty_alert_icon  = theme.confdir .. "/icons/naughty/warning.svg"
theme.naughty_app_icon    = theme.confdir .. "/icons/naughty/run.svg"

theme.naughty_mail_sound    = theme.confdir .. "/sounds/soothing/Gentle Roll.wav"
theme.naughty_chat_sound    = theme.confdir .. "/sounds/soothing/Looking Up.wav"
theme.naughty_alert_sound   = theme.confdir .. "/sounds/soothing/Connected.wav"


-- {{{ Icons
--
-- {{{ Taglist icons
theme.taglist_squares_sel   = theme.confdir .. "/icons/taglist/squarefz.png"
theme.taglist_squares_unsel = theme.confdir .. "/icons/taglist/squareza.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc icons
theme.awesome_icon           = theme.confdir .. "/icons/wibox/awesome.png"
theme.menu_submenu_icon      = theme.confdir .. "/icons/menu/submenu.png"
theme.tasklist_floating_icon = theme.confdir .. "/icons/tasklist/floatingw.png"
-- }}}

-- {{{ Layout icons
theme.layout_tile       = theme.confdir .. "/icons/layouts/tile.png"
theme.layout_tileleft   = theme.confdir .. "/icons/layouts/tileleft.png"
theme.layout_tilebottom = theme.confdir .. "/icons/layouts/tilebottom.png"
theme.layout_tiletop    = theme.confdir .. "/icons/layouts/tiletop.png"
theme.layout_fairv      = theme.confdir .. "/icons/layouts/fairv.png"
theme.layout_fairh      = theme.confdir .. "/icons/layouts/fairh.png"
theme.layout_spiral     = theme.confdir .. "/icons/layouts/spiral.png"
theme.layout_dwindle    = theme.confdir .. "/icons/layouts/dwindle.png"
theme.layout_max        = theme.confdir .. "/icons/layouts/max.png"
theme.layout_fullscreen = theme.confdir .. "/icons/layouts/fullscreen.png"
theme.layout_magnifier  = theme.confdir .. "/icons/layouts/magnifier.png"
theme.layout_floating   = theme.confdir .. "/icons/layouts/floating.png"
-- }}}

-- {{{ Widget icons
theme.widget_temp   = theme.confdir .. "/icons/wibox/temp.png"
theme.widget_cpu    = theme.confdir .. "/icons/wibox/cpu.png"
theme.widget_bat    = theme.confdir .. "/icons/wibox/bat.png"
theme.widget_mem    = theme.confdir .. "/icons/wibox/mem.png"
theme.widget_fs     = theme.confdir .. "/icons/wibox/disk.png"
theme.widget_netdw  = theme.confdir .. "/icons/wibox/down.png"
theme.widget_netup  = theme.confdir .. "/icons/wibox/up.png"
theme.widget_net    = theme.confdir .. "/icons/wibox/sat.png"
theme.widget_maile  = theme.confdir .. "/icons/wibox/mailg.png"
theme.widget_mailf  = theme.confdir .. "/icons/wibox/mailr.png"
theme.widget_rsse   = theme.confdir .. "/icons/wibox/rssg.png"
theme.widget_rssf   = theme.confdir .. "/icons/wibox/rssr.png"
theme.widget_vol    = theme.confdir .. "/icons/wibox/vol.png"
theme.widget_org    = theme.confdir .. "/icons/wibox/cal.png"
theme.widget_date   = theme.confdir .. "/icons/wibox/time.png"
theme.widget_crypto = theme.confdir .. "/icons/wibox/crypto.png"
theme.widget_music  = theme.confdir .. "/icons/wibox/music.png"
theme.widget_pause  = theme.confdir .. "/icons/wibox/pause.png"
theme.widget_play   = theme.confdir .. "/icons/wibox/play.png"
theme.widget_stop   = theme.confdir .. "/icons/wibox/stop.png"
-- }}}

-- {{{ Titlebar icons
theme.titlebar_close_button_focus  = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme.confdir .. "/icons/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active    = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active   = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active    = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active   = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active    = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active   = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active    = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}


return theme