#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; Define the log file path (created in the same folder as the script)
logFile := A_ScriptDir "\joystick.log"

; (Optional) Clear any existing log file on startup
FileDelete, %logFile%

; Global associative arrays to hold previous button states for each joystick
global prevState1 := {}  ; For Joystick 1 (Left MFD)
global prevState2 := {}  ; For Joystick 2 (Right MFD)

; How many buttons to poll per joystick
numButtons := 16

; Start the polling timer (every 100 ms)
SetTimer, CheckJoysticks, 100
return

CheckJoysticks:
{
    ; --- Check Joystick 1 (Left MFD) ---
    Loop, %numButtons%
    {
        index := A_Index
        hotkey := "1Joy" index
        GetKeyState, state, %hotkey%
        
        ; Initialize previous state if not set
        if (!prevState1.HasKey(index))
            prevState1[index] := "U"
        
        ; If the state has changed...
        if (state != prevState1[index])
        {
            ; Only log on transition from "U" (up) to "D" (down)
            if (state = "D")
            {
                FormatTime, timeStamp,, yyyy-MM-dd HH:mm:ss
                msg := timeStamp " - Joystick 1: Button " index " pressed`n"
                FileAppend, %msg%, %logFile%
                ; (Optional) Show a brief tooltip for debugging
                ToolTip, %msg%
                Sleep, 200
                ToolTip
            }
            ; Update the previous state
            prevState1[index] := state
        }
    }
    
    ; --- Check Joystick 2 (Right MFD) ---
    Loop, %numButtons%
    {
        index := A_Index
        hotkey := "2Joy" index
        GetKeyState, state, %hotkey%
        
        if (!prevState2.HasKey(index))
            prevState2[index] := "U"
            
        if (state != prevState2[index])
        {
            if (state = "D")
            {
                FormatTime, timeStamp,, yyyy-MM-dd HH:mm:ss
                msg := timeStamp " - Joystick 2: Button " index " pressed`n"
                FileAppend, %msg%, %logFile%
                ToolTip, %msg%
                Sleep, 200
                ToolTip
            }
            prevState2[index] := state
        }
    }
}
return
