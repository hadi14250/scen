#Requires AutoHotkey v2.0

; Define the window title (adjust if necessary).
winTitle := "LMFD"

if WinExist(winTitle)
{
    ; Retrieve monitor 3's coordinates.
    ; This returns an object with properties: Left, Top, Right, Bottom.
    mon3 := SysGet("Monitor3")
    
    ; Get the current window's position and size.
    pos := WinGetPos(winTitle)  ; pos contains .X, .Y, .Width, and .Height
    
    ; Calculate new coordinates to center the window on monitor 3.
    newX := mon3.Left + ((mon3.Right - mon3.Left - pos.Width) // 2)
    newY := mon3.Top  + ((mon3.Bottom - mon3.Top - pos.Height) // 2)
    
    ; Move the window to the new coordinates.
    WinMove(winTitle, newX, newY)
}
else
{
    MsgBox("Window 'LMFD' not found.")
}
