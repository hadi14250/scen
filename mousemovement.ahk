#Requires AutoHotkey v2.0
; This v2 script expects two command-line parameters: targetX and targetY.
if ParamCount() < 2 {
    MsgBox("Usage: MouseMover.exe targetX targetY")
    ExitApp()
}
targetX := Param(1)
targetY := Param(2)
; Set coordinate mode to screen (default in v2 is screen)
MouseMove(targetX, targetY, 0)
ExitApp()
