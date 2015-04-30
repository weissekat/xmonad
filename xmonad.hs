import XMonad
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import System.IO

voWorkspaces :: [String]
voWorkspaces = ["1:web","2:dev","3:msg","4:music"] ++ map show [5..9]

voManageHook :: ManageHook
voManageHook = composeAll . concat $
	[
		[manageDocks]
		, [ className =? c --> doShift "1:web" | c <- voWebClass ]
		, [ className =? c --> doShift "2:dev" | c <- voDevClass ]
		, [ className =? c --> doShift "3:msg" | c <- voMsgClass ]
		, [ className =? c --> doShift "4:music" | c <- voMusClass ]
   	] where
		voWebClass = ["Google-chrome", "Firefox"]
		voDevClass = ["Geany"] -- terminal must start on any screen/workspace; removed entries: "Xfce4-terminal", "Gnome-terminal"
		voMsgClass = ["Skype", "Pidgin"]
		voMusClass = ["Audacious", "Rhythmbox"]

-- spawn with balls; warning, you password shows on screen and may be saved if historySize > 0
xpConfig = defaultXPConfig { font = "-misc-fixed-*-*-*-*-20-*-*-*-*-*-*-*", position = Bottom, historySize = 0 }
withPrompt prompt fn = inputPrompt xpConfig prompt ?+ fn
sudoSpawn command = withPrompt "Password" $ run command
  where run command password = spawn $ concat ["echo ", password, " | sudo -S ", command]

main = do
	-- spawn xmobar pipe
	xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobar.hs"
	
	spawn "xfsettingsd" -- fix for incorrect GTK theme; config: "gtk-theme-config", "xfce4-appearance-settings"
	
	xmonad $ defaultConfig { 
			-- WIN-key as modkey
			modMask = mod4Mask
			
			-- tune and colorize borders
			, borderWidth = 3
			, normalBorderColor = "gray"
			, focusedBorderColor = "green"
			
			-- define workspaces
			, workspaces = voWorkspaces
			
			-- manage predefined hooks
			, manageHook = voManageHook
			
			-- add xmobar borders that windows SHALL NOT PASS
			, layoutHook = avoidStruts  $  layoutHook defaultConfig
			
			-- add xmobar pipe with workspace/tiling name
			, logHook =  dynamicLogWithPP $ defaultPP {
					ppOutput = System.IO.hPutStrLn xmproc
				} 
		}
		`additionalKeys`
		[
			-- change keyboard layout
			((controlMask, xK_Shift_L), spawn "~/.xmonad/keyboard-switch.sh")
			
			-- increase font for "dmenu"; however, dmenu haven't support for lovely antialiased Droid Sans/Monospace
			, ((mod4Mask, xK_p), spawn "dmenu_run -fn \"-misc-fixed-*-*-*-*-20-*-*-*-*-*-*-*\"")
			
			{-|
			-- volume control / alsa
			, ((mod4Mask , xK_F7), spawn "amixer set Master off && amixer set Headphone off")
			, ((mod4Mask , xK_F8), spawn "amixer set Master on && amixer set Headphone on && amixer set Master 2-") 
			, ((mod4Mask , xK_F9), spawn "amixer set Master on && amixer set Headphone on && amixer set Master 2+")
			-}
			
			-- volume control / pulseaudio
			, ((mod4Mask , xK_F7), spawn "pactl set-sink-mute 0 toggle")
			, ((mod4Mask , xK_F8), spawn ".xmonad/decvolume.sh") 
			, ((mod4Mask , xK_F9), spawn ".xmonad/incvolume.sh")

			-- suspend mode with balls
			, ((mod4Mask , xK_F1), sudoSpawn "pm-suspend")
			
		]
		`additionalKeysP`
		[
			-- volume control / pulseaudio for notebook
			("<XF86AudioMute>", spawn "pactl set-sink-mute 0 toggle")
			, ("<XF86AudioLowerVolume>", spawn ".xmonad/decvolume.sh") 
			, ("<XF86AudioRaiseVolume>", spawn ".xmonad/incvolume.sh")
			
			-- suspend mode with balls for notebook
			, ("<XF86Sleep>", sudoSpawn "pm-suspend")
			
			-- brightness control for notebook
			, ("<XF86MonBrightnessUp>", spawn "xbacklight +10")
			, ("<XF86MonBrightnessDown>", spawn "xbacklight -10")
		]
