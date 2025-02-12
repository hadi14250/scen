#Requires AutoHotkey v2.0

; --- Parameter Handling ---
; If fewer than 3 parameters are provided, use default values.
if A_Args.Length < 3 {
    offsetX   := 500   ; Default horizontal offset
    offsetY   := 500   ; Default vertical offset
    monitorNo := 1     ; Default monitor number
} else {
    offsetX   := A_Args[1] + 0  ; Force numeric conversion
    offsetY   := A_Args[2] + 0
    monitorNo := A_Args[3] + 0
}

; --- Retrieve Monitor Information ---
; In AHK v2, SysGet("Monitor") returns an array of monitor objects.
monitors := SysGet("Monitor")
; Verify that the specified monitor exists.
if monitorNo > monitors.Length() {
    ExitApp("Monitor number " monitorNo " not found.")
}
mon := monitors[monitorNo]
targetX := mon.Left + offsetX
targetY := mon.Top + offsetY

; --- Move the Mouse ---
CoordMode("Mouse", "Screen")
MouseMove(targetX, targetY, 0)

ExitApp()
