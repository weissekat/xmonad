Config { 
    font = "xft:Droid Sans Mono:size=12:bold:antialias=true"
    position = Top,
	lowerOnStart = True,
    hideOnStart = False,
    allDesktops = True,
    overrideRedirect = True,
    persistent = True
    commands = [
		Run StdinReader
		, Run Memory ["-t", "free: <buffer>/<total>M"] 10 --fuck it, its free nor buffer!
		, Run Com ".xmonad/getvolume.sh" [] "volume" 10
		, Run DynNetwork ["-t", "| net: <fc=green><dev></fc> "] 10
		, Run Date "%Y.%m.%d %H:%M" "date" 10
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %memory% | %volume% %dynnetwork%| %date% "
}
