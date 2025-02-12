#Requires AutoHotkey v2.0

; Use command-line parameters if provided; otherwise, use default values.
if A_Args.Length >= 3 {
    offsetX   := A_Args[1]   ; Horizontal offset from monitor's top-left
    offsetY   := A_Args[2]   ; Vertical offset from monitor's top-left
    monitorNo := A_Args[3]   ; Monitor number
} else {
    offsetX   := 500        ; Default horizontal offset
    offsetY   := 500        ; Default vertical offset
    monitorNo := 1          ; Default monitor number
}

; Get the target monitor's top-left coordinates.
monLeft := SysGet("Monitor", monitorNo, "Left")
monTop  := SysGet("Monitor", monitorNo, "Top")

; Calculate the absolute target coordinates.
targetX := monLeft + offsetX
targetY := monTop + offsetY

; Set coordinate mode for the mouse to screen.
CoordMode("Mouse", "Screen")

; Move the mouse instantly to the target coordinates.
MouseMove(targetX, targetY, 0)

ExitApp()
