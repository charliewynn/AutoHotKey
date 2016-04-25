#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force
Pause::Suspend
#IfWinActive ahk_class WindowsForms10.Window.8.app.0.33c0d9d
{

; Used to exit insertion mode
 InsertMode=0
 #If (InsertMode = 1)   ;non-character variable creation mode
  Enter::
   Gui, Destroy          ;close OSD label
   Send, {insert}
   Send, {end}
   Send, {space %bumper%}
   InsertMode = 0 ; reset
  Return

  Backspace::
   Send, {left}
  Return
 #If

 #If (InsertMode = 2)   ;character variable creation mode
  Enter::
   Gui, Destroy          ;close OSD label
   Send, {insert}
   Send, {end}
   Send, {space}
   Send, {left 2}
   InsertMode = 0 ; reset
  Return

  Backspace::
   Send, {left}
  Return
 #If

 #If (InsertMode = 3)   ;non-character variable array creation mode
  Enter::
   Gui, Destroy          ;close OSD label
   Send, {insert}
   Send, {end}
   Send, {left 1}
   InsertMode = 0 ; reset
  Return

  Backspace::
   Send, {left}
  Return
 #If

 #If (InsertMode = 4)   ;character variable array creation mode
  Enter::
   Gui, Destroy          ;close OSD label
   Send, {insert}
   Send, {end}
   Send, {left 9}
   InsertMode = 0 ; reset
  Return

  Backspace::
   Send, {left}
  Return
 #If

 #If (InsertMode = 5)   ;array-fill mode
  Enter::
   Gosub, ArrayFiller
  return

  NumpadEnter::
   Gosub, ArrayFiller
  return

  ^Enter::                    ;exit array fill mode
   Gosub, ExitArrayFiller
  return

  ^NumpadEnter::              ;exit array fill mode
   Gosub, ExitArrayFiller
  return
 #If

; Used for Character Variable definition
 :oc:VC::
 InsertMode = 2 ; now enter above is valid
 bumper = 1
 Send, {space 30}
 Send, = CHARACTER()
 Send, {left 43}
 Send, {insert}
 displaylabel = Insertion Mode is Active (Ctrl+Enter to Exit)
 Gosub, UpdateOSD
 return

; Used for Date Variable definition
 :oc:VD::
 InsertMode = 1 ; now enter above is valid
 bumper = 11
 Send, {space 30}
 Send, = DATE
 Send, {left 36}
 Send, {insert}
 displaylabel = Insertion Mode is Active (Ctrl+Enter to Exit)
 Gosub, UpdateOSD
 return

; Used for Money Variable definition
 :oc:VM::
 InsertMode = 1 ; now enter above is valid
 bumper = 10
 Send, {space 30}
 Send, = MONEY
 Send, {left 37}
 Send, {insert}
 displaylabel = Insertion Mode is Active (Ctrl+Enter to Exit)
 Gosub, UpdateOSD
 return

; Used for Number Variable definition
 :oc:VN::
 InsertMode = 1 ; now enter above is valid
 bumper = 9
 Send, {space 30}
 Send, = NUMBER
 Send, {left 38}
 Send, {insert}
 displaylabel = Insertion Mode is Active (Ctrl+Enter to Exit)
 Gosub, UpdateOSD
 return

; Used for Rate Variable definition
 :oc:VR::
 InsertMode = 1 ; now enter above is valid
 bumper = 11
 Send, {space 30}
 Send, = RATE
 Send, {left 36}
 Send, {insert}
 displaylabel = Insertion Mode is Active (Ctrl+Enter to Exit)
 Gosub, UpdateOSD
 return

; Used for Character Array Variable definition
 :oc:VCA::
 InsertMode = 4 ; now enter above is valid
 Send, {space 30}
 Send, = CHARACTER() ARRAY()
 Send, {left 51}
 Send, {insert}
 displaylabel = Insertion Mode is Active (Ctrl+Enter to Exit)
 Gosub, UpdateOSD
 return

; Used for Date Array Variable definition
 :oc:VDA::
 InsertMode = 3 ; now enter above is valid
 Send, {space 30}
 Send, = DATE           ARRAY()
 Send, {left 54}
 Send, {insert}
 displaylabel = Insertion Mode is Active (Ctrl+Enter to Exit)
 Gosub, UpdateOSD
 return

; Used for Money Array Variable definition
 :oc:VMA::
 InsertMode = 3 ; now enter above is valid
 Send, {space 30}
 Send, = MONEY          ARRAY()
 Send, {left 54}
 Send, {insert}
 displaylabel = Insertion Mode is Active (Ctrl+Enter to Exit)
 Gosub, UpdateOSD
 return

; Used for Number Array Variable definition
 :oc:VNA::
 InsertMode = 3 ; now enter above is valid
 Send, {space 30}
 Send, = NUMBER         ARRAY()
 Send, {left 54}
 Send, {insert}
 displaylabel = Insertion Mode is Active (Ctrl+Enter to Exit)
 Gosub, UpdateOSD
 return

; Used for Rate Array Variable definition
 :oc:VRA::
 InsertMode = 3 ; now enter above is valid
 Send, {space 30}
 Send, = RATE           ARRAY()
 Send, {left 54}
 Send, {insert}
 displaylabel = Insertion Mode is Active (Ctrl+Enter to Exit)
 Gosub, UpdateOSD
 return

; Comment Code Block
 F6::
  Clipboard = 
  Send, ^x
  Sleep, 200
  Send, ]
  Send, {left 1}
  Send, [
  Send, ^v
  Send, {end}
 return

; Uncomment Code Block
 F7::
  Clipboard = 
  Send, ^x
  Sleep, 200
  StringReplace, clipboard, clipboard, [, , All
  StringReplace, clipboard, clipboard, ], , All
  Send, ^v
 return

; Auto-Align to = or TO
 F8::
  AlignedArray := Object()
  Eq = `=
  j := 0
  alignto = 0
  pad = `_
  Clipboard =
  Send, ^c
  ClipWait
  Loop, parse, clipboard, `n, `r
  {
   Haystack = %A_LoopField%

   IfInString, Haystack, %Eq%
    {
     Needle = `=
     Prefix =
     Trim = 1
    }
   else
    {
     Needle = TO
     Prefix = SET
     Prefix := Prefix . pad
     Trim = 5
    }

   StringGetPos, pos, Haystack, %Needle%
   if (pos > alignto)
    {
     alignto = %pos%
    }
  }

  Loop, parse, clipboard, `n, `r
  {
   bumper = 
   Haystack = %A_LoopField%
   StringReplace, NewStr, Haystack, %A_Space%, `_, all
   StringGetPos, pos, NewStr, %Needle%

   NewStr := SubStr(NewStr,Trim)

   bumpercount := (alignto-pos) + 1
   if (bumpercount > 1)
    {
     Loop %bumpercount%
     {
      bumper := bumper . pad
     }
     StringReplace, NewStr, NewStr, `_, %bumper%
    }
   NewStr := Prefix . NewStr . pad
   StringReplace, NewStr, NewStr, `_, %A_Space%, all

   j += 1
   AlignedArray[j] := NewStr
  }

  templine = 
  clipboard =
  Loop %j%
  {
   templine := AlignedArray[A_Index]
   sleep, 30
   clipboard =
   clipboard = %templine%
   ClipWait,1
   Send, ^v

   if (A_Index < AlignedArray.MaxIndex())
    {
     Send, `n
    }
  }
 return

; Array-Fill Auto-Index Mode
 F9:: 
  indexvar = 0
  InsertMode = 5
  clipboard = 

  Send, {shift}+{home}
  Send, ^c 
  ClipWait

  indexvar+=1
  indexvar:="0" . indexvar

  Send, ^v 
  Send, (
  Send, %indexvar%
  Send, )
  Send, {space}
  Send, = 
  Send, {space}
  Send, {end}

  displaylabel = Array Auto-Index Mode is Active (Ctrl+Enter to Exit)
  Gosub, UpdateOSD
 return 

 ArrayFiller:
  tempclip = %clipboard%
  clipboard = 

  Send, {shift}+{home}
  Send, ^c 
  ClipWait

  Dollar = `$
  HasDollar = 0
  FoundPos = 0
  Wrapper =
  Haystack = %clipboard%
  FoundPos := RegExMatch(Haystack, "=\s(.)", Wrapper)
  StringRight, Wrapper, Wrapper, 1
  clipboard = %tempclip%

  indexvar+=1

  ;pad with 0
  if (indexvar < 10)
   {
    indexvar:="0" . indexvar 
   }

   IfInString, Haystack, %Dollar%
    {
     HasDollar := 1
    }


  Send, {end}
  Send, `n
  Send, ^v
  Send, (
  Send, %indexvar%
  Send, )
  Send, {space}
  Send, = 
  Send, {space}

  if (FoundPos > 0)
   {
    ;don't wrap in dollar sign
    if (HasDollar > 0)
    {
     Send, %Wrapper%
    }
    else
    {
     Send, %Wrapper%
     Send, %Wrapper%
     Send, {end}
     Send, {left}
    }
   }
 return

 ExitArrayFiller:
  Gui, Destroy          ;close OSD label
  InsertMode = 0
  indexvar = 0
  Send, {end}
 return

 UpdateOSD:                                         ;On-Screen Display
  CustomColor = DC143C                              ; Can be any RGB color (it will be made transparent below).
  Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
  Gui, Color, %CustomColor%
  Gui, Font, s10, Courier New, q5
  Gui, Add, Text, vMyText cRed, XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX YYYYYYYYYY  ; XX & YY serve to auto-size the window.
  ; Make all pixels of this color transparent and make the text itself translucent (150):
  WinSet, TransColor, %CustomColor% 150
  GuiControl,, MyText, %displaylabel%
  Gui, Show, x750 y125 NoActivate                   ; NoActivate avoids deactivating the currently active window.
 return
}