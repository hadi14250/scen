#Requires AutoHotkey v2.0

; 1) Wait for a window that contains "My Window Title" in its title.
;    WinWait returns a numeric HWND (no strings involved for WinMove).
hwnd := WinWait("My Window Title")

; 2) Activate & wait for it to become active:
WinActivate(hwnd)
WinWaitActive(hwnd)

; 3) Move the window to numeric coordinates (X=0, Y=1080) with size 768×1024.
;    Notice the second parameter is blank (nothing between the commas).
;    That blank is for "WinText" (also a string), which we don't need.
WinMove(hwnd, , 0, 1080, 768, 1024)
