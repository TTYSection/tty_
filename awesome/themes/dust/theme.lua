-----------------------
--  AwesomeWM theme  --
-- based on Dust GTK --
--   	  aaf		 --
-----------------------

local awful = require("awful")

-- {{{ Helpers
function hometheme(path) return awful.util.getdir("config") .. "/themes/dust" .. path end
function homethemewallpaper(path) return awful.util.getdir("config") .. "/themes/wallpapers" .. path end
function hometags(path) return hometheme("/taglist") .. path end
function homelayouts(path) return hometheme("/layoutsn") .. path end
function homewidgets(path) return hometheme("/widgets") .. path end
function hometp(path) return hometheme("/tp") .. path end
function homeicon(path) return hometheme("/icons") .. path end

function systheme(path) return "/usr/share/awesome/themes/default" .. path end
function systitle(path) return systheme("/titlebar") .. path end
-- }}}

-- {{ Main
theme = {}
theme.wallpaper             = homethemewallpaper("/11.jpg")
theme.font                  = "Terminus 8"
theme.menu_height           = 20
theme.menu_width            = 150
-- }}}

-- {{{ Colors
theme.menu_border_width 	= 1
theme.menu_fg_normal 		= "#aaaaaa"
theme.menu_fg_focus 		= "#7493d2"
theme.menu_bg_normal 		= "#050505dd"
theme.menu_bg_focus		= "#050505dd"

theme.fg_normal 		= "#aaaaaa"
theme.fg_focus 			= "#80a673"
theme.fg_urgent			= "#ffffff"
theme.fg_tooltip		= "#1a1a1a"
theme.fg_em			= "#d6d6d6"
theme.fg_fs 			= "#80d9d8"
theme.fg_widget 		= "#000000"
theme.fg_center_widget		= "#636363"
theme.fg_end_widget		= theme.fg_tooltip

theme.bg_normal			= theme.fg_tooltip
theme.bg_focus 			= theme.fg_widget
theme.bg_urgent			= "#cd7171"
theme.bg_tooltip		= theme.fg_em
theme.bg_em 			= "#5a5a5a"
theme.bg_systray		= theme.fg_tooltip
theme.bg_widget			= "#2a2a2a"

theme.border_width		= 1
theme.border_normal		= "#000000"
theme.border_focus		= "#222222"
theme.border_marked		= "#91231c"
theme.border_tooltip		= "#444444"
theme.border_widget		= "#3f3f3f"

theme.titlebar_bg_focus		= theme.border_widget
theme.titlebar_bg_normal	= theme.border_widget

theme.mouse_finder_color	= "#cc9393"
-- }}}

-- {{{ Icons
theme.taglist_squares_sel   = hometags("/squaref.png")
theme.taglist_squares_unsel = hometags("/square.png")

theme.awesome_icon          = hometheme("/awesome-dust22.png")
theme.menu_submenu_icon     = systheme("/submenu.png")

theme.layout_tile           = homelayouts("/tile.png")
theme.layout_tileleft       = homelayouts("/tileleft.png")
theme.layout_tilebottom     = homelayouts("/tilebottom.png")
theme.layout_tiletop        = homelayouts("/tiletop.png")
theme.layout_fairv          = homelayouts("/fairv.png")
theme.layout_fairh          = homelayouts("/fairh.png")
theme.layout_spiral         = homelayouts("/spiral.png")
theme.layout_dwindle        = homelayouts("/dwindle.png")
theme.layout_max            = homelayouts("/max.png")
theme.layout_fullscreen     = homelayouts("/fullscreen.png")
theme.layout_magnifier      = homelayouts("/magnifier.png")
theme.layout_floating       = homelayouts("/floating.png")

theme.widget_disk           = homewidgets("/disk.png")
--theme.widget_cpu            = homewidgets("/cpu.png")
theme.widget_ac             = homewidgets("/ac.png")
theme.widget_acblink        = homewidgets("/acblink.png")
theme.widget_blank          = homewidgets("/blank.png")
theme.widget_batfull        = homewidgets("/batfull.png")
theme.widget_batmed         = homewidgets("/batmed.png")
theme.widget_batlow         = homewidgets("/batlow.png")
theme.widget_batempty       = homewidgets("/batempty.png")
--theme.widget_vol            = homewidgets("/vol.png")
theme.widget_mute           = homewidgets("/mute.png")
theme.widget_pac            = homewidgets("/pac.png")
theme.widget_pacnew         = homewidgets("/pacnew.png")
--theme.widget_mail           = homewidgets("/mail.png")
theme.widget_mailnew        = homewidgets("/mailnew.png")
--theme.widget_temp           = homewidgets("/temp.png")
theme.widget_tempwarn       = homewidgets("/tempwarm.png")
theme.widget_temphot        = homewidgets("/temphot.png")
theme.widget_wifi           = homewidgets("/wifi.png")
theme.widget_nowifi         = homewidgets("/nowifi.png")
theme.widget_mpd            = homewidgets("/mpd.png")
theme.widget_play           = homewidgets("/play.png")
theme.widget_pause          = homewidgets("/pause.png")
theme.widget_ram            = homewidgets("/ram.png")


theme.submenu_icon              = homeicon("/submenu.png")
theme.widget_temp               = homeicon("/temp.png")
theme.widget_uptime             = homeicon("/ac.png")
theme.widget_cpu                = homeicon("/cpu.png")
theme.widget_weather            = homeicon("/dish.png")
theme.widget_fs                 = homeicon("/fs.png")
theme.widget_mem                = homeicon("/mem.png")
theme.widget_fs                 = homeicon("/fs.png")
theme.widget_note               = homeicon("/note.png")
theme.widget_note_on            = homeicon("/note_on.png")
theme.widget_netdown            = homeicon("/net_down.png")
theme.widget_netup              = homeicon("/net_up.png")
theme.widget_mail               = homeicon("/mail.png")
theme.widget_batt               = homeicon("/bat.png")
theme.widget_clock              = homeicon("/clock.png")
theme.widget_vol                = homeicon("/spkr.png")
theme.widget_hdd		= homeicon("/hdd.png")

-- {{ Menu 
theme.awesome_arch 		= homeicon("/arch.png")
theme.menu_term			= homeicon("/icon2.png")
theme.menu_wifi			= homeicon("/icon3.png")
theme.menu_brow			= homeicon("/icon4.png")
theme.menu_apps                 = homeicon("/icon5.png")
theme.menu_red			= homeicon("/red.png")

--theme.widget_mem            = hometp("/ram.png")
theme.widget_swap           = hometp("/swap.png")
--theme.widget_fs             = hometp("/fs_01.png")
theme.widget_fs2            = hometp("/fs_02.png")
--theme.widget_up             = hometp("/up.png")
--theme.widget_down           = hometp("/down.png")


theme.titlebar_close_button_focus               = systitle("/close_focus.png")
theme.titlebar_close_button_normal              = systitle("/close_normal.png")

theme.titlebar_ontop_button_focus_active        = systitle("/ontop_focus_active.png")
theme.titlebar_ontop_button_normal_active       = systitle("/ontop_normal_active.png")
theme.titlebar_ontop_button_focus_inactive      = systitle("/ontop_focus_inactive.png")
theme.titlebar_ontop_button_normal_inactive     = systitle("/ontop_normal_inactive.png")

theme.titlebar_sticky_button_focus_active       = systitle("/sticky_focus_active.png")
theme.titlebar_sticky_button_normal_active      = systitle("/sticky_normal_active.png")
theme.titlebar_sticky_button_focus_inactive     = systitle("/sticky_focus_inactive.png")
theme.titlebar_sticky_button_normal_inactive    = systitle("/sticky_normal_inactive.png")

theme.titlebar_floating_button_focus_active     = systitle("/floating_focus_active.png")
theme.titlebar_floating_button_normal_active    = systitle("/floating_normal_active.png")
theme.titlebar_floating_button_focus_inactive   = systitle("/floating_focus_inactive.png")
theme.titlebar_floating_button_normal_inactive  = systitle("/floating_normal_inactive.png")

theme.titlebar_maximized_button_focus_active    = systitle("/maximized_focus_active.png")
theme.titlebar_maximized_button_normal_active   = systitle("/maximized_normal_active.png")
theme.titlebar_maximized_button_focus_inactive  = systitle("/maximized_focus_inactive.png")
theme.titlebar_maximized_button_normal_inactive = systitle("/maximized_normal_inactive.png")

return theme
