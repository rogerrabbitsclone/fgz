#cs
 %                  ORIGINALLY WRITTEN IN AUTOIT V3
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
 
 
 
 
 
use this file if you want a static player. BETTER FOR STANDALONE? 
#ce ----------------------------------------------------------------------------
DirCreate(@scriptdir & "\gamez")
FileSetAttrib(@scriptdir & "\gamez", "+H")
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>

$pacman= "pacman.swf"
$bowman= "bowman-game.swf"
$doublewires = "doublewires.swf"
$gunmaster = "gun master onslaught.swf"
$supersmash = "super smash flash.swf"
$throwpaper = "throwpaper.swf"
fileinstall("C:\Users\dtp staff\Desktop\BC\gamez\swf\pacman.swf", @scriptdir & "\gamez\pacman.swf")
fileinstall("C:\Users\dtp staff\Desktop\BC\gamez\swf\bowman-game.swf", @scriptdir & "\gamez\bowman-game.swf")
fileinstall("C:\Users\dtp staff\Desktop\BC\gamez\swf\doublewires.swf", @scriptdir & "\gamez\doublewires.swf")
fileinstall("C:\Users\dtp staff\Desktop\BC\gamez\swf\gun master onslaught.swf", @scriptdir & "\gamez\gun master onslaught.swf")
fileinstall("C:\Users\dtp staff\Desktop\BC\gamez\swf\super smash flash.swf", @scriptdir & "\gamez\super smash flash.swf")
fileinstall("C:\Users\dtp staff\Desktop\BC\gamez\swf\throwpaper.swf", @scriptdir & "\gamez\throwpaper.swf")

fileinstall("C:\Users\dtp staff\Desktop\BC\gamez\swf\spring-bike.swf", @scriptdir & "\gamez\spring-bike.swf")
fileinstall("C:\Users\dtp staff\Desktop\BC\gamez\swf\jet-velocity-3d.swf", @scriptdir & "\gamez\jet-velocity-3d.swf")
fileinstall("C:\Users\dtp staff\Desktop\BC\gamez\swf\vector-stunt.swf", @scriptdir & "\gamez\vector-stunt.swf")
fileinstall("C:\Users\dtp staff\Desktop\BC\gamez\swf\last-robot.swf", @scriptdir & "\gamez\last-robot.swf")
fileinstall("C:\Users\dtp staff\Desktop\BC\gamez\swf\firebug.swf", @scriptdir & "\gamez\firebug.swf")
fileinstall("C:\Users\dtp staff\Desktop\BC\gamez\swf\freegear.swf", @scriptdir & "\gamez\freegear.swf")
fileinstall("C:\Users\dtp staff\Desktop\BC\gamez\swf\retro-pixel-racers.swf", @scriptdir & "\gamez\retro-pixel-racers.swf")
fileinstall("C:\Users\dtp staff\Desktop\BC\gamez\swf\xenos.swf", @scriptdir & "\gamez\xenos.swf")


func main()
	GUICreate ("WIkED aWE-SUm GAMeZ LOLOLOLOL", 220, 250)
	$pacbutton = GUICtrlCreateButton ("Pacman", 10, 10)
	$bowbutton = GUICtrlCreateButton ("Bowman", 10, 40)
	$doublebutton = GUICtrlCreateButton ("Doublewires", 10, 70)
	$gunbutton = GUICtrlCreateButton ("Gun Master", 10, 100)
	$superbutton = GUICtrlCreateButton ("Supersmash Flash", 10, 130)
	;$superbutton = GUICtrlCreateButton ("Supersmash Flash", 10, 130);<--------------------this needs a game
	$throwbutton = GUICtrlCreateButton ("Throwpaper", 10, 190)
	;------------------------------2nd row \/\/\/\/\/\/
	$bikebutton = GUICtrlCreateButton ("Spring Bike", 120, 10)
	$jetbutton = GUICtrlCreateButton ("Throwpaper", 120, 40)
	$vectorwbutton = GUICtrlCreateButton ("Throwpaper", 120, 70)
	$robotbutton = GUICtrlCreateButton ("Throwpaper", 120, 100)
	$firebugbutton = GUICtrlCreateButton ("Throwpaper", 120, 130)
	$freegearbutton = GUICtrlCreateButton ("Throwpaper", 120, 160)
	$pixelbutton = GUICtrlCreateButton ("Throwpaper", 120, 190)
	
	guisetstate()
		While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = $GUI_EVENT_CLOSE
				Exit
			Case $msg = $pacbutton
				shellexecute ( @scriptdir & "\gamez\flashplayer_10_sa.exe", @scriptdir & "\gamez\" & $pacman)
			Case $msg = $bowbutton
				shellexecute ( @scriptdir & "\gamez\flashplayer_10_sa.exe", @scriptdir & "\gamez\" & $bowman)
			Case $msg = $doublebutton
				shellexecute ( @scriptdir & "\gamez\flashplayer_10_sa.exe", @scriptdir & "\gamez\" & $doublewires)
			Case $msg = $gunbutton
				shellexecute ( @scriptdir & "\gamez\flashplayer_10_sa.exe", @scriptdir & "\gamez\" & $gunmaster)
			Case $msg = $superbutton
				shellexecute ( @scriptdir & "\gamez\flashplayer_10_sa.exe", @scriptdir & "\gamez\" & $supersmash)
			Case $msg = $throwbutton
				shellexecute ( @scriptdir & "\gamez\flashplayer_10_sa.exe", @scriptdir & "\gamez\" & $throwpaper)
		EndSelect
	WEnd
EndFunc
main()