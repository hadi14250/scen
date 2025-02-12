#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; Set the maximum number of joystick devices to check.
maxJoy := 16

; Create a simple array to track the previous state (for button 1) of each joystick.
global prevState := []
Loop, %maxJoy%
    prevState[A_Index] := "U"  ; "U" means up (not pressed)

; Poll every 100 milliseconds
SetTimer, CheckJoysticks, 100
return

CheckJoysticks:
{
    Loop, %maxJoy%
    {
        joyID := A_Index
        ; Check the state of button 1 on joystick 'joyID'
        hotkey := joyID "Joy1"
        GetKeyState, state, %hotkey%
        ; If the button transitions from Up ("U") to Down ("D"), then report it.
        if (state = "D" and prevState[joyID] = "U")
        {
            ; Get the joystick name using our helper function.
            name := GetJoystickName(joyID)
            ; Display the result in a message box.
            MsgBox, 64, Joystick Press Detected, Joystick %joyID% pressed.`nExact Name: %name%
            ; Update the state to "D" so we don't report again until the button is released.
            prevState[joyID] := "D"
        }
        else if (state = "U")
        {
            ; Reset the state when the button is released.
            prevState[joyID] := "U"
        }
    }
}
return

;----------------------------------
; Function: GetJoystickName
; Uses joyGetDevCaps from winmm.dll to get the product name.
;----------------------------------
GetJoystickName(joyID) {
    VarSetCapacity(joyCaps, 256, 0)
    ; joyGetDevCaps expects a zero-based index, so we pass (joyID - 1).
    if (DllCall("joyGetDevCaps", "UInt", joyID - 1, "UInt", &joyCaps, "UInt", 256) != 0)
        return "Error or not detected"
    ; The product name (szPname) is typically stored at offset 4 in the JOYCAPS structure.
    name := StrGet(&joyCaps + 4, 32)
    return name
}
