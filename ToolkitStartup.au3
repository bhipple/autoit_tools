; Opens IBM2 and Linxdev21, then automatically positions and resizes the windows
; according to my preferences.

HotKeySet("{F11}", "IBM_Linux_Startup")
HotKeySet("{END}", "Terminate")

Local $ibmOffset[2] = [0, 0]		; ibm2
Local $linxOffset[2] = [0, 0]		; linxdev21

While(1)
	Sleep(1000)
WEnd

Func IBM_Linux_Startup()
	Local $toolkitHandle = WinActivate("Toolkit")
	Local $toolkitPos = WinGetPos("Toolkit")
	
	; debug
	MsgBox("", "Toolkit [x, y] position", "[" & $toolkitPos[0] & ", " & $toolkitPos[1] & "]")

	
EndFunc


Func Terminate()
    Exit 0
EndFunc
