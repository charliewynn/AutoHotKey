; ! - ALT
; + - Shift
; ^ - Control
; # - WINKey
; * - Capture all modifiers - resend them with {blind}

#UseHook ON

#Persistent

;Run %A_AHKPath% "active_window_indicator.ahk"
;Run %A_AHKPath% "cursor_crosshair.ahk"
Run %A_AHKPath% "MuteOnLock.ahk"



Pause::Suspend


#InstallKeybdHook

SetCapsLockState, alwaysoff

;f24 is the fs edge left space
;if I just tap it I want to send a space
f24::
Send {f24 Down}
KeyWait, f24
Send {f24 Up}
if( A_PriorHotkey = "F24")
{
  Send {Enter}
}
return 
f24 & h::Send {left}
f24 & l::Send {right}
f24 & j::Send {down}
f24 & k::Send {up}
f24 & d::Send {Backspace}
f24 & t::Send {{}
f24 & n::Send {}}
f24 & u::Send {CtrlDown}Z{CtrlUp}
f24 & i::Send {Home}
f24 & a::Send {End}
f24 & 1::Send #1
f24 & 2::Send #2
f24 & 3::Send #3
f24 & 4::Send #4

Capslock::
Send {LControl Down}
KeyWait, CapsLock
Send {LControl Up}
if ( A_PriorKey = "CapsLock" )
{
Send {Esc}
}
return


LShift::
Send {LShift Down}
KeyWait, LShift
Send {LShift Up}
if ( A_PriorKey = "LShift" )
{
Send (
}

if ( A_PriorKey = "RShift" )
{
Send ()
}
return

#IfWinNotActive ahk_class Vim
;^Backspace:: SEND ^+{Left}{Backspace}
#IfWinNotActive

RShift::
Send {RShift Down}
KeyWait, RShift
Send {RShift Up}
if ( A_PriorKey = "RShift" )
{
Send )
}if ( A_PriorKey = "LShift" )
{
Send ()
}
return


LCtrl::
Send {LCtrl Down}
KeyWait, LCtrl
Send {LCtrl Up}
if ( A_PriorKey = "LControl" )
{
Send {{}
}
if ( A_PriorKey = "RControl" )
{
Send {{}{}}
}
if (A_PriorKey = "LShift" )
{
  send <
}
return

RCtrl::
Send {RCtrl Down}
KeyWait, RCtrl
Send {RCtrl Up}
if ( A_PriorKey = "RControl" )
{
Send {}}
}if ( A_PriorKey = "LControl{}" )
{
Send {{}{}}
}
if (A_PriorKey = "RShift" )
{
  send >
}
return

^!a:: send "abcdefghijklmnopqrstuvwxyz"

SetTitleMatchMode, Regex

#IfWinActive ahk_class Chrome_WidgetWin_1
  ^+,:: return
  ^+z:: return
  ^+x:: return
#IfWinActive

^!r:: Reload

; f1:: send {RAlt up}{LAlt up}{Alt up}{RCtrl up}{LCtrl up}{Ctrl up}{LShift up}{RShift up}{Shift up}
^f1::send {ctrl down}{f1}{ctrl up}
f2::f2
f3::f3
f4::f4
f5::f5
f6::f6
f7::f7
f8::f8
f9::f9
f10::f10
f11::f11
f12::f12
f13::f13
f14::f14
f15::f15
f16::f16
f17::f17
f18::f18
  

;M1 set of g keys g1-g18

f4 & 2::
  send BEGIN{enter}
  send {space}{space}raiserror('',16,1){enter}
  send return{enter}
  send {backspace}{backspace}end{up}{up}{ctrl down}{right}{ctrl up}{right}{right}
return

f4 & 3::
  send $.post(baseURL {+} 'api/sp/mystoredproc', data).done(function (data) {{}{enter}
  send if ({!}data.success) {{}{enter}
  send alert("Could not DOSOMETHING\r" {ooba+} data.data);{enter}return;
return

f1 & 1:: send DECLARE @StartDate DATETIME{enter}SET @StartDate = '1/1/14'{enter}
f2 & 1:: send DECLARE @EndDate DATETIME{enter}SET @EndDate = '10/1/14'{enter}
f3 & 1:: send DECLARE @param INT{enter}SET @param = 1{enter}
f4 & 1:: send SELECT * FROM{space}
f5 & 1::
  FormatTime, today,, MM/dd/yy
  yesterday = %a_now%
  yesterday += -1, days
  FormatTime, yesterday, %yesterday%, MM/dd/yy  
  send WHERE updated BETWEEN '%yesterday%' AND '%today%'
return

f6 & 1:: send {enter}cmd.Parameters.AddWithValue("@opId", Operator);
f9 & 1:: send {enter}drTmp.SelectCommand.Parameters.AddWithValue("@opId", Operator);
f12 & 1:: send {space}AND operatorId = @opId

;m2 set of keys
f1 & 2::
  oldClip = %Clipboard%
  Clipboard =   ;empty Clipboard
  send {shift down}{home}{shift up}
  SendInput, ^c
  ClipWait
  StringSplit, word_array, Clipboard, %A_Space%, . ; Omits periods.
      send private %word_array1% _%word_array2%;{enter}public %word_array1% %word_array2%{enter}{{}{enter}get {{} return _%word_array2%; {}}{enter}set{enter}{{}{enter}_%word_array2% = value;{enter}NotifyPropertyChanged("%word_array2%");{enter}{}}{enter}{}}{enter}{f1 up}
  Clipboard = %oldClip%
return

f2 & 2::
  oldClip = %Clipboard%
  Clipboard =   ;empty Clipboard
  send {shift down}{home}{shift up}
  SendInput, ^c
  ClipWait
  StringSplit, word_array, Clipboard, %A_Space%, . ; Omits periods.
      send private %word_array1% _%word_array2%;{enter}public %word_array1% %word_array2%{enter}{{}{enter}get {{} return _%word_array2%; {}}{enter}set{enter}{{}{enter}_%word_array2% = value;{enter}RaisePropertyChanged(() => %word_array2%);{enter}{}}{enter}{}}{enter}{f2 up}
  Clipboard = %oldClip%
return

f7 & 1::
	Run calc.exe
	WinWait, Calculator, , 3
	if ErrorLevel
	{
		MsgBox, WinWait for Calculator Timed Out.
		return
	}
	WinActivate
return

f10 & 1:: Run notepad++.exe

!1::WPA_MoveMouseToMonitor(4)
!2::WPA_MoveMouseToMonitor(1)
!3::WPA_MoveMouseToMonitor(2)
!4::WPA_MoveMouseToMonitor(3)


^Numpad2:: MoveWindow( 0,  1, 0, 0, 1)
^Numpad4:: MoveWindow(-1,  0, 0, 0, 1)
^Numpad6:: MoveWindow( 1,  0, 0, 0, 1)
^Numpad8:: MoveWindow( 0, -1, 0, 0, 1)

!^Numpad2:: MoveWindow(0, 0,  0,  1, 1)
!^Numpad6:: MoveWindow(0, 0,  1,  0, 1)
!^Numpad8:: MoveWindow(0, 0,  0, -1, 1)
!^Numpad4:: MoveWindow(0, 0, -1,  0, 1)

^NumpadDown:: MoveWindow( 0,  1, 0, 0, 0)
^NumpadLeft:: MoveWindow(-1,  0, 0, 0, 0)
^NumpadRight:: MoveWindow( 1,  0, 0, 0, 0)
^NumpadUp:: MoveWindow( 0, -1, 0, 0, 0)

!^NumpadDown:: MoveWindow(0, 0,  0,  1, 0)
!^NumpadRight:: MoveWindow(0, 0,  1,  0, 0)
!^NumpadUp:: MoveWindow(0, 0,  0, -1, 0)
!^NumpadLeft:: MoveWindow(0, 0, -1,  0, 0)

MoveWindow(xpos, ypos, width, height, amount)
{
toMove := amount ? 30 : 7

xpos *= toMove
ypos *= toMove
width *= toMove
height *= toMove
WinGetPos,X,Y,W,H,A
WinMove, A,, X+xpos, Y+ypos, W+width, H+height

}

^!e:: send eval(fs.readFileSync(''){+}''){left}{left}{left}{left}{left}{left}

^!Right:: send #{Right}
^!Left:: send #{Left}

; Move window up
^!Up::
  WinGetPos,X,Y,W,H,A
  monCen := X+W/2
  SysGet, mc, MonitorCount
  Loop, %mc% {
    SysGet, moncoords, MonitorWorkArea, %A_Index%
    if(moncoordsLeft <=monCen  and moncoordsRight > monCen ) { ;we're looking at the right mon
        newx := moncoordsLeft
        newy := moncoordsTop
        neww := moncoordsRight-moncoordsLeft
        newh := (moncoordsBottom-moncoordsTop)/2
        if(moncoordsBottom-moncoordsTop!=h)
          WinMove,A,,newx, newy, neww, moncoordsBottom-moncoordsTop
        else
          WinMove,A,,newx, newy, neww, newh
    }
  }
return

; Move window down
^!Down::
  WinGetPos,X,Y,W,H,A
  monCen := X+W/2
  SysGet, mc, MonitorCount
  Loop, %mc% {
    SysGet, moncoords, MonitorWorkArea, %A_Index%
    if(moncoordsLeft <=monCen  and moncoordsRight > monCen ) { ;we're looking at the right mon
  WinMove,A,,moncoordsLeft,moncoordsTop + (moncoordsBottom-moncoordsTop)/2,moncoordsRight-moncoordsLeft, (moncoordsBottom-moncoordsTop)/2
    }
  }
return

WPA_MoveMouseToMonitor(md)
{
    SysGet, mc, MonitorCount
    if (md<1 or md>mc)
        return
    
    Loop, %mc%
        SysGet, mon%A_Index%, MonitorWorkArea, %A_Index%
    
    ; Destination monitor
    mdx := mon%md%Left
    mdy := mon%md%Top
    mdw := mon%md%Right - mdx
    mdh := mon%md%Bottom - mdy
    
    mdxc := mdx+mdw/2, mdyc := mdy+mdh/2
    
    CoordMode, Mouse, Screen
    MouseMove, mdxc, mdyc, 0
}



