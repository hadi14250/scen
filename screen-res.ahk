#Requires AutoHotkey v2.0
MsgBox("Running version: " A_AhkVersion)

; We're not even dealing with real windows here.
; We just call WinMove with test values in the correct v2 order:
WinMove("Untitled - Notepad", , 100, 100, 500, 300)
