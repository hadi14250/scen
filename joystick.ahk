#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; ---------------------------
; CONFIGURATION
; ---------------------------
; Set the joystick numbers for your Cougar MFDs as reported in joy.cpl.
; In this configuration:
;   - The left MFD (LMFD) is on joystick 7.
;   - The right MFD (RMFD) is on joystick 4.
global Cougar_Left := 7    ; LMFD
global Cougar_Right := 4   ; RMFD

; ---------------------------
; LOG FILE SETUP
; ---------------------------
logFile := A_ScriptDir "\joystick.log"
FileDelete, %logFile%

; ---------------------------
; MAPPING CONFIGURATION
; ---------------------------
; Define the mapping for each button on each MFD.
; Modify or add new lines as needed.
global mappingLeft := {}   ; For left MFD (LMFD)
global mappingRight := {}  ; For right MFD (RMFD)

; --- Example mappings for Left MFD (LMFD) ---
mappingLeft["1"] := { monitor: 2, x: 300, y: 400 }   ; When button 1 is pressed on LMFD, click at (300,400) on monitor 2.
mappingLeft["2"] := { monitor: 2, x: 350, y: 450 }   ; When button 2 is pressed on LMFD, click at (350,450) on monitor 2.
; Add more mappings for left MFD as needed:
; mappingLeft["3"] := { monitor: 2, x: 400, y: 500 }

; --- Example mappings for Right MFD (RMFD) ---
mappingRight["1"] := { monitor: 2, x: 500, y: 600 }  ; When button 1 is pressed on RMFD, click at (500,600) on monitor 2.
mappingRight["2"] := { monitor: 2, x: 550, y: 650 }  ; When button 2 is pressed on RMFD, click at (550,650) on monitor 2.
; Add more mappings for right MFD as needed:
; mappingRight["3"] := { monitor: 2, x: 600, y: 700 }

; ---------------------------
; POLLING CONFIGURATION
; ---------------------------
#Persistent
pollInterval := 100         ; Polling interval in milliseconds
numButtons := 32            ; Number of buttons to poll per joystick

; Initialize previous state arrays for each MFD.
global prevStateLeft := []   ; For left MFD (LMFD)
global prevStateRight := []  ; For right MFD (RMFD)

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
            btnKey := A_Index ""  ; Convert button number to string
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
; SIMULATE MOUSE CLICK FUNCTION
; ---------------------------
SimulateMouseClick(monitorNum, xOffset, yOffset) {
    ; Get the top-left coordinates of the target monitor.
    SysGet, monLeft, Monitor, %monitorNum%, Left
    SysGet, monTop, Monitor, %monitorNum%, Top
    targetX := monLeft + xOffset
    targetY := monTop + yOffset
    
    ; Save the current mouse position.
    MouseGetPos, origX, origY
    CoordMode, Mouse, Screen
    ; Move the mouse to the target coordinates.
    MouseMove, %targetX%, %targetY%, 0
    Sleep, 50  ; Brief delay for the move.
    Click      ; Simulate a left-click.
    Sleep, 1000 ; (For debugging) Leave the mouse at the target for 1 second.
    ; Optionally, return the mouse to its original position.
    MouseMove, %origX%, %origY%, 0
}

; ---------------------------
; GET JOYSTICK NAME FUNCTION
; ---------------------------
GetJoystickName(joyID) {
    VarSetCapacity(joyCaps, 256, 0)
    if (DllCall("joyGetDevCaps", "UInt", joyID - 1, "UInt", &joyCaps, "UInt", 256) = 0) {
        name := StrGet(&joyCaps + 4, 32)
        if (name != "" && name != "HID-compliant game controller")
            return name
    }
    global Cougar_Left, Cougar_Right
    if (joyID = Cougar_Right)
         return "F-16 RMFD"
    else if (joyID = Cougar_Left)
         return "F-16 LMFD"
    return "Unknown Device"
}
