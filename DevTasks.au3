
; Shortcuts for my common development tasks

; for _IsPressed()
#include <Misc.au3>

; ! = ALT
; + = SHIFT
; ^ = CTRL
HotKeySet("!+1", "ActivateTerminal1")
HotKeySet("!+2", "ActivateTerminal2")
HotKeySet("!+3", "ActivateTerminal3")
HotKeySet("!+4", "ActivateTerminal4")
HotKeySet("!+b", "VimToRdeCopy")
HotKeySet("!+h", "ShortcutHelp")
HotKeySet("!+i", "ActivateIbm2")
HotKeySet("!+j", "ActivateGVIM")
HotKeySet("!+l", "ActivateLinxdev21")
HotKeySet("!+p", "ResizeProdWindows")
HotKeySet("!+q", "Terminate")
HotKeySet("!+r", "ResizeDevWindows")
HotKeySet("!+s", "SXBL_Message")
HotKeySet("!+u", "Uuid")
HotKeySet("!+v", "RdeToVimCopy")

; Configuration Globals
Local $resolution[2] = [5120, 1440]
Local $vimLeader = "\"
Local $uuid = "11795629"

Local $savedLinxWin
Local $savedIbmWin

While(1)
    Sleep(500)
WEnd


;;;;;;;;;;;;;;;;;;;;;;;;;;;; Functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
        & "!+p  Resize Prod Windows" & @CRLF _
        & "!+r  Resize Dev Windows" & @CRLF _
        & "!+u  Uuid" & @CRLF _
        & "!+v  RdeToVimCopy" & @CRLF _
        & "!+b  VimToRdeCopy" & @CRLF _
        & @CRLF _
        & " Terminal Functions: " & @CRLF _
        & "!+a  Test SXAD" & @CRLF _
        & @CRLF _
        , 0, 0)

    Sleep(10000)
    ToolTip("")
EndFunc

; Move and resize ibm2, linxdev21, and GVIM
Func ResizeDevWindows()
    ClearModifiers()
	
	Local $startMenuHeight = 40
	
	; Right side of left monitor
    Local $linxSize[2] = [900, 1440 - $startMenuHeight]
    Local $linxPos[2] = [$resolution[0] / 2 - $linxSize[0], 0]

	; Right side of right monitor
    Local $ibmSize[2] = [800, 1440]
    Local $ibmPos[2] = [$resolution[0] - $ibmSize[0], 0]
	
	; Left side of right monitor
    Local $gvimSize[2] = [($resolution[0] / 2) - $ibmSize[0], 1440]
    Local $gvimPos[2] = [$resolution[0] / 2, 0]


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
EndFunc

; Move and Resize OP1 Production Windows
Func ResizeProdWindows()
    ClearModifiers()
	
	; Position to put the first prod window
	Local $startCoord[2] = [$resolution[0] / 2, 0]
	
	Local $windowSize[2] = [800, 600]
	Local $windowsPerRow = 3
	Local $prodNames[6] = ["y895-op1-console", "j896-op1-console", "y897-op1-console", "j898-op1-console", "y753-op1-console", "j754-op1-console"]
	
	Local $movedWindows = 0
	
	For $i = 0 To UBound($prodNames) - 1
		Local $thisWin = WinActivate($prodNames[$movedWindows])
		If($thisWin) Then
			Local $xCoord = Mod($movedWindows, $windowsPerRow)
			Local $yCoord = Int(($movedWindows / $windowsPerRow))
			Local $thisWinPos[2] = [$startCoord[0] + ($windowSize[0] * $xCoord), $startCoord[1] + ($windowSize[1] * $yCoord)]
				
			WinMove($thisWin, $prodNames[$movedWindows], $thisWinPos[0], $thisWinPos[1], $windowSize[0], $windowSize[1])
			
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

; Load the SXAD function with my UUID and
Func TestSXAD()
    ClearModifiers()
    Local $funcCall = "RRRR SXAD 290 537539E70086055A0364052D" & " /" & $uuid
	
	TerminalFunction($funcCall)
EndFunc


Func RdeToVimCopy()
    Opt("WinTitleMatchMode", 2) ; substring match
    If Not WinActivate("Bloomberg Rapid Development Environment") Then
        ErrorTooltip("Could not find Rapid.")
        Return
    Endif
    ClearModifiers()
    Sleep(250)
    Send("{CTRLDOWN}a")
    Sleep(100)
    Send("c")
    ClearModifiers()

    If Not WinActivate("VIM") Then
        ErrorTooltip("Could not find Vim.")
        Return
    EndIf
    Send(":tabe{ENTER}")
    Send('"*P{ENTER}')
    Send(":set syntax=javascript{ENTER}")
    Send($vimLeader & $vimLeader & "w")     ;; Remove trailing whitespace (my vimrc)
    Send("gg")

    ClearModifiers()
EndFunc

Func VimToRdeCopy()
    Opt("WinTitleMatchMode", 2) ; substring match
    If Not WinActivate("VIM") Then
        ErrorTooltip("Could not find Vim.")
        Return
    EndIf
    Send("{ESCAPE}")
    Send("gg{SHIFTDOWN}v")
    Sleep(100)
    Send("g")
    ClearModifiers()
    Send("{CTRLDOWN}c")

    If Not WinActivate("Bloomberg Rapid Development Environment") Then
        ErrorTooltip("Could not find Rapid.")
        Return
    Endif

    ClearModifiers()
    Sleep(250)
    Send("{CTRLDOWN}a")
    ClearModifiers()
    Sleep(100)
    Send("{DELETE}")
    Send("{CTRLDOWN}v")
    ClearModifiers()
EndFunc

Func ActivateGVIM()
    ClearModifiers()
	Opt("WinTitleMatchMode", 2) ; substring match
	WinActivate("GVIM")
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;; Helpers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Clear shift/ctrl/alt to prevent them from getting stuck or the script executing while the user
; is still holding them down.
Func ClearModifiers()
    While(_IsPressed(10) Or _IsPressed(11) Or _IsPressed(12))
        Send("{SHIFTUP}")
        Send("{CTRLUP}")
        Send("{ALTUP}")
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; WIP ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Func SXBL_Message()
	
EndFunc

Func AjamPort()
EndFunc




; Starts IBM2 and LinxDev21, then resize and position the windows
Func ToolkitStartup()
    ClearModifiers()

    ; Function Variables
    Local $ibmOffset[2] = [0, 0]        ; ibm2
    Local $linxOffset[2] = [0, 0]       ; linxdev21


    Local $toolkitHandle = WinActivate("Toolkit")
    Local $toolkitPos = WinGetPos("Toolkit")

    ; debug
    MsgBox("", "Toolkit [x, y] position", "[" & $toolkitPos[0] & ", " & $toolkitPos[1] & "]")

    ; TODO - Open the windows

    ResizeXterm()
EndFunc

Func Terminate()
    Exit 0
EndFunc
