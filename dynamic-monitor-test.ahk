#SingleInstance force
SetTitleMatchMode, 2


SysGet, monitorCount, MonitorCount
SysGet, mon1, Monitor, 1
primaryBottom := mon1Bottom

belowLeftMonitor := 0
belowRightMonitor := 0
minLeft := 999999
maxLeft := -999999

Loop, %monitorCount%
{
    if (A_Index = 1)
        continue
    SysGet, mon, Monitor, %A_Index%
    if (mon.Top >= primaryBottom)
    {
        if (mon.Left < minLeft)
        {
            minLeft := mon.Left
            belowLeftMonitor := A_Index
        }
        if (mon.Left > maxLeft)
        {
            maxLeft := mon.Left
            belowRightMonitor := A_Index
        }
    }
}

if (belowLeftMonitor = 0)
    belowLeftMonitor := 2
if (belowRightMonitor = 0)
    belowRightMonitor := 3

; --- LMFD window settings (for the below–left monitor) ---
LMFD_Monitor := belowLeftMonitor        ; Dynamically detected monitor number for below left
LMFD_x_offset := 30                      ; X offset from that monitor's left edge
LMFD_y_offset := 265                     ; Y offset from that monitor's top edge
LMFD_width    := 1100                    ; Desired window width in pixels
LMFD_height   := 1100                    ; Desired window height in pixels

; --- RMFD window settings (for the below–right monitor) ---
RMFD_Monitor := belowRightMonitor        ; Dynamically detected monitor number for below right
RMFD_x_offset := 30                      ; X offset from that monitor's left edge
RMFD_y_offset := 265                     ; Y offset from that monitor's top edge
RMFD_width    := 1100                    ; Desired window width in pixels
RMFD_height   := 1100                    ; Desired window height in pixels

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
