;---------------------------------------------------
; Revised Joystick Polling Script with Version Check
;---------------------------------------------------

; Check for AutoHotkey version 1.1 or later
if (A_AhkVersion < "1.1")
    {
        MsgBox, 16, Version Error, This script requires AutoHotkey v1.1 or later.`nPlease update AutoHotkey.
        ExitApp
    }
    
    #NoEnv
    #SingleInstance Force
    SendMode Input
    SetWorkingDir %A_ScriptDir%
    
    ; Define the log file path (will be created in the script folder)
    logFile := A_ScriptDir "\joystick.log"
    
    ; (Optional) Delete any existing log file on startup
    FileDelete, %logFile%
    
    ; Global associative arrays to hold previous button states
    global prevState1 := {}  ; For Joystick 1 (Left MFD)
    global prevState2 := {}  ; For Joystick 2 (Right MFD)
    
    ; Number of buttons to poll per joystick (adjust if needed)
    numButtons := 16
    
    ; Start the polling timer (every 100 ms)
    SetTimer, CheckJoysticks, 100
    return
    
    CheckJoysticks:
        ;--- Check Joystick 1 (Left MFD) ---
        Loop, %numButtons%
        {
            index := A_Index
            hotkey := "1Joy" index
            GetKeyState, state, %hotkey%
            
            ; Initialize previous state if not set
            if (!prevState1.HasKey(index))
                prevState1[index] := "U"
            
            ; If state has changed...
            if (state != prevState1[index])
            {
                ; Only log if the state changed to "D" (button pressed)
                if (state = "D")
                {
                    FormatTime, timeStamp,, yyyy-MM-dd HH:mm:ss
                    msg := timeStamp " - Joystick 1: Button " index " pressed`n"
                    FileAppend, %msg%, %logFile%
                    ; Show a brief tooltip for debugging
                    ToolTip, %msg%
                    Sleep, 200
                    ToolTip
                }
                prevState1[index] := state
            }
        }
        
        ;--- Check Joystick 2 (Right MFD) ---
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
    return
    