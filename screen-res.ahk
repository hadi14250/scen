#SingleInstance force
SetTitleMatchMode, 2

; === LMFD window settings (to be positioned on the desired monitor) ===
LMFD_Monitor := 3        ; Monitor number (e.g., 3)
LMFD_x_offset := 50      ; X offset from the monitor's left edge
LMFD_y_offset := 50      ; Y offset from the monitor's top edge
LMFD_width    := 800     ; Desired width in pixels
LMFD_height   := 600     ; Desired height in pixels

; === RMFD window settings (to be positioned on the desired monitor) ===
RMFD_Monitor := 2        ; Monitor number (e.g., 2)
RMFD_x_offset := 100     ; X offset from the monitor's left edge
RMFD_y_offset := 100     ; Y offset from the monitor's top edge
RMFD_width    := 1024    ; Desired width in pixels
RMFD_height   := 768     ; Desired height in pixels

; --- Move and resize LMFD ---
winTitleLMFD := "LMFD"
if WinExist(winTitleLMFD)
{
    SysGet, LMFD_mon, Monitor, %LMFD_Monitor%
    newX := LMFD_monLeft + LMFD_x_offset
    newY := LMFD_monTop + LMFD_y_offset
    WinMove, %winTitleLMFD%,, %newX%, %newY%, %LMFD_width%, %LMFD_height%
}
else
{
    MsgBox, Window "LMFD" not found.
}

Sleep, 2000

; --- Move and resize RMFD ---
winTitleRMFD := "RMFD"
if WinExist(winTitleRMFD)
{
    SysGet, RMFD_mon, Monitor, %RMFD_Monitor%
    newX := RMFD_monLeft + RMFD_x_offset
    newY := RMFD_monTop + RMFD_y_offset
    WinMove, %winTitleRMFD%,, %newX%, %newY%, %RMFD_width%, %RMFD_height%
}
else
{
    MsgBox, Window "RMFD" not found.
}
