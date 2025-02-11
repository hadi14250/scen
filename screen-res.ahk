#SingleInstance force
SetTitleMatchMode, 2
targetWindow := "YourWindowTitle"  ; Replace with the actual (or partial) window title

if WinExist(targetWindow)
{
    hWnd := WinExist(targetWindow)
    WinActivate, ahk_id %hWnd%
    WinWaitActive, ahk_id %hWnd%,, 5
    Sleep, 3000
    Send, {Alt down}
    Sleep, 50
    Send, {Alt up}
    Sleep, 50
    Send, e
    Sleep, 50
    Send, i
    Sleep, 50
    Send, {Down}
    Sleep, 50
    Send, {Down}
    Sleep, 50
    Send, {Down}
    Sleep, 50
    Send, {Enter}
}
else
{
    MsgBox, Window "%targetWindow%" is not open.
}
