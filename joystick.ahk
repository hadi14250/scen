#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; Define the log file path (will be created in the same folder as the script)
logFile := A_ScriptDir "\joystick.log"

; (Optional) Delete any existing log file on startup
FileDelete, %logFile%

; Number of buttons to poll per joystick (adjust if needed)
numButtons := 16

; Initialize arrays for previous state for each joystick.
; We'll use a simple array (index starting at 1) for each.
global prevState1 := []  ; For Joystick 1 (Left MFD)
global prevState2 := []  ; For Joystick 2 (Right MFD)

; Fill the arrays with "U" (for Up) for each button
Loop, %numButtons%
{
    prevState1.Push("U")
    prevState2.Push("U")
}

; Display a startup tooltip to confirm the script is running (for 2 seconds)
ToolTip, Joystick polling started...
SetTimer, RemoveStartupToolTip, -2000

RemoveStartupToolTip:
ToolTip
return

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
        
        ; Compare the current state to the stored state
        if (state != prevState1[index])
        {
            ; Log only on transition from "U" (up) to "D" (down)
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
            ; Update stored state for this button
            prevState1[index] := state
        }
    }
    
    ; --- Check Joystick 2 (Right MFD) ---
    Loop, %numButtons%
    {
        index := A_Index
        hotkey := "2Joy" index
        GetKeyState, state, %hotkey%
        
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
