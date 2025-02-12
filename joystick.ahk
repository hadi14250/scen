#NoEnv
SendMode Input
CoordMode, Mouse, Screen

F1::
    ; Get monitor 1's top-left coordinates.
    SysGet, monLeft, Monitor, 1, Left
    SysGet, monTop, Monitor, 1, Top
    ; Define target coordinates relative to monitor 1.
    targetX := monLeft + 500
    targetY := monTop + 500
    MouseMove, %targetX%, %targetY%, 0
    MsgBox, Moved mouse to: %targetX%, %targetY%
return
