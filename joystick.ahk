#NoEnv
SendMode Input
CoordMode, Mouse, Screen

F1::
    ; Get monitor 1's top-left coordinates.
    SysGet, monLeft, Monitor, 1, Left
    SysGet, monTop, Monitor, 1, Top

    ; Set your desired offsets.
    offsetX := 500   ; Change this value as needed.
    offsetY := 500   ; Change this value as needed.

    ; Compute the target coordinates.
    targetX := monLeft + offsetX
    targetY := monTop + offsetY

    ; Display the computed values for debugging.
    MsgBox, Monitor 1 Top-Left: (%monLeft%, %monTop%)`nCalculated Target: (%targetX%, %targetY%)
    
    ; Move the mouse to the target coordinates using SetCursorPos.
    DllCall("SetCursorPos", "Int", targetX, "Int", targetY)
return
