import XMonad
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys,removeKeys)

main = do
	xmonad $ defaultConfig { 
			-- WIN-key as modkey --
			modMask = mod4Mask
			-- tune and colorize borders --
			,borderWidth           = 3
			,normalBorderColor  = "grey"
			,focusedBorderColor  = "green"
		}
		`additionalKeys`
		[
			-- change keyboard layout --
			((controlMask, xK_Shift_L), spawn "~/.xmonad/keyboard-switch.sh") 
		]
