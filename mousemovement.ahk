#Requires AutoHotkey v2.0

; --- Parameter Handling ---
; If fewer than 3 parameters are provided, use defaults.
if A_Args.Length < 3 {
    offsetX   := 500    ; Default horizontal offset
    offsetY   := 500    ; Default vertical offset
    monitorNo := 1      ; Default monitor number
} else {
    ; Force numeric conversion by adding 0
    offsetX   := A_Args[1] + 0
    offsetY   := A_Args[2] + 0
    monitorNo := A_Args[3] + 0
}

; --- Retrieve Monitor Information ---
; SysGet("Monitor") returns an object (array) of monitors.
monitors := SysGet("Monitor")
if !monitors.HasKey(monitorNo) {
    ; If the specified monitor doesn't exist, exit.
    ExitApp()
}
mon := monitors[monitorNo]
targetX := mon.Left + offsetX
targetY := mon.Top + offsetY

; --- Move the Mouse ---
; Set the mouse coordinate mode to "Screen"
CoordMode("Mouse", "Screen")
MouseMove(targetX, targetY, 0)

ExitApp()
