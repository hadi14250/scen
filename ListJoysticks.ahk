; This is a very basic example using COM to query WMI for HID devices.
; It may not list exactly what you need, but it can help you see what names Windows sees.
#NoEnv
SetBatchLines, -1
ComObjError(false)
hidDevices := ""
wbemServices := ComObjGet("winmgmts:\\.\root\cimv2")
colItems := wbemServices.ExecQuery("SELECT * FROM Win32_PNPEntity WHERE PNPClass = 'HIDClass'")
for device in colItems
    hidDevices .= device.Name "`n"
MsgBox, HID devices:`n%hidDevices%
