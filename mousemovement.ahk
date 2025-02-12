#Requires AutoHotkey v2.0

; Use command-line parameters if provided; otherwise, use default values.
if A_Args.Length < 3 {
    offsetX   := 500    ; Default horizontal offset
    offsetY   := 500    ; Default vertical offset
    monitorNo := 1      ; Default monitor number
} else {
    offsetX   := A_Args[1]
    offsetY   := A_Args[2]
    monitorNo := A_Args[3]
}

; Retrieve the target monitor's top-left coordinates using the proper v2 syntax.
monLeft := SysGet("MonitorLeft", monitorNo)
monTop  := SysGet("MonitorTop", monitorNo)

; Calculate the absolute target coordinates.
targetX := monLeft + offsetX
targetY := monTop + offsetY

; Set the coordinate mode for the mouse to screen.
CoordMode("Mouse", "Screen")

; Move the mouse instantly to the target coordinates.
MouseMove(targetX, targetY, 0)

ExitApp()
