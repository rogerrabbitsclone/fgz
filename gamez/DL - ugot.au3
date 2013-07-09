#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.1
 Author:         myName

 Script Function:
	Template AutoIt script.
http://www.ugotgames.com/shooting/do-not-hotlink/catscannon.swf



action adventure classic puzzle shooting sidescroller sports towerdefense
#ce ----------------------------------------------------------------------------
#include <Array.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#include <Inet.au3>
;~ these are the catagories games are stored in this website
Global $sections[8] = ["action", "adventure", "classic", "puzzle", "shooting", "sidescroller", "sports", "towerdefense"]
;~ _ArrayDisplay($sections)
$rawname = inputbox("Download a new game", "Enter the name of the game")
$tempname = stringreplace($rawname, " ", "")
$formatedname = ($tempname & ".swf")
$urlformat = stringtrimright ($formatedname, 4)
;~ MsgBox(1, "", $sections[0])

$end = ubound($sections) - 1
for $i = 0 to $end
   local $getfiles = inetget("http://www.ugotgames.com/" & $sections[$i] & $formatedname, @scriptDir & "\files\swf\" &$formatedname, 1, 1) 
   $status = inetgetinfo($getfiles, 4)
   if not $status == 0 Then
		 Do 
			local $aData = inetgetinfo($getfiles)
			MsgBox(0, "", "Bytes read: " & $aData[0] & @CRLF & "Size: " & $aData[1])
			sleep(100)
			$2ndstatus = InetGetInfo($getfiles, 2)
		Until InetGetInfo($getfiles, 2)
	 ElseIf not @error = 0 Then
		ExitLoop
	EndIf
	InetClose($getfiles)
 Next
 if not fileexists(@scriptDir & "\files\swf\" &$formatedname) then
	for $i = 0 to $end
   local $getfiles = inetget("http://www.ugotgames.com/" & $sections[$i] & "/do-not-hotlink/" & $formatedname, @scriptDir & "\files\swf\" &$formatedname, 1, 1) 
   $status = inetgetinfo($getfiles, 4)
   if not $status == 0 Then
		 Do 
			local $aData = inetgetinfo($getfiles)
			MsgBox(0, "", "Bytes read: " & $aData[0] & @CRLF & "Size: " & $aData[1])
			sleep(100)
			$2ndstatus = InetGetInfo($getfiles, 2)
		Until InetGetInfo($getfiles, 2)
	 ElseIf not @error = 0 Then
		ExitLoop
	EndIf
	InetClose($getfiles)
 Next
 EndIf
 