#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <File.au3>

Global $swfgames = _FileListToArray(@scriptDir & "\files\swf\", "*", 1)
Global $howmanygames = ubound($swfgames)


Local $n = 18
If Mod($howmanygames, 2) = 0 Then
    MsgBox(0, "", $howmanygames & " is an even number." & $swfgames[1])
	FileCopy (@scriptDir & "\files\swf\" & $swfgames[1], @scriptdir & "\files\swf\z.swf")
Else
    MsgBox(0, "", $howmanygames & " is an odd number.  " & $swfgames[1])
EndIf