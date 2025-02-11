#SingleInstance force
SetTitleMatchMode, 2

; === LMFD window settings
LMFD_Monitor := 3        ; Monitor number
LMFD_x_offset := 30      ; X offset from the monitor's left edge
LMFD_y_offset := 265      ; Y offset from the monitor's top edge
LMFD_width    := 1100     ; Window width in pixels
LMFD_height   := 1100     ; Window height in pixels

; === RMFD window settings
RMFD_Monitor := 2        ; Monitor number
RMFD_x_offset := 30     ; X offset from the monitor's left edge
RMFD_y_offset := 265     ; Y offset from the monitor's top edge
RMFD_width    := 1100    ; Window width in pixels
RMFD_height   := 1100     ; Window height in pixels

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
