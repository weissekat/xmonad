import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys,removeKeys)
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
			
			-- volume control
			, ((mod4Mask , xK_F7), spawn "amixer set Master off && amixer set Headphone off")
			, ((mod4Mask , xK_F8), spawn "amixer set Master on && amixer set Headphone on && amixer set Master 2-") 
			, ((mod4Mask , xK_F9), spawn "amixer set Master on && amixer set Headphone on && amixer set Master 2+")
		]
