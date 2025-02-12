#NoEnv
#SingleInstance Force
SetBatchLines, -1
; Set the maximum number of joystick devices you want to check
maxJoy := 16
names := ""

Loop, %maxJoy%
{
    name := GetJoystickName(A_Index)
    if (name = "")
        names .= "Joystick " A_Index ": Not detected or error`n"
    else
        names .= "Joystick " A_Index ": " name "`n"
}

MsgBox, % names
return

; Function to retrieve the product name of a joystick device using joyGetDevCaps.
GetJoystickName(joyID) {
    ; Allocate a 256-byte buffer for the JOYCAPS structure.
    VarSetCapacity(joyCaps, 256, 0)
    ; Note: joyGetDevCaps expects a zero-based index, so pass (joyID - 1)
    if (DllCall("joyGetDevCaps", "UInt", joyID-1, "UInt", &joyCaps, "UInt", 256) != 0)
        return ""
    ; The product name (szPname) is typically stored at offset 4 in the JOYCAPS structure.
    ; We assume a maximum length of 32 characters.
    name := StrGet(&joyCaps + 4, 32)
    return name
}
