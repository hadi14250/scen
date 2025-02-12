#Requires AutoHotkey v2.0

; --- Parameter Handling ---
; If fewer than 3 parameters are provided, use default values.
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
; In v2, SysGet("MonitorLeft") returns an array of the Left coordinates for all monitors.
lefts := SysGet("MonitorLeft")
tops  := SysGet("MonitorTop")

; Verify that the specified monitor number exists.
if monitorNo > lefts.Length() {
    ExitApp("Monitor number " monitorNo " not found.")
}

monLeft := lefts[monitorNo]
monTop  := tops[monitorNo]

; Calculate the absolute target coordinates.
targetX := monLeft + offsetX
targetY := monTop + offsetY

; --- Move the Mouse ---
CoordMode("Mouse", "Screen")
MouseMove(targetX, targetY, 0)

ExitApp()
