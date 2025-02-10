#Requires AutoHotkey v2.0
#NoTrayIcon

; --- First window ---
; Wait for a window whose title CONTAINS "Left Window Title"
hwndLeft := WinWait("Left Window Title")  ; returns a numeric handle
WinActivate(hwndLeft)
WinWaitActive(hwndLeft)

; Move window to (0,1080), size 768×1024
WinMove(hwndLeft, "", 0, 1080, 768, 1024)


; --- Second window ---
; Wait for a window whose title CONTAINS "Right Window Title"
hwndRight := WinWait("Right Window Title")
WinActivate(hwndRight)
WinWaitActive(hwndRight)

; Move window to (768,1080), size 768×1024
WinMove(hwndRight, "", 768, 1080, 768, 1024)
