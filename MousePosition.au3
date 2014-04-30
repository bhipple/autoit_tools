; Get information about the mouse position
; for grabbing coordinates during development

HotKeySet("!+s", "UpdatePosition")

HotKeySet("!+q", "Terminate")
HotKeySet("{END}", "Terminate")

Local $savedPos[2] = [0,0]

While(1)
	Local $cur = MouseGetPos()
	ToolTip("Current: [" & $cur[0] & ", " & $cur[1] & "]" & @CRLF & _
		"Saved: [" & $savedPos[0] & ", " & $savedPos[1] & "]" _
		, $cur[0], $cur[1])
	
	Sleep(50)
WEnd

Func UpdatePosition()
	$savedPos = MouseGetPos()
EndFunc


Func Terminate()
    Exit 0
EndFunc
