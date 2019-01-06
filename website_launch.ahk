#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendgithMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Naively launches whatever's on the clipboard in google chrome using Win+o
#o::
    Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "%clipboard%"
    Return
