#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; Show a startup tooltip so you know the script is running.
ToolTip, Joystick Test Script is Running!
Sleep, 2000
ToolTip

; Define the log file path (it will be created in the same folder as the script)
logFile := A_ScriptDir "\joystick.log"
FileDelete, %logFile%   ; Delete any existing log file

; Set a timer to check the state of one button on each joystick every 1000 ms (1 second)
SetTimer, CheckJoystick, 1000
return

CheckJoystick:
    ; Poll the state of Button 1 on Joystick 1 (Left MFD) and Joystick 2 (Right MFD)
    GetKeyState, state1, 1Joy1
    GetKeyState, state2, 2Joy1
    
    ; Get a timestamp
    FormatTime, t, , yyyy-MM-dd HH:mm:ss
    msg := t " - Joystick 1, Button 1: " state1 " | Joystick 2, Button 1: " state2 "`n"
    
    ; Append the message to the log file
    FileAppend, %msg%, %logFile%
    
    ; Also display the message as a tooltip for 500 ms
    ToolTip, %msg%
    Sleep, 500
    ToolTip
return
