#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; ---------------------------
; CONFIGURATION: Updated Mapping
; ---------------------------
; Now, set the joystick numbers based on joy.cpl so that:
; - Joystick 4 is the RMFD.
; - Joystick 7 is the LMFD.
global Cougar_Left := 7     ; Left MFD (LMFD) is on joystick 7
global Cougar_Right := 4    ; Right MFD (RMFD) is on joystick 4

; ---------------------------
; LOG FILE SETUP
; ---------------------------
logFile := A_ScriptDir "\joystick.log"
FileDelete, %logFile%

; ---------------------------
; POLLING CONFIGURATION
; ---------------------------
#Persistent
pollInterval := 100         ; Polling interval (milliseconds)
numButtons := 32            ; Number of buttons to poll per joystick

; Initialize previous state arrays for each Cougar MFD.
global prevStateLeft := []   ; For left Cougar MFD (LMFD)
global prevStateRight := []  ; For right Cougar MFD (RMFD)

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
    ; --- Check buttons for Left Cougar MFD (LMFD) ---
    Loop, %numButtons%
    {
        hotkey := Cougar_Left "Joy" A_Index
        GetKeyState, state, %hotkey%
        
        if (state = "D" and prevStateLeft[A_Index] = "U")
        {
            FormatTime, timeStamp,, yyyy-MM-dd HH:mm:ss
            deviceNameLeft := GetJoystickName(Cougar_Left)
            msg := timeStamp " - " deviceNameLeft " (Joystick " Cougar_Left "): Button " A_Index " pressed`n"
            FileAppend, %msg%, %logFile%
            ToolTip, %msg%
            Sleep, 200  ; Debounce delay
            ToolTip
            btnKey := A_Index ""
            if (mappingLeft.HasKey(btnKey))
            {
                params := mappingLeft[btnKey]
                SimulateMouseClick(params.monitor, params.x, params.y)
            }
        }
        prevStateLeft[A_Index] := state
    }
    
    ; --- Check buttons for Right Cougar MFD (RMFD) ---
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
            btnKey := A_Index ""
            if (mappingRight.HasKey(btnKey))
            {
                params := mappingRight[btnKey]
                SimulateMouseClick(params.monitor, params.x, params.y)
            }
        }
        prevStateRight[A_Index] := state
    }
}
return

; ---------------------------
; MAPPING CONFIGURATION
; ---------------------------
; Define the mapping for each button on each MFD.
; The mapping is an object where the key is the button number (as a string) and the value is an object with:
;   monitor: Monitor number (as used by SysGet)
;   x: Horizontal offset (pixels) relative to the monitor's top-left corner
;   y: Vertical offset (pixels) relative to the monitor's top-left corner
global mappingLeft := {}   ; For left MFD (LMFD)
global mappingRight := {}  ; For right MFD (RMFD)

; Example mappings:
mappingLeft["1"] := { monitor: 2, x: 300, y: 400 }   ; For LMFD (joystick 7) button 1
mappingRight["1"] := { monitor: 2, x: 500, y: 600 }  ; For RMFD (joystick 4) button 1

; (Add additional mappings as needed...)

; ---------------------------
; SIMULATE MOUSE CLICK FUNCTION
; ---------------------------
SimulateMouseClick(monitorNum, xOffset, yOffset) {
    SysGet, monLeft, Monitor, %monitorNum%, Left
    SysGet, monTop, Monitor, %monitorNum%, Top
    targetX := monLeft + xOffset
    targetY := monTop + yOffset
    
    MouseGetPos, origX, origY
    CoordMode, Mouse, Screen
    MouseMove, %targetX%, %targetY%, 0
    Sleep, 50
    Click
    Sleep, 1000  ; Leave mouse at target for 1 second (for debugging)
    MouseMove, %origX%, %origY%, 0
}

; ---------------------------
; FUNCTION: GetJoystickName
; Attempts to retrieve the device name using joyGetDevCaps.
; If the name is empty or generic, it falls back to known names.
; ---------------------------
GetJoystickName(joyID) {
    VarSetCapacity(joyCaps, 256, 0)
    if (DllCall("joyGetDevCaps", "UInt", joyID - 1, "UInt", &joyCaps, "UInt", 256) = 0)
    {
        name := StrGet(&joyCaps + 4, 32)
        if (name != "" && name != "HID-compliant game controller")
            return name
    }
    global Cougar_Left, Cougar_Right
    ; Notice: Now, since we swapped the physical assignments:
    ; - Cougar_Left (LMFD) is joystick 7
    ; - Cougar_Right (RMFD) is joystick 4
    if (joyID = Cougar_Right)
         return "F-16 RMFD"
    else if (joyID = Cougar_Left)
         return "F-16 LMFD"
    return "Unknown Device"
}
