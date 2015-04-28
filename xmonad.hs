import XMonad
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

main = do
	xmonad $ defaultConfig 
		{ 
			modMask = mod4Mask
		} `additionalKeys` 
		[
			-- change keyboard layout --
			((controlMask, xK_Shift_L), spawn "~/.xmonad/keyboard-switch.sh") 
		]
