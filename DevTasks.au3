; Shortcuts for common development tasks

HotKeySet("!+t", "ToolkitStartup")

HotKeySet("!+q", "Terminate")
HotKeySet("{END}", "Terminate")


While(1)
	Sleep(1000)
WEnd

; Starts IBM2 and LinuxDev21, then resize and position the windows
Func ToolkitStartup()
	; Function Variables
	Local $ibmOffset[2] = [0, 0]		; ibm2
	Local $linxOffset[2] = [0, 0]		; linxdev21
	
	
	Local $toolkitHandle = WinActivate("Toolkit")
	Local $toolkitPos = WinGetPos("Toolkit")
	
	; debug
	MsgBox("", "Toolkit [x, y] position", "[" & $toolkitPos[0] & ", " & $toolkitPos[1] & "]")

	; TODO - Resize, position
	
	
EndFunc


Func Terminate()
    Exit 0
EndFunc
