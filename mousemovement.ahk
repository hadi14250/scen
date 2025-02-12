#Requires AutoHotkey v2.0

; --- Retrieve Monitor Information via EnumDisplayMonitors ---
; We will fill the global array "monitors" with objects for each monitor.
global monitors := []

EnumMonitorCallback(hMonitor, hdcMonitor, lprcMonitor, dwData) {
    ; Allocate a 16-byte buffer for the RECT structure.
    VarSetCapacity(rect, 16, 0)
    ; Copy 16 bytes from lprcMonitor into rect.
    DllCall("RtlMoveMemory", "Ptr", &rect, "Ptr", lprcMonitor, "UPtr", 16)
    left   := NumGet(rect, 0, "Int")
    top    := NumGet(rect, 4, "Int")
    right  := NumGet(rect, 8, "Int")
    bottom := NumGet(rect, 12, "Int")
    ; Store the monitor info as an object.
    monitors.Push({Left: left, Top: top, Right: right, Bottom: bottom})
    return 1  ; Continue enumeration.
}

; Call EnumDisplayMonitors with our callback.
DllCall("EnumDisplayMonitors", "Ptr", 0, "Ptr", 0, "Ptr", RegisterCallback("EnumMonitorCallback", "Fast"), "Ptr", 0)

; --- Parameter Handling ---
; Use command-line parameters if provided; otherwise, use default values.
if A_Args.Length < 3 {
    offsetX   := 500    ; Default horizontal offset.
    offsetY   := 500    ; Default vertical offset.
    monitorNo := 1      ; Default monitor number.
} else {
    ; Force numeric conversion.
    offsetX   := A_Args[1] + 0
    offsetY   := A_Args[2] + 0
    monitorNo := A_Args[3] + 0
}

; Check that the requested monitor exists.
if monitorNo > monitors.Length() {
    ExitApp("Monitor number " monitorNo " not found.")
}

; Retrieve the top-left coordinates of the specified monitor.
mon := monitors[monitorNo]
targetX := mon.Left + offsetX
targetY := mon.Top + offsetY

; --- Move the Mouse ---
; Set coordinate mode for the mouse to "Screen".
CoordMode("Mouse", "Screen")
; Move the mouse instantly.
MouseMove(targetX, targetY, 0)

ExitApp()
