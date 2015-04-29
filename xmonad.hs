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
		voDevClass = ["Geany", "Xfce4-terminal", "Gnome-terminal"]
		voMsgClass = ["Skype", "Pidgin"]
		voMusClass = ["Audacious", "Rhythmbox"]

main = do
	-- spawn xmobar pipe
	xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobar.hs"
	
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
		]
