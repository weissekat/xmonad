Config { 
    font = "xft:Droid Sans Mono:size=10:bold:antialias=true"
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
		, Run Swap ["-t", "swap: <used>/<total>M"] 10
		, Run DynNetwork [] 10
		, Run Date "%Y.%m.%d %H:%M:%S" "date" 10
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %multicpu% | %memory% | %swap% | %dynnetwork% | %date% "
}
