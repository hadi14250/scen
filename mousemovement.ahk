#Requires AutoHotkey v2.0

; --- Parameter Handling ---
; If at least three parameters are provided, convert them to numbers.
if A_Args.Length < 3 {
    offsetX   := 500    ; Default horizontal offset
    offsetY   := 500    ; Default vertical offset
    monitorNo := 1      ; Default monitor number
} else {
    offsetX   := +A_Args[1]   ; The unary plus converts to a number.
    offsetY   := +A_Args[2]
    monitorNo := +A_Args[3]
}

; --- Get Monitor Information ---
; SysGet("Monitor") returns an object (an array) of monitor info.
monitors := SysGet("Monitor")

; Ensure the specified monitor exists.
if !monitors.HasKey(monitorNo)
    ExitApp()

mon := monitors[monitorNo]
targetX := mon.Left + offsetX
targetY := mon.Top + offsetY

; --- Move the Mouse ---
; Set coordinate mode for the mouse to "Screen"
CoordMode("Mouse", "Screen")
MouseMove(targetX, targetY, 0)

ExitApp()
