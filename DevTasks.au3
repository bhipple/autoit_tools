;; ============================================================================
;;                      Shortcuts for Common Dev Tasks
;; ============================================================================

; for _IsPressed()
#include <Misc.au3>

; Configuration Globals
Local $resolution[2] = [5120, 1440]
Local $vimLeader = "\"
Local $uuid = "11795629"
Local $startMenuHeight = 0
Local $startMenuWidth = 260

Local $savedLinxWin
Local $savedIbmWin

Local $puttySubstring = "(gateway:"


;; ============================================================================
;;                                  Hotkeys
;; ============================================================================
; ! = ALT
; + = SHIFT
; ^ = CTRL
HotKeySet("!+1", "ActivateTerminal1")
HotKeySet("!+2", "ActivateTerminal2")
HotKeySet("!+3", "ActivateTerminal3")
HotKeySet("!+4", "ActivateTerminal4")
HotKeySet("!+b", "ActivateIB")
HotKeySet("!+c", "ActivateChrome")
HotKeySet("!+d", "ActivateRDE")
HotKeySet("!+h", "ShortcutHelp")
HotKeySet("!+i", "ActivateIbm2")
HotKeySet("!+j", "ActivatePutty")
HotKeySet("!+l", "ActivateLinxdev21")
HotKeySet("!+o", "ResizeSCIQWindows")
HotKeySet("!+p", "ResizeProdWindows")
HotKeySet("!+q", "Terminate")
HotKeySet("!+r", "ResizeDevWindows")
HotKeySet("!+u", "Uuid")

While(1)
    Sleep(25)
WEnd

;; ============================================================================
;;                                 Functions
;; ============================================================================

; Shows ToolTip with keyboard shortcuts for functions
Func ShortcutHelp()
    ClearModifiers()

    ToolTip("Shortcuts" & @CRLF _
        & " Script Functions: " & @CRLF _
        & "!+h  Shortcut Help" & @CRLF _
        & "!+q  Terminate" & @CRLF _
        & @CRLF _
        & " Windows Functions: " & @CRLF _
        & "!+[1-4]  Activate Terminal 1-4" & @CRLF _
        & "!+b  Activate IB" & @CRLF _
        & "!+c  Activate Chrome" & @CRLF _
        & "!+p  Resize Prod Windows" & @CRLF _
        & "!+r  Resize Dev Windows" & @CRLF _
        & "!+u  Uuid" & @CRLF _
        & @CRLF _
        & " Terminal Functions: " & @CRLF _
        & @CRLF _
        , 0, 0)

    Sleep(10000)
    ToolTip("")
EndFunc

; Move and resize ibm2, linxdev21, and GVIM
Func ResizeDevWindows()
    ClearModifiers()
	
	; Right side of left monitor
    Local $linxSize[2] = [900, 1440 - $startMenuHeight]
    Local $linxPos[2] = [$resolution[0] / 2 - $linxSize[0], 0]

	; Right side of right monitor
    Local $ibmSize[2] = [800, 1440]
    Local $ibmPos[2] = [$resolution[0] - $ibmSize[0], 0]
	
	; Left side of right monitor
    Local $gvimSize[2] = [($resolution[0] / 2) - $ibmSize[0], 1440]
    Local $gvimPos[2] = [$resolution[0] / 2, 0]
	
	; All of right monitor, half of left monitor
	;Local $puttySize[2] = [(2560 + ((2560 - $startMenuWidth)/2)), 1440]
	Local $puttySize[2] = [(800 + 2560), 1440]
	Local $puttyPos[2] = [2560 * 2 - $puttySize[0], 0]

	; Move the windows
    Local $ibmWin = WinActivate("ibm2")
    If($ibmWin) Then
        WinMove($ibmWin, "ibm2", $ibmPos[0], $ibmPos[1], $ibmSize[0], $ibmSize[1])
		$savedIbmWin = $ibmWin
    EndIf

    Local $linxWin = WinActivate("linxdev21")
    If($linxWin) Then
        WinMove($linxWin, "linxdev21", $linxPos[0], $linxPos[1], $linxSize[0], $linxSize[1])
		$savedLinxWin = $linxWin
    EndIf
	
    Opt("WinTitleMatchMode", 2) ; substring match
	Local $gvim = WinActivate("GVIM")
	If($gvim) Then
		WinMove($gvim, "GVIM", $gvimPos[0], $gvimPos[1], $gvimSize[0], $gvimSize[1])
	EndIf
	
	Local $putty = WinActivate($puttySubstring)
	If($putty) Then
		WinMove($putty, "(gateway:", $puttyPos[0], $puttyPos[1], $puttySize[0], $puttySize[1])
	EndIf
EndFunc

Func ResizeProdWindows()
	ClearModifiers()
	Local $prodNames[6] = ["y895-op1-console", "j896-op1-console", "y897-op1-console", "j898-op1-console", "y753-op1-console", "j754-op1-console"]
	ResizeOpWindows($prodNames)
EndFunc

Func ResizeSCIQWindows()
	ClearModifiers()
	Local $sciqNames[4] = ["y893-op1-console", "j894-op1-console", "y481-op1-console", "j482-op1-console"]
	ResizeOpWindows($sciqNames)
EndFunc

; Move and Resize OP1 Windows
Func ResizeOpWindows($windowNames)
    ClearModifiers()
	
	; Position to put the first op window
	Local $startCoord[2] = [$resolution[0] / 2, 0]
	
	Local $windowSize[2] = [800, 600]
	Local $windowsPerRow = 3
	Local $movedWindows = 0
	
	For $i = 0 To UBound($windowNames) - 1
		Local $thisWin = WinActivate($windowNames[$movedWindows])
		If($thisWin) Then
			Local $xCoord = Mod($movedWindows, $windowsPerRow)
			Local $yCoord = Int(($movedWindows / $windowsPerRow))
			Local $thisWinPos[2] = [$startCoord[0] + ($windowSize[0] * $xCoord), $startCoord[1] + ($windowSize[1] * $yCoord)]
				
			WinMove($thisWin, $windowNames[$movedWindows], $thisWinPos[0], $thisWinPos[1], $windowSize[0], $windowSize[1])
			
			$movedWindows = $movedWindows + 1
		Endif
	Next
	
    ClearModifiers()
EndFunc

; Paste my UUID
Func Uuid()
    ClearModifiers()
    Send($uuid)
EndFunc

Func ActivateGVIM()
    ClearModifiers()
	Opt("WinTitleMatchMode", 2) ; substring match
	WinActivate("GVIM")
EndFunc

Func ActivateRDE()
    ClearModifiers()
	Opt("WinTitleMatchMode", 2) ; substring match
	WinActivate("Bloomberg Rapid Development Environment")
EndFunc

Func ActivatePutty()
    ClearModifiers()
	Opt("WinTitleMatchMode", 2) ; substring match
	WinActivate($puttySubstring)
EndFunc

Func ActivateLinxdev21()
    ClearModifiers()
	If Not WinActivate("linxdev21") Then
		WinActivate($savedLinxWin)
	EndIf
EndFunc

Func ActivateIbm2()
    ClearModifiers()
	If Not WinActivate("ibm2") Then
		WinActivate($savedIbmWin)
	EndIf
EndFunc

Func ActivateIB()
    ClearModifiers()
	WinActivate("IB - IB Manager")
EndFunc

Func ActivateChrome()
    ClearModifiers()
	Opt("WinTitleMatchMode", 2) ; substring match
	WinActivate("- Google Chrome")
EndFunc

Func ActivateTerminal1()
	ClearModifiers()
	WinActivate("1-BLOOMBERG")
EndFunc

Func ActivateTerminal2()
	ClearModifiers()
	WinActivate("2-BLOOMBERG")
EndFunc

Func ActivateTerminal3()
	ClearModifiers()
	WinActivate("3-BLOOMBERG")
EndFunc

Func ActivateTerminal4()
	ClearModifiers()
	WinActivate("4-BLOOMBERG")
EndFunc

Func Terminate()
    Exit 0
EndFunc

;; ============================================================================
;;                                  Helpers
;; ============================================================================

; Clear shift/ctrl/alt to prevent them from getting stuck or the script executing while the user
; is still holding them down.
Func ClearModifiers()
    While(_IsPressed(10) Or _IsPressed(11) Or _IsPressed(12))
        Send("{SHIFTUP}")
        Send("{CTRLUP}")
        Send("{ALTUP}")
		Sleep(25)
    WEnd
EndFunc

Func TerminalFunction($str)
    Opt("WinTitleMatchMode", 2) ; substring match
	If Not WinActive("Bloomberg") Then
		ErrorTooltip("Activate the Terminal Window first!")
		Return
	EndIf
	
    Send("{ENTER}")	; active cmdline
	Sleep(100)
	Send($str)
    Send("{ENTER}")
EndFunc

Func ErrorTooltip($msg)
    Local $mousePos = MouseGetPos()

    ToolTip($msg, $mousePos[0], $mousePos[1])
    Sleep(3000)
    ToolTip("")
EndFunc


;; ============================================================================
;;                                    WIP
;; ============================================================================

;HotKeySet("{CAPSLOCK}", "CapsLockToCtrl")
;Opt("SendCapslockMode", 0)
Func CapsLockToCtrl()
	Send("{CTRLDOWN}")
	While(_IsPressed(14));~ 		Sleep(10)
	WEnd
	Send("{CTRLUP}")
	Send("{CAPSLOCK}")
	Send("{CAPSLOCK off}")
EndFunc
