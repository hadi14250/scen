#Requires AutoHotkey v2.0  ; Ensures it's interpreted as v2

monitorCount := SysGet("MonitorCount")
i := 1
while (i <= monitorCount)
{
    mon := SysGet("Monitor", i)
    /*
        mon.Left, mon.Top, mon.Right, mon.Bottom  = absolute screen coords
        mon.Width, mon.Height                    = resolution
        mon.Primary = True/False                 = is primary monitor
    */
    MsgBox(
        "Monitor " i "`n"
      . "Left: "   mon.Left   "`n"
      . "Top: "    mon.Top    "`n"
      . "Right: "  mon.Right  "`n"
      . "Bottom: " mon.Bottom "`n"
      . "Width: "  mon.Width  "`n"
      . "Height: " mon.Height "`n"
      . "Primary: " mon.Primary
    )
    i++
}
