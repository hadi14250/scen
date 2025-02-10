#Requires AutoHotkey v2.0

; Define the window title to search for
winTitle := "LMFD"

; Get the window handle (hWnd) from its title.
if hWnd := WinExist(winTitle)
{
    ; Prepare variables for the window's position and size.
    X := 0, Y := 0, Width := 0, Height := 0
    
    ; Retrieve the current window's position and size.
    ; WinGetPos requires variables passed by reference for output.
    WinGetPos(hWnd, X, Y, Width, Height)
    
    ; Retrieve monitor 3's coordinates.
    ; SysGet expects a number (the monitor index) as its only parameter.
    mon3 := SysGet(3)
    
    ; Calculate new coordinates to center the window on monitor 3.
    newX := mon3.Left + ((mon3.Right - mon3.Left - Width) // 2)
    newY := mon3.Top  + ((mon3.Bottom - mon3.Top - Height) // 2)
    
    ; Move the window to the new coordinates.
    WinMove(hWnd, newX, newY)
}
else
{
    MsgBox("Window 'LMFD' not found.")
}
