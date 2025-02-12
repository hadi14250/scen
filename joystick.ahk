#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; Display the working directory on startup
MsgBox, The script is running.`nWorking Directory: %A_ScriptDir%

; Define the log file path using the working directory
logFile := A_ScriptDir "\MFD_log.txt"

;------------------------------------------------
; Function: LogButtonPress
; Purpose: Writes a log entry and displays a message box
;------------------------------------------------
LogButtonPress(mfd, btn) {
    global logFile
    FormatTime, timeStamp,, yyyy-MM-dd HH:mm:ss
    msg := timeStamp " - " mfd " MFD: Button " btn " pressed`n"
    
    ; Write to the log file
    FileAppend, %msg%, %logFile%
    
    ; Check if there was an error writing to the file
    if (ErrorLevel)
    {
        MsgBox, 16, Error, There was an error writing to the log file.
    }
    else
    {
        ; Display a message box showing what was logged (for debugging)
        MsgBox, %msg%
    }
    return
}

;------------------------------------------------
; Test Hotkeys: F1 and F2 (Keyboard)
; These let you confirm that logging works even without a joystick.
;------------------------------------------------
F1::LogButtonPress("Test", "F1")
F2::LogButtonPress("Test", "F2")

;------------------------------------------------
; Left MFD (Assumed Joystick 1) Hotkeys
; Adjust these if your MFD is recognized under a different joystick number.
;------------------------------------------------
1Joy1::LogButtonPress("Left", 1)
1Joy2::LogButtonPress("Left", 2)
1Joy3::LogButtonPress("Left", 3)
1Joy4::LogButtonPress("Left", 4)
1Joy5::LogButtonPress("Left", 5)

;------------------------------------------------
; Right MFD (Assumed Joystick 2) Hotkeys
;------------------------------------------------
2Joy1::LogButtonPress("Right", 1)
2Joy2::LogButtonPress("Right", 2)
2Joy3::LogButtonPress("Right", 3)
2Joy4::LogButtonPress("Right", 4)
2Joy5::LogButtonPress("Right", 5)

return
