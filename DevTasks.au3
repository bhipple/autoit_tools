; Shortcuts for common development tasks

; for _IsPressed()
#include <Misc.au3>

; ! = ALT
; + = SHIFT
; ^ = CTRL
HotKeySet("!+t", "ToolkitStartup")
HotKeySet("!+a", "TestSXAD")

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

Func TestSXAD()
	ClearModifiers()

	Send("{ENTER}")
	Send("SXAD{ENTER}")
	Sleep(1250)
	Send("{TAB}")
	Sleep(100)
	Send("53615494024701AC003906B6")
	Sleep(100)
	Send("{TAB}")
	Sleep(100)
	Send("ME{ENTER}")
	Sleep(100)
	Send("{ENTER}")
	Sleep(100)
EndFunc


Func ClearModifiers()	
	While(_IsPressed(10))
		Send("{SHIFTUP}")
	WEnd
	
	While(_IsPressed(11))
		Send("{CTRLUP}")
	WEnd
	
	While(_IsPressed(12))
		Send("{ALTUP}")
	WEnd
EndFunc

Func Terminate()
    Exit 0
EndFunc
