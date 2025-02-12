#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; Set the name of the log file (it will be created in the same directory as the script)
logFile := "MFD_log.txt"

; This function logs the press with a timestamp
LogButtonPress(mfd, btn) {
    FormatTime, timeStamp,, yyyy-MM-dd HH:mm:ss
    msg := timeStamp " - " mfd " MFD: Button " btn " pressed`n"
    FileAppend, %msg%, %logFile%
    ; Also output to the debug console (if you're monitoring via a debugger)
    OutputDebug, %msg%
}

; If you want the hotkeys to work regardless of which window is active, comment out the following line:
; #IfWinActive, ahk_exe Prepar3D.exe

; -----------------------------
; Left MFD (Joystick 1) Hotkeys
; -----------------------------
1Joy1::LogButtonPress("Left", 1)
1Joy2::LogButtonPress("Left", 2)
1Joy3::LogButtonPress("Left", 3)
1Joy4::LogButtonPress("Left", 4)
1Joy5::LogButtonPress("Left", 5)
; Add more hotkeys if needed (e.g., 1Joy6, 1Joy7, etc.)

; -----------------------------
; Right MFD (Joystick 2) Hotkeys
; -----------------------------
2Joy1::LogButtonPress("Right", 1)
2Joy2::LogButtonPress("Right", 2)
2Joy3::LogButtonPress("Right", 3)
2Joy4::LogButtonPress("Right", 4)
2Joy5::LogButtonPress("Right", 5)
; Add more hotkeys if needed (e.g., 2Joy6, 2Joy7, etc.)

#IfWinActive  ; End context-sensitive hotkeys (if you used it earlier)

return
