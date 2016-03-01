import XMonad
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.Script
import XMonad.Util.Run
import XMonad.Util.EZConfig
import System.IO

voWorkspaces :: [String]
voWorkspaces = ["1:ein","2:zwei","3:drei","4:vier","5:fünf","6:sechs","7:sieben","8:acht","9:neun","0:null"]

voManageHook :: ManageHook
voManageHook = composeAll . concat $
    [
        [manageDocks]
        , [ className =? c --> doShift "1:ein"    | c <- voEinClass    ]
        , [ className =? c --> doShift "2:zwei"   | c <- voZweiClass   ]
        , [ className =? c --> doShift "3:drei"   | c <- voDreiClass   ]
        , [ className =? c --> doShift "4:vier"   | c <- voVierClass   ]
        , [ className =? c --> doShift "5:fünf"   | c <- voFunfClass   ]
        , [ className =? c --> doShift "6:sechs"  | c <- voSechsClass  ]
        , [ className =? c --> doShift "7:sieben" | c <- voSiebenClass ]
        , [ className =? c --> doShift "8:acht"   | c <- voAchtClass   ]
        , [ className =? c --> doShift "9:neun"   | c <- voNeunClass   ]
        , [ className =? c --> doShift "0:null"   | c <- voNullClass   ]
    ] where
        voEinClass    = []
        voZweiClass   = []
        voDreiClass   = []
        voVierClass   = []
        voFunfClass   = []
        voSechsClass  = []
        voSiebenClass = ["Pidgin"]
        voAchtClass   = ["Thunderbird"]
        voNeunClass   = []
        voNullClass   = []

voStartupHook :: X ()
voStartupHook = do
    -- run xkb config on startup
    spawn "~/.xmonad/initkey.sh"

    -- run work apps
    spawn "pidgin"
    spawn "thunderbird"

-- spawn with balls; warning, you password shows on screen and may be saved if historySize > 0
xpConfig = defaultXPConfig { font = "-misc-fixed-*-*-*-*-20-*-*-*-*-*-*-*", position = Bottom, historySize = 0 }
withPrompt prompt fn = inputPrompt xpConfig prompt ?+ fn
sudoSpawn command = withPrompt "Password" $ run command
    where run command password = spawn $ concat ["echo ", password, " | sudo -S ", command]

main = do
    -- spawn xmobar pipe
    xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobar.hs"

    -- fix for incorrect GTK theme; config: "gtk-theme-config", "xfce4-appearance-settings"
    spawn "xfsettingsd"

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

            , startupHook = voStartupHook
        }
        `additionalKeys`
        [
            -- increase font for "dmenu"; however, dmenu haven't support for lovely antialiased Droid Sans/Monospace
            ((mod4Mask, xK_p), spawn "dmenu_run -fn \"-misc-fixed-*-*-*-*-20-*-*-*-*-*-*-*\"")

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

            -- lock screen
            , ((mod4Mask .|. shiftMask, xK_l), spawn "slock")
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
        `removeKeys`
        [
            (controlMask, xK_Shift_L)
        ]
