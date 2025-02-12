#NoEnv
#SingleInstance Force
SetBatchLines, -1
SendMode Input
SetWorkingDir %A_ScriptDir%

maxJoy := 16  ; Check joystick numbers 1 to 16
buttonToCheck := "Joy1"  ; Change this if you want to check a different button, e.g. "Joy2"

; Update the tooltip every 1000 milliseconds (1 second)
SetTimer, ShowJoystickStates, 1000
return

ShowJoystickStates:
    stateText := ""
    Loop, %maxJoy%
    {
        joyID := A_Index
        GetKeyState, state, % joyID buttonToCheck
        stateText .= "Joystick " joyID " - " buttonToCheck ": " state "`n"
    }
    ToolTip, %stateText%
return
