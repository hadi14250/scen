#SingleInstance force
SetTitleMatchMode, 2
targetWindow := "YourWindowTitle"  ; Replace with the specific window's title
if WinExist(targetWindow)
{
    WinActivate, %targetWindow%
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
