#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

logFile := A_ScriptDir "\joystick.log"

; Clear any existing log file on startup (optional)
FileDelete, %logFile%

; Make the script persistent so it keeps polling
#Persistent

; Polling interval (in milliseconds)
pollInterval := 100

SetTimer, CheckJoysticks, %pollInterval%
return

CheckJoysticks:
{
    ; Check Joystick 1 buttons (assuming Left MFD is Joystick 1)
    Loop, 32
    {
        hotkey := "1Joy" A_Index
        GetKeyState, state, %hotkey%
        if (state = "D")  ; if button is pressed (D = down)
        {
            FormatTime, timeStamp,, yyyy-MM-dd HH:mm:ss
            msg := timeStamp " - Joystick 1: Button " A_Index " pressed`n"
            FileAppend, %msg%, %logFile%
            ; Display a brief tooltip for debugging (optional)
            ToolTip, %msg%
            Sleep, 200  ; debounce delay so you don't log continuously
            ToolTip  ; clear tooltip
        }
    }
    
    ; Check Joystick 2 buttons (assuming Right MFD is Joystick 2)
    Loop, 32
    {
        hotkey := "2Joy" A_Index
        GetKeyState, state, %hotkey%
        if (state = "D")
        {
            FormatTime, timeStamp,, yyyy-MM-dd HH:mm:ss
            msg := timeStamp " - Joystick 2: Button " A_Index " pressed`n"
            FileAppend, %msg%, %logFile%
            ToolTip, %msg%
            Sleep, 200
            ToolTip
        }
    }
}
return
