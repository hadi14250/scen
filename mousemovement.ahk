#Requires AutoHotkey v2.0

; --- Global Array to Hold Monitor Info ---
global monitors := []

; --- Callback Function for EnumDisplayMonitors ---
EnumMonitorCallback(hMonitor, hdcMonitor, lprcMonitor, dwData) {
    ; Create a 16-byte buffer and initialize it to zero.
    buf := Buffer(16, 0)
    ; Copy 16 bytes from the monitor's RECT (pointed to by lprcMonitor) into our buffer.
    DllCall("RtlMoveMemory", "Ptr", buf.Ptr, "Ptr", lprcMonitor, "UPtr", 16)
    left   := NumGet(buf, 0, "Int")
    top    := NumGet(buf, 4, "Int")
    right  := NumGet(buf, 8, "Int")
    bottom := NumGet(buf, 12, "Int")
    ; Push an object with the monitor's rectangle into the global array.
    monitors.Push({Left: left, Top: top, Right: right, Bottom: bottom})
    return 1  ; Continue enumeration.
}

; --- Enumerate All Monitors ---
DllCall("EnumDisplayMonitors", "Ptr", 0, "Ptr", 0, "Ptr", RegisterCallback("EnumMonitorCallback", "Fast"), "Ptr", 0)

; --- Parameter Handling ---
if A_Args.Length < 3 {
    offsetX   := 500   ; Default horizontal offset
    offsetY   := 500   ; Default vertical offset
    monitorNo := 1     ; Default monitor number
} else {
    offsetX   := A_Args[1] + 0  ; Force numeric conversion
    offsetY   := A_Args[2] + 0
    monitorNo := A_Args[3] + 0
}

; Verify that the specified monitor exists.
if monitorNo > monitors.Length() {
    ExitApp("Monitor number " monitorNo " not found.")
}

mon := monitors[monitorNo]
targetX := mon.Left + offsetX
targetY := mon.Top + offsetY

; --- Move the Mouse ---
; Set the mouse coordinate mode to "Screen" and move instantly.
CoordMode("Mouse", "Screen")
MouseMove(targetX, targetY, 0)

ExitApp()
