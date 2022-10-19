# Check-USB
A PowerShell tool that will check for a connected USB at logoff and if found will display a WinForm MessageBox.

If a USB drive is still connected at logoff a message box will be displayed and logoff will be delayed 60 seconds displaying a countdown timer.

This tool is useful in a computer lab environment, where people tend to forget their USB when leaving.

Code can also be added in to have it get their username from Windows and query AD and send them an email so they know they left their USB.

You can run this in Group Policy as a logoff script with this command: powershell.exe -NoLogo -NoProfile -WindowStyle Hidden ".\Check-USB.ps1"

