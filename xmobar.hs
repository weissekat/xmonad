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
		, Run DynNetwork ["-t", "| net: <fc=green><dev></fc> "] 10
		, Run Battery [
				"-t", "bat: <left><acstatus>"
				, "-L", "10",  "-l", "red" -- when battery low 10%
				,		       "-n", "yellow" -- when battery normal 10..90%
				, "-H", "90", "-h", "green" -- when battery full 90..100%
				, "-S", "True" -- show percentage
				, "--"
				, "-O", " | <fc=yellow>CHARGE</fc>" -- when AC on and charging
				, "-i", " | <fc=green>AC</fc>" -- when AC on and not charging
				, "-o", "" -- when AC off
			] 10
		, Run Date "%Y.%m.%d %H:%M" "date" 10
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %volume% %dynnetwork%| %battery% | %date% "
}
