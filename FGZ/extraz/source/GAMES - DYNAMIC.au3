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
TO DO:
most important: FGZ crashes when you do not have an even ammount of games. 
1. Write options menu with "openfiledir" and other toggleable options. 
2. put settings for options into INI File
3. figure out how to check adobe for the latest flash player and download. (seperate ini file?)
4. add "download games" and figure out how to pirate them from other websites. 
5. add more games to default FileInstall
6. make installer/standalone versions (standalone must delete files on exit)
7. how to transfer w/ all your games????
8. autorestart after adding games to folder


LESS IMPORTANT:
1. build website for program
2. release under beerware to honor the slackware developers. 

#ce
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <File.au3>
Global $swfgames = _FileListToArray(@scriptDir & "\files\swf\", "*", 1)
Global $howmanygames = ubound($swfgames)
If Mod($howmanygames, 2) = 0 Then
   _arrayadd ($swfgames, "ZPLACEHOLDER....")
EndIf

func main()
	Opt("GUIOneventmode", 1)
	Opt("GUIResizeMode", 1)
	
;~ 	this finds the longest name for resizing of the GUI window
	$longest = 1
	For $g = 1 To $swfgames[0]
		$name = StringTrimRight($swfgames[$g], 4)
		$len = StringLen($name)
		if $len > $longest Then
			$longest = $len
		EndIf
	Next
	
	$fromleft = $longest * 6 + 10
	$GUIwidth = $longest * 6 * 2 + 10 ;this is the width of the GUI window
	$GUIheight = $howmanygames * 32 / 2 + 40  ;this is the height of the GUI window
	if $GUIwidth < 170 Then
		$GUIwidth = 170
	EndIf
	if $GUIheight < 100 Then
		$GUIheight = 100
	EndIf
	GUICreate ("FGZ", $GUIwidth, $GUIheight)

;~ 	These control the built in windows functions of the window
	GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
    GUISetOnEvent($GUI_EVENT_MINIMIZE, "SpecialEvents")
    GUISetOnEvent($GUI_EVENT_RESTORE, "SpecialEvents")
	
	$firstrow = $howmanygames / 2 ;this determines the for loop of the left column
	$secondrow = $firstrow + 1 ;this determines the for loop of the right column
	
;~ 	these are the functions to create the buttons for the games

;~ 	this is the left column
	$height1 = 40
	$height2 = 40
	For $I = 1 To $firstrow
		local $x
		$name = StringTrimRight($swfgames[$I], 4)
		GUICtrlCreateButton ($name, 5, $height1)
		GUIctrlsetonevent(-1, "launch")	
		$height1 = $height1 + 30
	Next

	;~ this is the right column
	For $I = $secondrow To $howmanygames
		local $y
		$name = StringTrimRight($swfgames[$I], 4)
 		GUICtrlCreateButton ($name, $fromleft, $height2)
		GUICtrlSetOnEvent(-1, "launch")
		$height2 = $height2 + 30
		
	Next
	
;~ 	open games folder button
	$putwhere = $guiwidth / 2
	guictrlcreatebutton("OPEN GAMES FOLDER", $putwhere, 2)
	GUICtrlSetOnEvent(-1, "gamesdir")
	
;~ 	download games
   
	GUISetState(@sw_show)
	$putwhere = 0
	guictrlcreatebutton("DOWNLOAD GAMEZ", $putwhere, 2)
	GUICtrlSetOnEvent(-1, "download")
	While 1
		sleep (10)
	WEnd
	
EndFunc

;~ this is going to be more options. i need to work on it. 
Func options()
	Opt("GUIOneventmode", 1)
	
	GUICreate("Options", 100, 100)
	
	GUISetOnEvent($GUI_EVENT_CLOSE, "SpecialEvents")
    GUISetOnEvent($GUI_EVENT_MINIMIZE, "SpecialEvents")
    GUISetOnEvent($GUI_EVENT_RESTORE, "SpecialEvents")
		
	guictrlcreatebutton("OPEN GAMES FOLDER", 10, 2)
	GUICtrlSetOnEvent(-1, "gamesdir")
	
	GUISetState(@sw_show)
	
	While 1
		sleep (10)
	WEnd
EndFunc

;~ Download function. 
Func download()
   while 1
	  MsgBox(32, "How to Download", "Go to 'freegames.org' and pick a game. put the url of the game including 'http://www. ' into the next window and restart FGZ")
	  $where = InputBox("", "enter URL")
	  $name = StringTrimLeft($where, 21)
	  $name2 = StringTrimRight($name, 1)
	  InetGet("http://media.freegames.org/swf/" & $name2  & ".swf", @scriptdir & "\files\swf\" & $name2 & ".swf")
	  if not FileExists (@scriptdir & "\" & $name2 & ".swf") Then
		 msgbox(5, "Download Failed", "Whoops! Looks like the URL you entered didn't work. Make sure it has 'http://www.' at the begining. " & @CRLF & "You can also download them manually")
		 if @error = 2 Then
			ExitLoop
		 EndIf
	  ElseIf FileExists (@scriptdir & "\" & $name2 & ".swf") Then
		 msgbox (0, "Success" "Download successful!")
		 ExitLoop
	  EndIf
	  if @error = 4 Then
		 ContinueLoop
	  else
		 ExitLoop
	  EndIf
   WEnd   
EndFunc

;~ this function matches the name of the button clicked to the game name and adds the '.swf' extention to launch it
Func launch($name)
	for $q = 1 to $swfgames[0]
		$name = StringTrimRight($swfgames[$q], 4)
		$buttonname = GUIctrlread(@gui_ctrlid)
		if $buttonname == $name Then
			$buttonname = $buttonname & ".swf"
			shellexecute (@scriptdir & "\files\flashplayer_10_sa.exe", @scriptdir & "\files\swf\" & $buttonname)
			ExitLoop
		EndIf		
	next
EndFunc

;~ opens the game directory
func gamesdir()
	$swfdir = (@scriptdir & "\files\swf")
	ShellExecute ($swfdir)
EndFunc

;~ these are the built in windows functions to control the window
Func SpecialEvents()
    Select
        Case @GUI_CtrlId == $GUI_EVENT_MINIMIZE
        Case @GUI_CtrlId == $GUI_EVENT_RESTORE
        Case @GUI_CtrlId == $GUI_EVENT_CLOSE
            Exit
    EndSelect
EndFunc

;~ checks for folders and the standalone flash player at startup. also puts in pacman if its not there. there should always be pacman. always.
Func initialstartup()
	local $filesdir = @scriptdir & "\files"
	Select
		case not FileExists($filesdir)
			DirCreate(@scriptdir & "\files")
			DirCreate(@scriptdir & "\files\swf")
			sleep(300)
			fileinstall ("C:\Users\dtp staff\Desktop\BC\gamez\files\flashplayer_10_sa.exe", @scriptdir & "\files\flashplayer_10_sa.exe")
			fileinstall ("C:\Users\dtp staff\Desktop\BC\gamez\files\swf\pacman.swf", @scriptdir & "\files\swf\pacman.swf")
			fileinstall ("C:\Users\dtp staff\Desktop\BC\gamez\files\swf\Bowman.swf", @scriptdir & "\files\swf\Bowman.swf")
			FileSetAttrib(@scriptdir & "\files", "+H")
		EndSelect
	EndFunc
	
;~ although unlikly with the initialstarup() function in place, these check again for the files dir and various other things.
;~ i wrote these before the initialstartup() function and left them here. i think you could never have enough error checks. 

func errorcheck()
	local $filesdir = @scriptdir & "\files", $swfdir = @scriptdir & "\files\swf"
	Select
		case not FileExists($filesdir)
			DirCreate(@scriptdir & "\files")
			fileinstall ("C:\Users\dtp staff\Desktop\BC\gamez\files\flashplayer_10_sa.exe", @scriptdir & "\files\flashplayer_10_sa.exe")
			MsgBox (48, "Whoops!", "Looks like the data directory:" & @CRLF  & $filesdir & @CRLF &  "doesnt exist! If this is the first time you've run this program don't worry, I'll Make it now.")
			Exit
		case not FileExists ($filesdir & "\flashplayer_10_sa.exe")
			MsgBox (48, "Whoops!", "Looks like you're missing the flash player!:" & @CRLF  & $filesdir & @CRLF & "Make sure the program 'flashplayer_10_sa.exe' is in the above directory or your games won't play.")
			Exit
		case not FileExists($swfdir)
			MsgBox (4096, "Whoops!", "Looks like the game directory:" & @CRLF  & $swfsdir & @CRLF & "doesnt exist! I'll make one now, but its empty so make sure you put games in it.")
			DirCreate(@scriptdir & "\files\swf")
			Exit
		case not FileExists($swfdir & "\*")
			$response = MsgBox (48, "Whoops!", "Looks like the game directory:" & @CRLF  & $swfdir & @CRLF & "is empty! Make sure your .swf files are located in that folder."& @CRLF & "Click OK to open it and start adding games now. otherwise click cancel and open the games folder from within the program.")
			if $response == 1 Then
				gamesdir()
			EndIf
		Case $howmanygames > 200
			$responce = MsgBox(16, "WHOA THERE!!!", "You have more than 200 games in your games folder. This program wasn't designed to have that many! If you know what you're doing click OK, if you want to exit press cancel")
			if not $responce == 1 Then
				Exit
			 endif
		  case mod($howmanygames, 2) = 0 
			 FileCopy ($swfgames[1], @scriptdir & "\files\swf\ .swf")

		EndSelect
	EndFunc
	
initialstartup()
sleep(1000)
errorcheck()
main()
	
	
	
	
	
	
	
	
	
	
	