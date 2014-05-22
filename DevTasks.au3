
; Shortcuts for my common development tasks

; for _IsPressed()
#include <Misc.au3>

; ! = ALT
; + = SHIFT
; ^ = CTRL
HotKeySet("!+a", "TestSXAD")
HotKeySet("!+b", "VimToRdeCopy")
HotKeySet("!+h", "ShortcutHelp")
HotKeySet("!+q", "Terminate")
HotKeySet("!+r", "ResizeXterm")
HotKeySet("!+u", "Uuid")
HotKeySet("!+v", "RdeToVimCopy")

; Configuration Globals
Local $resolution[2] = [5120, 1440]
Local $vimLeader = "\"
Local $uuid = "11795629"

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
        & "!+r  Resize XTerm" & @CRLF _
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

; Move and resize ibm2 and linxdev21
Func ResizeXterm()
    ClearModifiers()

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
