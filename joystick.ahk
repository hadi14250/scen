#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; --- Set the joystick numbers for your Cougar MFDs ---
; Change these values to match what Windows reports in joy.cpl for your Cougar MFDs.
Cougar_Left := 7    ; e.g., left Cougar MFD is registered as Joystick 7
Cougar_Right := 4   ; e.g., right Cougar MFD is registered as Joystick 4

; --- Log file setup ---
logFile := A_ScriptDir "\joystick.log"
FileDelete, %logFile%

#Persistent
pollInterval := 100         ; Polling interval in milliseconds
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
; If that fails, falls back to a simple WMI enumeration.
;----------------------------------
GetJoystickName(joyID) {
    VarSetCapacity(joyCaps, 256, 0)
    if (DllCall("joyGetDevCaps", "UInt", joyID - 1, "UInt", &joyCaps, "UInt", 256) = 0)
    {
        name := StrGet(&joyCaps + 4, 32)
        if (name != "")
            return name
    }
    ; Fall back to WMI-based retrieval if DirectInput didn't return a proper name.
    return GetJoystickNameWMI(joyID)
}

;----------------------------------
; Function: GetJoystickNameWMI
; Uses a basic WMI query to list HID devices.
; (Note: The ordering of devices here may not match joystick numbering exactly.)
;----------------------------------
GetJoystickNameWMI(joyID) {
    static devices := []
    if (devices.MaxIndex() = 0) {
        devices := []  ; Initialize an empty array
        wbem := ComObjGet("winmgmts:\\.\root\cimv2")
        colItems := wbem.ExecQuery("SELECT * FROM Win32_PNPEntity WHERE PNPClass = 'HIDClass'")
        for item in colItems
            devices.Push(item.Name)
    }
    ; Use joyID as an index (assuming 1-based) into the devices array.
    if (joyID > devices.Length())
        return "Unknown Device"
    return devices[joyID]
}
