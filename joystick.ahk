#NoEnv
SendMode Input
CoordMode, Mouse, Screen

F1::
    ; Get the primary monitor's top-left coordinates (monitor 1)
    SysGet, monLeft, Monitor, 1, Left
    SysGet, monTop, Monitor, 1, Top
    ; Define target coordinates relative to monitor 1 (change as needed)
    targetX := monLeft + 500
    targetY := monTop + 500
    ; Move the mouse instantly to the target coordinates
    MouseMove, %targetX%, %targetY%, 0
    ; Display a message box showing the coordinates for confirmation
    MsgBox, Moved mouse to: %targetX%, %targetY%
return
