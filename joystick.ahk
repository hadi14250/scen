#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; --- Set the joystick numbers for your Cougar MFDs ---
; Change these values to match what Windows reports in joy.cpl for your Cougar MFDs.
global Cougar_Left := 7    ; For example, left Cougar MFD is registered as Joystick 7
global Cougar_Right := 4   ; For example, right Cougar MFD is registered as Joystick 4

; --- Log file setup ---
logFile := A_ScriptDir "\joystick.log"
FileDelete, %logFile%

#Persistent
pollInterval := 100         ; Polling interval (milliseconds)
numButtons := 32            ; Number of buttons to poll per joystick

; Initialize previous state arrays for each Cougar MFD.
global prevStateLeft := []   ; For Left Cougar MFD
global prevStateRight := []  ; For Right Cougar MFD

; Set initial state ("U" for Up) for each button.
Loop, %numButtons%
{
    prevStateLeft[A_Index] := "U"
    prevStateRight[A_Index] := "U"
}

; Set a timer to poll the Cougar MFDs every pollInterval milliseconds.
SetTimer, CheckCougarMFD, %pollInterval%
return

CheckCougarMFD:
{
    ; --- Check buttons for Left Cougar MFD ---
    Loop, %numButtons%
    {
        hotkey := Cougar_Left "Joy" A_Index
        GetKeyState, state, %hotkey%
        
        ; Log only if the button changes from Up to Down.
        if (state = "D" and prevStateLeft[A_Index] = "U")
        {
            FormatTime, timeStamp,, yyyy-MM-dd HH:mm:ss
            deviceNameLeft := GetJoystickName(Cougar_Left)
            msg := timeStamp " - " deviceNameLeft " (Joystick " Cougar_Left "): Button " A_Index " pressed`n"
            FileAppend, %msg%, %logFile%
            ToolTip, %msg%
            Sleep, 200  ; Debounce delay
            ToolTip
        }
        prevStateLeft[A_Index] := state
    }
    
    ; --- Check buttons for Right Cougar MFD ---
    Loop, %numButtons%
    {
        hotkey := Cougar_Right "Joy" A_Index
        GetKeyState, state, %hotkey%
        
        if (state = "D" and prevStateRight[A_Index] = "U")
        {
            FormatTime, timeStamp,, yyyy-MM-dd HH:mm:ss
            deviceNameRight := GetJoystickName(Cougar_Right)
            msg := timeStamp " - " deviceNameRight " (Joystick " Cougar_Right "): Button " A_Index " pressed`n"
            FileAppend, %msg%, %logFile%
            ToolTip, %msg%
            Sleep, 200
            ToolTip
        }
        prevStateRight[A_Index] := state
    }
}
return

;----------------------------------
; Function: GetJoystickName
; Attempts to retrieve the device name using joyGetDevCaps.
; If the retrieved name is empty or generic, it falls back to known names.
;----------------------------------
GetJoystickName(joyID) {
    VarSetCapacity(joyCaps, 256, 0)
    if (DllCall("joyGetDevCaps", "UInt", joyID - 1, "UInt", &joyCaps, "UInt", 256) = 0)
    {
        name := StrGet(&joyCaps + 4, 32)
        ; If a valid name was returned (and it isn’t the generic string), use it.
        if (name != "" && name != "HID-compliant game controller")
            return name
    }
    ; Fall back to our known names based on the global assignments.
    global Cougar_Left, Cougar_Right
    if (joyID = Cougar_Left)
         return "F-16 LMFD"
    else if (joyID = Cougar_Right)
         return "F-16 RMFD"
    return "Unknown Device"
}
