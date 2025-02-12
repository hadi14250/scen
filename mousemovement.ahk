#Requires AutoHotkey v2.0

if A_Args.Length < 2 {
    MsgBox("Usage: MouseMover.exe targetX targetY")
    ExitApp()
}

targetX := A_Args[1]
targetY := A_Args[2]

; Move the mouse instantly to the specified coordinates.
MouseMove(targetX, targetY, 0)
ExitApp()
