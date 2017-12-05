;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#InstallKeybdHook
#UseHook ON
#SingleInstance force
Pause::Suspend
#r:: Reload

global InsertMode = 0

; ! - ALT
; + - Shift
; ^ - Control
; # - WINKey
; * - Capture all modifiers - resend them with {blind}

;#k::
;ToolTip, {%InsertMode%}`nTooltip, 100, 150
;return

;IfWinActive ahk_exe eclipse.exe
#IfWinActive ahk_exe eclipse.exe
; SNIPPET: Comment
  :oc:COM::
	  InsertMode = 6 ; now enter above is valid
	  Send, []
	  Send, {left 1}
	  return

; SNIPPET: Comment
  :oc:ROM::
	  InsertMode = 6 ; now enter above is valid
	  Send, []
	  Send, {left 1}
	  return

  #h::
	  ToolTip, {%InsertMode%}`nTooltip, 100, 150
      InsertMode = 0
	  return

	; SNIPPET: Open Single Quote
  '::
	if (InsertMode != 6) {
	InsertMode = 6 ; now enter above is valid
	Send ''
	Send {left 1}
	}
	return

#IfWinActive
