#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; ---------------------------
; CONFIGURATION
; ---------------------------
; Set the joystick numbers for your Cougar MFDs as reported in joy.cpl.
global Cougar_Left := 7    ; For example, left Cougar MFD is registered as Joystick 7
global Cougar_Right := 4   ; For example, right Cougar MFD is registered as Joystick 4

; ---------------------------
; MAPPING CONFIGURATION
; ---------------------------
; Define the mapping for each button on each MFD.
; The mapping is defined as an object/dictionary where the key is the button number (as a string)
; and the value is an object with properties:
;   monitor: The monitor number (as returned by SysGet)
;   x: The horizontal offset (in pixels) relative to that monitor's top-left corner
;   y: The vertical offset (in pixels) relative to that monitor's top-left corner
;
; Example: For the left MFD, when button "1" is pressed, click on monitor 2 at position (100,200)
global mappingLeft := {}  ; For Cougar_Left device
global mappingRight := {} ; For Cougar_Right device

; --- Modify these mappings as needed ---
mappingLeft["1"] := { monitor: 2, x: 100, y: 200 }
mappingLeft["2"] := { monitor: 2, x: 150, y: 250 }
; Add more mappings for left MFD buttons as needed...

mappingRight["1"] := { monitor: 2, x: 300, y: 400 }
mappingRight["2"] := { monitor: 2, x: 350, y: 450 }
; Add more mappings for right MFD buttons as needed...

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

; ---------------------------
; POLLING FUNCTION
; ---------------------------
CheckCougarMFD:
{
    ; --- Check buttons for Left Cougar MFD ---
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
            
            ; --- Check if a mapping exists for this button on the left MFD ---
            btnKey := A_Index ""  ; Convert button number to string
            if (mappingLeft.HasKey(btnKey))
            {
                params := mappingLeft[btnKey]
                SimulateMouseClick(params.monitor, params.x, params.y)
            }
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
            
            ; --- Check if a mapping exists for this button on the right MFD ---
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
; SIMULATE MOUSE CLICK FUNCTION
; ---------------------------
SimulateMouseClick(monitorNum, xOffset, yOffset) {
    ; Retrieve the monitor's top-left coordinates.
    ; SysGet returns the position of the specified monitor.
    SysGet, monLeft, Monitor, %monitorNum%, Left
    SysGet, monTop, Monitor, %monitorNum%, Top
    targetX := monLeft + xOffset
    targetY := monTop + yOffset
    
    ; Optionally, save the current mouse position.
    MouseGetPos, origX, origY
    ; Set coordinate mode to screen coordinates.
    CoordMode, Mouse, Screen
    ; Move the mouse instantly to the target coordinates.
    MouseMove, %targetX%, %targetY%, 0
    Sleep, 50  ; Short delay to ensure the move is complete.
    Click  ; Simulate a left mouse click.
    Sleep, 50
    ; Return the mouse to its original position.
    MouseMove, %origX%, %origY%, 0
}

; ---------------------------
; FUNCTION: GetJoystickName
; Retrieves the device name using joyGetDevCaps and falls back to known names.
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
    if (joyID = Cougar_Left)
         return "F-16 LMFD"
    else if (joyID = Cougar_Right)
         return "F-16 RMFD"
    return "Unknown Device"
}
