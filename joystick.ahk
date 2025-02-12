#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; Define the log file path (it will be created in the same folder as the script)
logFile := "MFD_log.txt"

;-----------------------------------------------
; Function: LogButtonPress
; Purpose: Logs the button press with a timestamp
;-----------------------------------------------
LogButtonPress(mfd, btn) {
    FormatTime, timeStamp,, yyyy-MM-dd HH:mm:ss
    msg := timeStamp " - " mfd " MFD: Button " btn " pressed`n"
    FileAppend, %msg%, %logFile%
    ; Also output to the debug console (you can see this with a debugger if needed)
    OutputDebug, %msg%
}

;-----------------------------------------------
; Test Hotkeys (Keyboard) - for verifying logging works
;-----------------------------------------------
F1::LogButtonPress("Test", "F1")
F2::LogButtonPress("Test", "F2")

;-----------------------------------------------
; Left MFD (Joystick 1) Hotkeys
;-----------------------------------------------
1Joy1::LogButtonPress("Left", 1)
1Joy2::LogButtonPress("Left", 2)
1Joy3::LogButtonPress("Left", 3)
1Joy4::LogButtonPress("Left", 4)
1Joy5::LogButtonPress("Left", 5)
; (Add additional left MFD buttons if needed, e.g., 1Joy6, etc.)

;-----------------------------------------------
; Right MFD (Joystick 2) Hotkeys
;-----------------------------------------------
2Joy1::LogButtonPress("Right", 1)
2Joy2::LogButtonPress("Right", 2)
2Joy3::LogButtonPress("Right", 3)
2Joy4::LogButtonPress("Right", 4)
2Joy5::LogButtonPress("Right", 5)
; (Add additional right MFD buttons if needed, e.g., 2Joy6, etc.)

return
