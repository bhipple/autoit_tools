; Shortcuts for my common development tasks

; for _IsPressed()
#include <Misc.au3>

; ! = ALT
; + = SHIFT
; ^ = CTRL
HotKeySet("!+a", "TestSXAD")
HotKeySet("!+h", "ShortcutHelp")
HotKeySet("!+r", "ResizeXterm")
HotKeySet("!+t", "ToolkitStartup")
HotKeySet("!+u", "Uuid")
HotKeySet("!+q", "Terminate")

Local $resolution[2] = [5120, 1440]

While(1)
	Sleep(500)
WEnd

; Shows ToolTip with keyboard shortcuts for functions
Func ShortcutHelp()
	ClearModifiers()
	ToolTip("Shortcuts" & @CRLF _
		& "!+a	Test SXAD" & @CRLF _
		& "!+h	Shortcut Help" & @CRLF _
		& "!+q	Terminate" & @CRLF _
		& "!+r	Resize XTerm" & @CRLF _
		& "!+t	ToolkitStartup" & @CRLF _
		& "!+u	Uuid" & @CRLF _
		, 0, 0)
	Sleep(10000)
	ToolTip("")
EndFunc

; Starts IBM2 and LinxDev21, then resize and position the windows
Func ToolkitStartup()
	ClearModifiers()
	
	; Function Variables
	Local $ibmOffset[2] = [0, 0]		; ibm2
	Local $linxOffset[2] = [0, 0]		; linxdev21
	
	
	Local $toolkitHandle = WinActivate("Toolkit")
	Local $toolkitPos = WinGetPos("Toolkit")
	
	; debug
	MsgBox("", "Toolkit [x, y] position", "[" & $toolkitPos[0] & ", " & $toolkitPos[1] & "]")

	; TODO - Resize, position
EndFunc

; Move and resize ibm2 and linxdev21
Func ResizeXterm()
	Local $ibmSize[2] = [800, 1440]
	Local $ibmPos[2] = [$resolution[0] - $ibmSize[0], 0]
	
	Local $linxSize[2] = [($resolution[0] / 2) - $ibmSize[0], 1440]
	Local $linxPos[2] = [$resolution[0] / 2, 0]
	
	Local $ibmWin = WinActivate("ibm")
	If($ibmWin) Then
		WinMove($ibmWin, "ibm2", $ibmPos[0], $ibmPos[1], $ibmSize[0], $ibmSize[1])
	EndIf
	
	Local $linxWin = WinActivate("linxdev21")
	If($linxWin) Then
		WinMove($linxWin, "linxdev21", $linxPos[0], $linxPos[1], $linxSize[0], $linxSize[1])
	EndIf
EndFunc

; Paste my UUID
Func Uuid()
	ClearModifiers()
	Send("11795629")
EndFunc

Func TestSXAD()
	ClearModifiers()

	Send("{ENTER}")
	Send("SXAD 53615494024701AC003906B6 /11795629{ENTER}")
EndFunc

; Clear shift/ctrl/alt to prevent them from getting stuck or the script executing while the user
; is still holding them down.
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
