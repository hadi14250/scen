#Requires AutoHotkey v2.0

; Use command-line parameters if provided; otherwise, use default coordinates.
if A_Args.Length >= 2 {
    targetX := A_Args[1]
    targetY := A_Args[2]
} else {
    targetX := 500  ; Default X coordinate
    targetY := 500  ; Default Y coordinate
}

; Ensure that the mouse coordinates are interpreted as screen coordinates.
CoordMode("Mouse", "Screen")

; Move the mouse instantly to the specified coordinates.
MouseMove(targetX, targetY, 0)

ExitApp()
