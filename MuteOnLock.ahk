#UseHook ON
#SingleInstance force

SetTimer, Mute, 100
MouseGetPos, OMx, OMy

muted:=0
LockTimeOut:=0
unMuteOnMouse:=0
doUnMute:=0

Mute:
	LockTimeOut++
	if(LockTimeOut = -1)
		unMuteOnMouse:=1
	if(LockTimeOut > 0){
		LockTimeOut := 0
	}
	MouseGetPos, Mx, My
	if((Mx!=OMx || My!=OMy) && unMuteOnMouse=1) {
		SoundGet, curr_mute, , mute
		if(curr_mute = "On" && doUnMute=1)
			Send {Volume_Mute}
	}
	OMx:=Mx
	Omy:=My
return

#l::
	DllCall("LockWorkStation")
	SoundGet, curr_mute, , mute
	if(curr_mute="Off") {
		doUnMute:=1
		Send {Volume_Mute}
	}
	LockTimeOut:= -10
return
