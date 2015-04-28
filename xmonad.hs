import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys,removeKeys)

voWorkspaces :: [String]
voWorkspaces = ["1:dev","2:web","3:msg","4:music"] ++ map show [5..9]

voManageHook :: ManageHook
voManageHook = composeAll . concat $
	[
		[manageDocks]
		, [ className =? c --> doShift "1:dev" | c <- voDevClass ]
		, [ className =? c --> doShift "2:web" | c <- voWebClass ]
		, [ className =? c --> doShift "3:msg" | c <- voMsgClass ]
		, [ className =? c --> doShift "4:music" | c <- voMusClass ]
   	] where
		voDevClass = ["Geany", "Xfce4-terminal"]
		voWebClass = ["Google-chrome", "Firefox"]
		voMsgClass = ["Skype", "Pidgin"]
		voMusClass = ["Audacious", "Rhythmbox"]

main = do
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
		}
		`additionalKeys`
		[
			-- change keyboard layout
			((controlMask, xK_Shift_L), spawn "~/.xmonad/keyboard-switch.sh") 
		]
