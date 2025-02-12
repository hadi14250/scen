#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; -----------------------------------------------------------
; Function: PrintButton
; Purpose: Displays a tooltip with the MFD (Left/Right) and button number.
; -----------------------------------------------------------
PrintButton(mfd, btn) {
    ToolTip, % mfd " MFD: Button " btn " pressed"
    ; Remove the tooltip after 1 second (1000 ms)
    SetTimer, RemoveToolTip, -1000
}

; -----------------------------------------------------------
; Left MFD (Joystick 1) Button Hotkeys
; -----------------------------------------------------------

1Joy1::PrintButton("Left", 1)
1Joy2::PrintButton("Left", 2)
1Joy3::PrintButton("Left", 3)
1Joy4::PrintButton("Left", 4)
1Joy5::PrintButton("Left", 5)
; Add additional left MFD buttons as needed:
; 1Joy6::PrintButton("Left", 6)
; 1Joy7::PrintButton("Left", 7)
; etc.

; -----------------------------------------------------------
; Right MFD (Joystick 2) Button Hotkeys
; -----------------------------------------------------------

2Joy1::PrintButton("Right", 1)
2Joy2::PrintButton("Right", 2)
2Joy3::PrintButton("Right", 3)
2Joy4::PrintButton("Right", 4)
2Joy5::PrintButton("Right", 5)
; Add additional right MFD buttons as needed:
; 2Joy6::PrintButton("Right", 6)
; 2Joy7::PrintButton("Right", 7)
; etc.

; -----------------------------------------------------------
; Timer to Remove the Tooltip
; -----------------------------------------------------------
RemoveToolTip:
    ToolTip  ; Clear the tooltip
Return
