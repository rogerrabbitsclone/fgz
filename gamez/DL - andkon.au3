#cs ----------------------------------------------------------------------------
 %                  ORIGINALLY WRITTEN IN AUTOIT V 3.2.8.1
 %                   http://www.autoitscript.com
/*
 * ----------------------------------------------------------------------------
 * "MY BEER-WARE LICENSE":
 * I wrote this file for FGZ. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you must buy me a beer in return. Original Author: Brian Carlson
 * If modified, add whatever you want below this line:
 * ----------------------------------------------------------------------------
 * (add content here)
 *
 * ----------------------------------------------------------------------------
 *\
This portion downloads flash games and puts them in the swf folder. ATT only 
works with andkon.com

url swf locations are formatted like this:
http://andkon.com/arcade/adventureaction/bobtherobber/bobtherobber.swf
--------------------------------------------------------------------------------
TO DO:
   1. find way to bypass url locking. 
   https://www.owasp.org/index.php/Testing_for_Cross_site_flashing_%28OWASP-DV-004%29#HTML_Injection
   http://help.adobe.com/en_US/as3/dev/WS901d38e593cd1bac61bb910e130015e4804-8000.html
   http://www.geekstogo.com/forum/topic/263345-how-can-i-spoof-target-urls-for-a-url-locked-swf-game-it-has-no/
   http://active.tutsplus.com/tutorials/actionscript/quick-tip-lock-your-swf-to-a-specific-domain-name/
   http://forums.adobe.com/message/4291106
   
#ce ----------------------------------------------------------------------------
#include <Array.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#include <Inet.au3>
;~ these are the catagories games are stored in this website
Global $sections[9] = ["racing", "missiledefender", "tetris", "adventureaction", "other", "puzzle", "obstacles", "casino", "shooter"]
;~ _ArrayDisplay($sections)
$rawname = inputbox("Download a new game", "Enter the name of the game")
$tempname = stringreplace($rawname, " ", "")
$formatedname = ($tempname & ".swf")
$urlformat = stringtrimright ($formatedname, 4)
;~ MsgBox(1, "", $sections[0])

$end = ubound($sections) - 1
for $i = 0 to $end
   local $getfiles = inetget("http://www.andkon.com/arcade/" & $sections[$i] & "/" & $urlformat & "/" & $formatedname, @scriptDir & "\files\swf\" &$formatedname, 1, 1) 
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
