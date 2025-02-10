#SingleInstance force
SetTitleMatchMode, 2

winTitleLMFD := "LMFD"
if WinExist(winTitleLMFD)
{
    WinGetPos, winX, winY, winW, winH, %winTitleLMFD%
    SysGet, mon3, Monitor, 3
    monWidth := mon3Right - mon3Left
    monHeight := mon3Bottom - mon3Top
    newX := mon3Left + ((monWidth - winW) // 2)
    newY := mon3Top + ((monHeight - winH) // 2)
    WinMove, %winTitleLMFD%,, %newX%, %newY%
}
else
{
    MsgBox, Window "LMFD" not found.
}

Sleep, 2000

winTitleRMFD := "RMFD"
if WinExist(winTitleRMFD)
{
    WinGetPos, winX, winY, winW, winH, %winTitleRMFD%
    SysGet, mon2, Monitor, 2
    monWidth := mon2Right - mon2Left
    monHeight := mon2Bottom - mon2Top
    newX := mon2Left + ((monWidth - winW) // 2)
    newY := mon2Top + ((monHeight - winH) // 2)
    WinMove, %winTitleRMFD%,, %newX%, %newY%
}
else
{
    MsgBox, Window "RMFD" not found.
}
