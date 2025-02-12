#Requires AutoHotkey v2.0

; If two parameters are provided, use them; otherwise, use default values.
if A_Args.Length >= 2 {
    targetX := A_Args[1]
    targetY := A_Args[2]
} else {
    targetX := 500  ; Default X coordinate
    targetY := 500  ; Default Y coordinate
    MsgBox("No parameters provided, using default coordinates: " targetX ", " targetY)
}

; Set the mouse coordinate mode to screen (this is the default in v2, but we set it explicitly)
CoordMode("Mouse", "Screen")

; Move the mouse instantly to the specified coordinates.
MouseMove(targetX, targetY, 0)

MsgBox("Mouse moved to: " targetX ", " targetY)

ExitApp()
