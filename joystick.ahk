#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; --- Function: GetJoystickName ---
; Returns the product name for the given joystick number (1-based)
GetJoystickName(joyID) {
    ; Allocate a buffer for the JOYCAPS structure (256 bytes is usually enough)
    VarSetCapacity(joyCaps, 256, 0)
    ; Note: The joyGetDevCaps call expects the device index as (joyID - 1)
    if (DllCall("joyGetDevCaps", "UInt", joyID-1, "UInt", &joyCaps, "UInt", 256) != 0)
        return ""
    ; The product name (szPname) is stored at offset 4, and is usually 32 characters.
    name := StrGet(&joyCaps + 4, 32)
    return name
}

; --- Automatically Detect F-16 MFD Devices ---
maxJoy := 16  ; Adjust if you expect more than 16 devices.
leftMFD := 0
rightMFD := 0

Loop, %maxJoy%
{
    joyID := A_Index
    jName := GetJoystickName(joyID)
    if (jName != "")
    {
        ; For debugging, you can output the joystick number and name:
        ; MsgBox, Joystick %joyID%: %jName%
        if InStr(jName, "F-16 LMFD")
            leftMFD := joyID
        else if InStr(jName, "F-16 RMFD")
            rightMFD := joyID
    }
}

if (leftMFD = 0 or rightMFD = 0)
{
    MsgBox, 16, Error, Could not detect both F-16 LMFD and RMFD.`nLeftMFD: %leftMFD%`nRightMFD: %rightMFD%
    ExitApp
}
else
{
    MsgBox, 64, Cougar MFD Detection, Detected:`nF-16 LMFD as Joystick %leftMFD%`nF-16 RMFD as Joystick %rightMFD%
}

; --- Now use these variables in your polling code ---
; Define the log file path
logFile := A_ScriptDir "\joystick.log"
FileDelete, %logFile%

#Persistent
pollInterval := 100         ; Polling interval (milliseconds)
numButtons := 32            ; Number of buttons to poll per device

; Initialize previous state arrays for each MFD.
global prevStateLeft := []   ; For F-16 LMFD
global prevStateRight := []  ; For F-16 RMFD

Loop, %numButtons%
{
    prevStateLeft[A_Index] := "U"
    prevStateRight[A_Index] := "U"
}

; Set the timer to poll the MFDs every pollInterval ms.
SetTimer, CheckMFDs, %pollInterval%
return

CheckMFDs:
{
    ; --- Check buttons for F-16 LMFD (Left MFD) ---
    Loop, %numButtons%
    {
        hotkey := leftMFD "Joy" A_Index
        GetKeyState, state, %hotkey%
        if (state = "D" and prevStateLeft[A_Index] = "U")
        {
            FormatTime, timeStamp,, yyyy-MM-dd HH:mm:ss
            msg := timeStamp " - F-16 LMFD (Joystick " leftMFD "): Button " A_Index " pressed`n"
            FileAppend, %msg%, %logFile%
            ToolTip, %msg%
            Sleep, 200  ; debounce delay
            ToolTip
        }
        prevStateLeft[A_Index] := state
    }
    
    ; --- Check buttons for F-16 RMFD (Right MFD) ---
    Loop, %numButtons%
    {
        hotkey := rightMFD "Joy" A_Index
        GetKeyState, state, %hotkey%
        if (state = "D" and prevStateRight[A_Index] = "U")
        {
            FormatTime, timeStamp,, yyyy-MM-dd HH:mm:ss
            msg := timeStamp " - F-16 RMFD (Joystick " rightMFD "): Button " A_Index " pressed`n"
            FileAppend, %msg%, %logFile%
            ToolTip, %msg%
            Sleep, 200
            ToolTip
        }
        prevStateRight[A_Index] := state
    }
}
return
