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
		, Run Com ".xmonad/getvolume.sh" [] "volume" 10
		, Run DynNetwork ["-t", "<dev>"] 10
		, Run Battery [
				"-t", "<acstatus> <left>"
				, "-L", "10",  "-l", "red" -- when battery low 10%
				,		       "-n", "yellow" -- when battery normal 10..80%
				, "-H", "80", "-h", "green" -- when battery full 80..100%
				, "-S", "True" -- show percentage
				, "--"
				, "-O", "<fc=green>AC</fc>" -- when AC on and charging
				, "-i", "AC:" -- when AC on and not charging
				, "-o", "BAT:" -- when AC off
			] 10
		, Run Date "%Y.%m.%d %H:%M:%S" "date" 10
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %volume% | %dynnetwork% | %battery% | %date% "
}
