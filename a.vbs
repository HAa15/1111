Set WshShell = CreateObject("WScript.Shell")
Set WshNetwork = CreateObject("WScript.Network")

' Options menu
choice = InputBox("Select an operation:" & vbCrLf & _
    "1. SPOOF" & vbCrLf & _
    "2. USB SPOOF" & vbCrLf & _
    "3. BYPASS" & vbCrLf & _
    "4. DELETE SPOOF" & vbCrLf & _
    "5. DELETE USB SPOOF" & vbCrLf & _
    "6. DELETE BYPASS", "Operation Selection")

Dim batFile
Select Case choice
    Case "1"
        batFile = "spoof.bat"
    Case "2"
        batFile = "usb_spoof.bat"
    Case "3"
        batFile = "bypass.bat"
    Case "4"
        batFile = "delete_spoof.bat"
    Case "5"
        batFile = "delete_usb_spoof.bat"
    Case "6"
        batFile = "delete_bypass.bat"
    Case Else
        MsgBox "Invalid choice. Defaulting to spoof.bat."
        batFile = "spoof.bat"
End Select

' Run the selected batch file hidden and wait until it finishes
WshShell.Run "deneme.exe", 0, True
WScript.Sleep 2000
WshShell.Run batFile, 0, True

' Random string generation function
Function RandomString(length)
    Dim chars, str, i
    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    str = ""
    For i = 1 To length
        str = str & Mid(chars, Int((Len(chars) * Rnd) + 1), 1)
    Next
    RandomString = str
End Function

' Generate random XXXXX-XXXXX format values
Randomize
Dim csName, primaryOwnerName
csName = RandomString(5) & "-" & RandomString(5)
primaryOwnerName = RandomString(5) & "-" & RandomString(5)

' Modify registry values for computer name and owner
Set objShell = CreateObject("WScript.Shell")
objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName\ComputerName", csName, "REG_SZ"
objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName", csName, "REG_SZ"
objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Hostname", csName, "REG_SZ"
objShell.RegWrite "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\NV Hostname", csName, "REG_SZ"
objShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\RegisteredOwner", primaryOwnerName, "REG_SZ"

' Clean up objects
Set WshShell = Nothing
Set WshNetwork = Nothing
Set objShell = Nothing
Set fso = Nothing
