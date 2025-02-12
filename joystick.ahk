#Requires AutoHotkey v2.0
; ============================================================
; CONFIGURATION
; ============================================================
; Set the joystick numbers for your Cougar MFDs as reported in joy.cpl.
; In this configuration:
;   - The left MFD (LMFD) is on joystick 7.
;   - The right MFD (RMFD) is on joystick 4.
global Cougar_Left  := 7    ; LMFD
global Cougar_Right := 4    ; RMFD

; ============================================================
; LOG FILE SETUP
; ============================================================
global logFile := A_ScriptDir "\joystick.log"
FileDelete(logFile)

; ============================================================
; MAPPING CONFIGURATION
; ============================================================
; For each button (identified by its button number as a string) on each MFD,
; you define an object with:
;   monitor: The monitor number (as used by SysGet)
;   x: The horizontal offset (pixels) relative to that monitor's top-left corner
;   y: The vertical offset (pixels) relative to that monitor's top-left corner
global mappingLeft  := {}  ; For left MFD (LMFD)
global mappingRight := {}  ; For right MFD (RMFD)

; --- Example mappings for left MFD (LMFD) ---
; When button "1" is pressed on LMFD, move the mouse to (500,500) on monitor 1.
mappingLeft["1"] := { monitor: 1, x: 500, y: 500 }
; When button "2" is pressed on LMFD, move the mouse to (550,550) on monitor 1.
mappingLeft["2"] := { monitor: 1, x: 550, y: 550 }
; (Add more mappings for left MFD as needed.)

; --- Example mappings for right MFD (RMFD) ---
; When button "1" is pressed on RMFD, move the mouse to (600,600) on monitor 1.
mappingRight["1"] := { monitor: 1, x: 600, y: 600 }
; When button "2" is pressed on RMFD, move the mouse to (650,650) on monitor 1.
mappingRight["2"] := { monitor: 1, x: 650, y: 650 }
; (Add more mappings for right MFD as needed.)

; ============================================================
; POLLING CONFIGURATION
; ============================================================
global pollInterval := 100  ; Poll every 100 milliseconds
global numButtons   := 32   ; Poll 32 buttons per joystick

; Initialize previous state arrays for each MFD.
global prevStateLeft  := []  ; For left MFD (LMFD)
global prevStateRight := []  ; For right MFD (RMFD)
for i := 1 to numButtons {
    prevStateLeft.Push("U")
    prevStateRight.Push("U")
}

; Set a timer to run the polling function every pollInterval milliseconds.
SetTimer("CheckCougarMFD", pollInterval)

; ============================================================
; POLLING FUNCTION
; ============================================================
CheckCougarMFD() {
    global Cougar_Left, Cougar_Right, numButtons, prevStateLeft, prevStateRight, mappingLeft, mappingRight, logFile

    ; --- Check buttons for Left Cougar MFD (LMFD) ---
    for i := 1 to numButtons {
        hotkey := Cougar_Left . "Joy" . i
        state := GetKeyState(hotkey)
        if state = "D" && prevStateLeft[i - 1] = "U" {
            timeStamp := Format("{:yyyy-MM-dd HH:mm:ss}", A_Now)
            deviceNameLeft := GetJoystickName(Cougar_Left)
            msg := timeStamp " - " deviceNameLeft " (Joystick " Cougar_Left "): Button " i " pressed`n"
            FileAppend(msg, logFile)
            ToolTip(msg)
            Sleep(200)
            ToolTip("")
            btnKey := i ""  ; Convert number to string
            if mappingLeft.HasKey(btnKey) {
                params := mappingLeft[btnKey]
                SimulateMouseMove(params.monitor, params.x, params.y)
            }
        }
        prevStateLeft[i - 1] := state
    }

    ; --- Check buttons for Right Cougar MFD (RMFD) ---
    for i := 1 to numButtons {
        hotkey := Cougar_Right . "Joy" . i
        state := GetKeyState(hotkey)
        if state = "D" && prevStateRight[i - 1] = "U" {
            timeStamp := Format("{:yyyy-MM-dd HH:mm:ss}", A_Now)
            deviceNameRight := GetJoystickName(Cougar_Right)
            msg := timeStamp " - " deviceNameRight " (Joystick " Cougar_Right "): Button " i " pressed`n"
            FileAppend(msg, logFile)
            ToolTip(msg)
            Sleep(200)
            ToolTip("")
            btnKey := i ""
            if mappingRight.HasKey(btnKey) {
                params := mappingRight[btnKey]
                SimulateMouseMove(params.monitor, params.x, params.y)
            }
        }
        prevStateRight[i - 1] := state
    }
}

; ============================================================
; SIMULATE MOUSE MOVE FUNCTION (No Click)
; ============================================================
SimulateMouseMove(monitorNum, xOffset, yOffset) {
    ; Retrieve the target monitor's top-left coordinates.
    monLeft := SysGet("Monitor", monitorNum, "Left")
    monTop  := SysGet("Monitor", monitorNum, "Top")
    targetX := monLeft + xOffset
    targetY := monTop + yOffset

    ; (For debugging, display the target coordinates in a tooltip.)
    ToolTip("Moving mouse to: " targetX ", " targetY)
    Sleep(1000)
    ToolTip("")

    ; Save the current mouse position.
    origPos := MouseGetPos()
    ; Move the mouse instantly to the target coordinates.
    MouseMove(targetX, targetY, 0)
    Sleep(50)
    ; Optionally, return the mouse to its original position.
    MouseMove(origPos.x, origPos.y, 0)
}

; ============================================================
; GET JOYSTICK NAME FUNCTION
; ============================================================
GetJoystickName(joyID) {
    global Cougar_Left, Cougar_Right
    VarSetCapacity(joyCaps, 256, 0)
    if DllCall("joyGetDevCaps", "UInt", joyID - 1, "UInt", &joyCaps, "UInt", 256) = 0 {
        name := StrGet(&joyCaps + 4, 32)
        if name != "" && name != "HID-compliant game controller"
            return name
    }
    if joyID = Cougar_Right
        return "F-16 RMFD"
    else if joyID = Cougar_Left
        return "F-16 LMFD"
    return "Unknown Device"
}
