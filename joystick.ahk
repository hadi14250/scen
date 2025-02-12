#NoEnv
SendMode Input
CoordMode, Mouse, Screen

F1::
    ; Get the primary monitor's top-left coordinates (monitor 1)
    SysGet, monLeft, Monitor, 1, Left
    SysGet, monTop, Monitor, 1, Top
    ; Define target coordinates relative to monitor 1.
    targetX := monLeft + 500
    targetY := monTop + 500
    ; Use the Windows API call SetCursorPos to move the mouse.
    DllCall("SetCursorPos", "Int", targetX, "Int", targetY)
    MsgBox, Moved mouse to: %targetX%, %targetY%
return
