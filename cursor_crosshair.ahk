#SingleInstance force

CoordMode, Mouse, Screen

Gui, 1: +E0x20 -Caption +LastFound +Toolwindow +E0x8000000 +AlwaysOnTop ;WS_EX_NOACTIVATE
Gui, 1:Color, FF0000
WinSet, TransColor, FF0000
GuiHwnd := WinExist()
SetTimer, DrawLine, 40
return

DrawLine:
MouseGetPos, M_x, M_y
WinSet, Redraw,, ahk_id %GuiHwnd%
width := 800
height := width
winLeft := M_x-width/2
winTop := M_y-height/2
Gui, 1:Show, x%winLeft% y%winTop% w%width% h%height% NA
Canvas_DrawLine(GuihWnd, width/2, 0, width/2, height, 3, "F00")
Canvas_DrawLine(GuihWnd, 0, height/2, width, height/2, 3, "F00")
return


Canvas_DrawLine(hWnd, p_x1, p_y1, p_x2, p_y2, p_w, p_color) ; r,angle,width,color)
{
   p_x1 -= 1, p_y1 -= 1, p_x2 -= 1, p_y2 -= 1
   hDC := DllCall("GetDC", UInt, hWnd)
   hCurrPen := DllCall("CreatePen", UInt, 0, UInt, p_w, UInt, Convert_BGR(p_color))
   DllCall("SelectObject", UInt,hdc, UInt,hCurrPen)
   DllCall("gdi32.dll\MoveToEx", UInt, hdc, Uint,p_x1, Uint, p_y1, Uint, 0 )
   DllCall("gdi32.dll\LineTo", UInt, hdc, Uint, p_x2, Uint, p_y2 )
   DllCall("ReleaseDC", UInt, 0, UInt, hDC)  ; Clean-up.
   DllCall("DeleteObject", UInt,hCurrPen)
}

   
Convert_BGR(RGB)
{
   StringLeft, r, RGB, 2
   StringMid, g, RGB, 3, 2
   StringRight, b, RGB, 2
   Return, "0x" . b . g . r
}
