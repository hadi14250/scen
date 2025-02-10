#Requires AutoHotkey v2.0

; Define the window title (adjust if necessary)
winTitle := "LMFD"

if WinExist(winTitle)
{
    ; Retrieve monitor 3's coordinates.
    ; SysGet expects a number when retrieving a monitor's info.
    mon3 := SysGet(3)
    
    ; Get the current window's position and size.
    ; WinGetPos returns an object with properties: X, Y, Width, and Height.
    pos := WinGetPos(winTitle)
    
    ; Calculate new coordinates to center the window on monitor 3.
    newX := mon3.Left + ((mon3.Right - mon3.Left - pos.Width) // 2)
    newY := mon3.Top  + ((mon3.Bottom - mon3.Top - pos.Height) // 2)
    
    ; Move the window to the new coordinates.
    WinMove(winTitle, newX, newY)
    
    ; --- Alternative ---
    ; To simply snap the window's top-left corner to monitor 3's top-left, use:
    ; WinMove(winTitle, mon3.Left, mon3.Top)
}
else
{
    MsgBox "Window 'LMFD' not found."
}
