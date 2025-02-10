#Requires AutoHotkey v2.0

; --- Move the "left" window ---
WinActivate("Left Window Title")
WinWaitActive("Left Window Title")
WinMove("Left Window Title",, 0, 1080, 768, 1024)

; --- Move the "right" window ---
WinActivate("Right Window Title")
WinWaitActive("Right Window Title")
WinMove("Right Window Title",, 768, 1080, 768, 1024)
