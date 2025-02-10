; ---------------------------------------------------
; AHK v1 Script: Move the window "LMFD" to Monitor 3 (Centered)
; ---------------------------------------------------
#SingleInstance force
SetTitleMatchMode, 2  ; Allows partial matching of window titles

winTitle := "LMFD"

; Check if a window with "LMFD" in its title exists.
if WinExist(winTitle)
{
    ; Get the window's current position and size.
    ; The variables winX, winY, winW, and winH will contain the window's coordinates and dimensions.
    WinGetPos, winX, winY, winW, winH, %winTitle%
    
    ; Retrieve monitor 3's coordinates.
    ; This command sets the following variables:
    ;   mon3Left, mon3Top, mon3Right, mon3Bottom
    SysGet, mon3, Monitor, 3
    
    ; Calculate the width and height of monitor 3.
    monWidth  := mon3Right - mon3Left
    monHeight := mon3Bottom - mon3Top
    
    ; Calculate new X and Y to center the window on monitor 3.
    newX := mon3Left + ((monWidth - winW) // 2)
    newY := mon3Top  + ((monHeight - winH) // 2)
    
    ; Move the window to the new coordinates.
    WinMove, %winTitle%,, %newX%, %newY%
    
    ; --- Alternative: Snap the window's top-left corner to monitor 3 ---
    ; Uncomment the next line and comment out the above WinMove line if preferred.
    ; WinMove, %winTitle%,, %mon3Left%, %mon3Top%
}
else
{
    MsgBox, Window "LMFD" not found.
}
