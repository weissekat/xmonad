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
		, Run MultiCpu ["-t", "cpu: <autototal>"] 10
		, Run Memory ["-t", "free: <free>/<total>M"] 10
		, Run Battery ["-t", "ac: <acstatus> | bat: <left>%"] 10
		, Run DynNetwork [] 10
		, Run Date "%Y.%m.%d %H:%M:%S" "date" 10
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %multicpu% | %memory% | %battery% | %dynnetwork% | %date% "
}
