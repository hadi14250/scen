#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; Define the log file path (created in the same folder as the script)
logFile := A_ScriptDir "\joystick.log"

; Clear any existing log file on startup (optional)
FileDelete, %logFile%

; Make the script persistent so it keeps polling
#Persistent

; Polling interval (in milliseconds)
pollInterval := 100

; We'll poll 32 buttons per joystick (adjust if your device has fewer buttons)
numButtons := 32

; Initialize previous state arrays for each joystick.
; These arrays will hold the last known state for each button.
global prevState1 := []  ; For Joystick 1 (Left MFD)
global prevState2 := []  ; For Joystick 2 (Right MFD)

; Initialize all button states to "U" (up) initially
Loop, %numButtons%
{
    prevState1[A_Index] := "U"
    prevState2[A_Index] := "U"
}

; Set the timer to call CheckJoysticks every pollInterval milliseconds
SetTimer, CheckJoysticks, %pollInterval%
return

CheckJoysticks:
{
    ; Check Joystick 1 buttons (assuming Left MFD is Joystick 1)
    Loop, %numButtons%
    {
        hotkey := "1Joy" A_Index
        GetKeyState, state, %hotkey%
        
        ; Log only if the button state changed from Up to Down
        if (state = "D" and prevState1[A_Index] = "U")
        {
            FormatTime, timeStamp,, yyyy-MM-dd HH:mm:ss
            msg := timeStamp " - Joystick 1: Button " A_Index " pressed`n"
            FileAppend, %msg%, %logFile%
            ToolTip, %msg%
            ; (Optional) A brief pause to help visually see the tooltip
            Sleep, 200
            ToolTip
        }
        ; Update the previous state for this button
        prevState1[A_Index] := state
    }
    
    ; Check Joystick 2 buttons (assuming Right MFD is Joystick 2)
    Loop, %numButtons%
    {
        hotkey := "2Joy" A_Index
        GetKeyState, state, %hotkey%
        
        if (state = "D" and prevState2[A_Index] = "U")
        {
            FormatTime, timeStamp,, yyyy-MM-dd HH:mm:ss
            msg := timeStamp " - Joystick 2: Button " A_Index " pressed`n"
            FileAppend, %msg%, %logFile%
            ToolTip, %msg%
            Sleep, 200
            ToolTip
        }
        prevState2[A_Index] := state
    }
}
return
