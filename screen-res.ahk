#Requires AutoHotkey v2.0

; Define the window title to search for.
winTitle := "LMFD"

; Retrieve the window's handle (hWnd) using its title.
if hWnd := WinExist(winTitle)
{
    ; Retrieve the window's current position and size as an object.
    pos := WinGetPos(hWnd)  ; pos.X, pos.Y, pos.Width, pos.Height

    ; Retrieve monitor 3's coordinates.
    ; In AHK v2, SysGet expects a number (monitor index) as its sole parameter.
    mon3 := SysGet(3)       ; mon3.Left, mon3.Top, mon3.Right, mon3.Bottom

    ; Calculate new coordinates to center the window on monitor 3.
    newX := mon3.Left + ((mon3.Right - mon3.Left - pos.Width) // 2)
    newY := mon3.Top  + ((mon3.Bottom - mon3.Top - pos.Height) // 2)

    ; Move the window to the new coordinates.
    WinMove(hWnd, newX, newY)
}
else
{
    MsgBox "Window 'LMFD' not found."
}
