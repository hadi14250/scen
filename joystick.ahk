#Requires AutoHotkey v2.0

; Set the mouse coordinate mode to screen (so coordinates are absolute).
CoordMode("Mouse", "Screen")

F1:: {
    ; For example, assume the primary monitor's top-left is at (0,0)
    ; and you want to move the mouse to (500, 500).
    ; (You can change these values as needed.)
    monLeft := 0  ; Top-left X of monitor 1 (usually 0)
    monTop  := 0  ; Top-left Y of monitor 1 (usually 0)
    offsetX := 500
    offsetY := 500
    targetX := monLeft + offsetX
    targetY := monTop + offsetY

    ; Move the mouse instantly to the target coordinates.
    MouseMove(targetX, targetY, 0)
    
    ; Display a message box showing the target coordinates.
    MsgBox("Mouse moved to: " targetX ", " targetY)
}
