-----------------------
-- AwesomeWM widgets --
--    version 3.5    --
--   <tdy@gmx.com>   --
-----------------------

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
local naughty = require("naughty")
local drop      = require("scratchdrop")
local lain      = require("lain")

graphwidth  = 120
graphheight = 20
pctwidth    = 40
netwidth    = 50
mpdwidth    = 365

-- {{{ Spacers
space = wibox.widget.textbox()
space:set_text(" ")

comma = wibox.widget.textbox()
comma:set_markup(",")

pipe = wibox.widget.textbox()
pipe:set_markup("<span color='" .. beautiful.bg_em .. "'>|</span>")

tab = wibox.widget.textbox()
tab:set_text("         ")

volspace = wibox.widget.textbox()
volspace:set_text(" ")
-- }}}


-- {{{ Filesystem
-- Cache
vicious.cache(vicious.widgets.fs)

-- Root used
rootfsused = wibox.widget.textbox()
vicious.register(rootfsused, vicious.widgets.fs,
  "<span color='" .. beautiful.fg_fs .. "'>[L] ${/ used_gb}GB </span>", 97)

-- WINDOWS used
rootfs3used = wibox.widget.textbox()
vicious.register(rootfs3used, vicious.widgets.fs,
  "<span color='" .. beautiful.fg_fs .. "'>[W] ${/mnt/windows used_gb}GB </span>", 97)

-- Root bar
rootfsbar = awful.widget.progressbar()
rootfsbar:set_vertical(false):set_width(graphwidth):set_height(graphheight)
rootfsbar:set_ticks(false):set_ticks_size(2)
rootfsbar:set_border_color(nil)
rootfsbar:set_background_color(beautiful.bg_widget)
rootfsbar:set_color({
  type = "linear",
  from = { 0, 0 },
  to = { graphwidth, 0 },
  stops = {
    { 0, beautiful.fg_widget },
    { 0.25, beautiful.fg_center_widget },
    { 1, beautiful.fg_end_widget } } })
vicious.register(rootfsbar, vicious.widgets.fs, "${/ used_p}", 97)

-- Root %
rootfspct = wibox.widget.textbox()
rootfspct.width = pctwidth
vicious.register(rootfspct, vicious.widgets.fs, " ${/ used_p}%", 97)
-- }}}

-- {{{ Weather
weather = wibox.widget.textbox()
vicious.register(weather, vicious.widgets.weather,
  "<span color='" .. beautiful.fg_em .. "'>${sky}</span> @ ${tempf}°F on",
  1501, "XXXX")
weather:buttons(awful.util.table.join(awful.button({ }, 1,
  function() vicious.force({ weather }) end)))
-- }}}

-- {{{ Pacman
-- Icon
pacicon = wibox.widget.imagebox()
pacicon:set_image(beautiful.widget_pac)


-- Pacman Widget
pacwidget = wibox.widget.textbox()
pacicon = wibox.widget.imagebox()
pacicon:set_image(beautiful.widget_pacman)

-- Upgrades
pacwidget = wibox.widget.textbox()
vicious.register(pacwidget, vicious.widgets.pkg,
  function(widget, args)
    if args[1] > 0 then
      pacicon:set_image(beautiful.widget_pacnew)
    else
      pacicon:set_image(beautiful.widget_pac)
    end

    return args[1]
  end, 1801, "Arch S") -- Arch S for ignorepkg

-- Buttons
function popup_pac()
  local pac_updates = ""
  local f = io.popen("pacman -Sup --dbpath /tmp/pacsync")
  if f then
    pac_updates = f:read("*a"):match(".*/(.*)-.*\n$")
  end
  f:close()

  if not pac_updates then pac_updates = "System is up to date" end

  naughty.notify { text = pac_updates }
end
pacwidget:buttons(awful.util.table.join(awful.button({ }, 1, popup_pac)))
pacicon:buttons(pacwidget:buttons())
-- }}}

-- {{{ Battery
-- Battery attributes
local bat_state  = ""
local bat_charge = 0
local bat_time   = 0
local blink      = true

-- Icon
baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.widget_batfull)

-- Charge %
batpct = wibox.widget.textbox()
vicious.register(batpct, vicious.widgets.bat,
  function(widget, args)
    bat_state  = args[1]
    bat_charge = args[2]
    bat_time   = args[3]

    if args[1] == "-" then
      if bat_charge > 70 then
        baticon:set_image(beautiful.widget_batfull)
      elseif bat_charge > 30 then
        baticon:set_image(beautiful.widget_batmed)
      elseif bat_charge > 10 then
        baticon:set_image(beautiful.widget_batlow)
      else
        baticon:set_image(beautiful.widget_batempty)
      end
    else
      baticon:set_image(beautiful.widget_ac)
      if args[1] == "+" then
        blink = not blink
        if blink then
          baticon:set_image(beautiful.widget_acblink)
        end
      end
    end

    return args[2] .. "%"
  end, nil, "BAT1")

-- Buttons
function popup_bat()
  local state = ""
  if bat_state == "↯" then
    state = "Full"
  elseif bat_state == "↯" then
    state = "Charged"
  elseif bat_state == "+" then
    state = "Charging"
  elseif bat_state == "-" then
    state = "Discharging"
  elseif bat_state == "⌁" then
    state = "Not charging"
  else
    state = "Unknown"
  end

  naughty.notify { text = "Charge : " .. bat_charge .. "%\nState  : " .. state ..
    " (" .. bat_time .. ")", timeout = 5, hover_timeout = 0.5 }
end
batpct:buttons(awful.util.table.join(awful.button({ }, 1, popup_bat)))
baticon:buttons(batpct:buttons())
-- }}}

-- { MultiColor }
-----------------------------------------------------------------------------------------------------------------------------------------

-- {{{ Freedesktop Menu
--mymainmenu = awful.menu.new({ items = require("menugen").build_menu(),
--                              theme = { height = 16, width = 130 }})
-- }}}

-- {{{ Wibox
markup      = lain.util.markup

-- Textclock
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
mytextclock = awful.widget.textclock(markup("#7788af", "%A %d %B ") .. markup("#343639", ">") .. markup("#de5e1e", " %H:%M "))

-- Calendar
lain.widgets.calendar:attach(mytextclock, { font_size = 10 })

-- Calendar
lain.widgets.calendar:attach(mytextclock, { font_size = 10 })

-- Weather
weathericon = wibox.widget.imagebox(beautiful.widget_weather)
yawn = lain.widgets.yawn(123456, {
    settings = function()
        widget:set_markup(markup("#eca4c4", forecast:lower() .. " @ " .. units .. "°C "))
    end
})

-- / fs
fsicon = wibox.widget.imagebox(beautiful.widget_fs)
fswidget = lain.widgets.fs({
    settings  = function()
        widget:set_markup(markup("#80d9d8", fs_now.used .. "% "))
    end
})

-- / fs - WINDOWS
fsicon = wibox.widget.imagebox(beautiful.widget_fs)
fs3widget = lain.widgets.fs3({
    settings  = function()
        widget:set_markup(markup("#80d9d8", fs_now.used .. "% "))
    end
})


-- Mail IMAP check
-- commented because it needs to be set before use
mailicon = wibox.widget.imagebox()
mailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(mail) end)))
mailwidget = lain.widgets.imap({
    timeout  = 180,
    server   = "mail.google.com",
    mail     = "aaftty0@gmail.com",
    password = "ramses2aaf",
    settings = function()
        if mailcount > 0 then
            mailicon:set_image(beautiful.widget_mail)
            widget:set_markup(markup("#cccccc", mailcount .. " "))
        else
            widget:set_text("")
            mailicon:set_image(nil)
        end
    end
})

-- CPU
cpuicon = wibox.widget.imagebox(beautiful.widget_cpu)
cpuwidget = lain.widgets.cpu({
    settings = function()
        widget:set_markup(markup("#e33a6e", cpu_now.usage .. "% "))
    end
})



-- Coretemp
tempicon = wibox.widget.imagebox(beautiful.widget_temp)
tempwidget = lain.widgets.temp({
    settings = function()
        widget:set_markup(markup("#f1af5f", coretemp_now .. "°C "))
    end
})

-- Battery
baticon = wibox.widget.imagebox(beautiful.widget_batt)
batwidget = lain.widgets.bat({
    settings = function()
        if bat_now.perc == "N/A" then
            bat_now.perc = "AC "
        else
            bat_now.perc = bat_now.perc .. "% "
        end
        widget:set_text(bat_now.perc)
    end
})

-- ALSA volume
volicon = wibox.widget.imagebox(beautiful.widget_vol)
volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup("#7493d2", volume_now.level .. "% "))
    end
})

-- Net
netdownicon = wibox.widget.imagebox(beautiful.widget_netdown)
--netdownicon.align = "middle"
netdowninfo = wibox.widget.textbox()
netupicon = wibox.widget.imagebox(beautiful.widget_netup)
--netupicon.align = "middle"
netupinfo = lain.widgets.net({
    settings = function()
        if iface ~= "network off" and
           string.match(yawn.widget._layout.text, "N/A")
        then
            yawn.fetch_weather()
        end

        widget:set_markup(markup("#e54c62", net_now.sent .. " "))
        netdowninfo:set_markup(markup("#87af5f", net_now.received .. " "))
    end
})

-- MEM
cpuicon2 = wibox.widget.imagebox(beautiful.widget_cpu)
memicon = wibox.widget.imagebox(beautiful.widget_mem)
memwidget = lain.widgets.mem({
    settings = function()
        widget:set_markup(markup("#e0da37", mem_now.used .. "M "))
    end
})

-- MPD
mpdicon = wibox.widget.imagebox()
mpdwidget = lain.widgets.mpd({
    settings = function()
        mpd_notification_preset = {
            text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
                   mpd_now.album, mpd_now.date, mpd_now.title)
        }

        if mpd_now.state == "play" then
            artist = mpd_now.artist .. " > "
            title  = mpd_now.title .. " "
            mpdicon:set_image(beautiful.widget_note_on)
        elseif mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            mpdicon:set_image(nil)
        end
        widget:set_markup(markup("#e54c62", artist) .. markup("#b2b2b2", title))
    end
})


-- Wi-fi
wifiicon  = wibox.widget.imagebox(beautiful.widget_wifi)
wifiwidget = wibox.widget.textbox()
vicious.register(wifiwidget, vicious.widgets.wifi,  "[${ssid}] - ${link}% ✇", 10, "wlp2s0")
   

-- Spacer
spacer = wibox.widget.textbox(" ")

-- Icon
mygmailimg = wibox.widget.imagebox()
mygmailimg:set_image(beautiful.widget_mail)


-- Pacman Widget
mygmail = wibox.widget.textbox()
mygmailimg = wibox.widget.imagebox()
mygmailimg:set_image(beautiful.widget_mail)

-- gmail widget and tooltip
mygmail = wibox.widget.textbox()
gmail_t = awful.tooltip({ objects = { mygmail },})

vicious.register(mygmail, vicious.widgets.gmail,
                function (widget, args)
                    gmail_t:set_text(args["{subject}"])
                    gmail_t:add_to_object(mygmailimg)
                    return args["{count}"]
                 end, 120) 
                 --the '120' here means check every 2 minutes.


-- Gmail Checker

awful.widget.gmail = require('awful.widget.gmail')
gmailwidget = awful.widget.gmail.new()


-- Keyboard map indicator and changer
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { { "us", "", "us" },
		  { "ru", "", "ru" },
                  { "ge", "", "ge" }
                 }
kbdcfg.current = 1
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.widget:set_text(" " .. kbdcfg.layout[kbdcfg.current][3] .. " ")
kbdcfg.switch = function ()
kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
local t = kbdcfg.layout[kbdcfg.current]
kbdcfg.widget:set_text(" " .. t[3] .. " ")
os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] ) end

-- Mouse bindings
kbdcfg.widget:buttons(
awful.util.table.join(awful.button({ }, 1, function () kbdcfg.switch() end)))


-- }}}
