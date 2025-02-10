#Requires AutoHotkey v2.0
#NoTrayIcon

; ======== EXAMPLE COORDINATES (Likely need adjustment!) ========
; Main (top) monitor:  1920x1080 at (0,0)
; Left (bottom) monitor:  768x1024 at (0,1080)
; Right (bottom) monitor: 768x1024 at (768,1080)
; ===============================================================

; First window -> Move to left bottom monitor
WinActivate("Left Window Title")
WinWaitActive("Left Window Title")
WinMove("Left Window Title", , 0, 1080, 768, 1024)

; Second window -> Move to right bottom monitor
WinActivate("Right Window Title")
WinWaitActive("Right Window Title")
WinMove("Right Window Title", , 768, 1080, 768, 1024)
