#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         myName

 Script Function:
	Template AutoIt script.
flashplayer_10_sa.exeflashplayer_10_sa.exe
#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here


func errorcheck()
	local $filesdir = (@scriptdir & "\files"), $swfdir = @scriptdir & "\files\swf"
	Select
		case not FileExists($filesdir)
			MsgBox (48, "Whoops!", "Looks like the data directory:" & @CRLF  & $filesdir & @CRLF &  "doesnt exist! Read the 'readme.txt' file!")
		case not FileExists($swfdir)
			MsgBox (48, "Whoops!", "Looks like the game directory:" & @CRLF  & $swfsdir & @CRLF & "doesnt exist! Make sure you have this folder and it is filled with .swf games!")
		case not FileExists($swfdir & "\*")
			MsgBox (48, "Whoops!", "Looks like the game directory:" & @CRLF  & $swfsdir & @CRLF & "is empty! Make sure your .swf files are located in that folder.")
		case not FileExists ($files & "\flashplayer_10_sa.exe")
			MsgBox (48, "Whoops!", "Looks like you're missing the flash player!:" & @CRLF  & $filesdir & @CRLF & "Make sure the program 'flashplayer_10_sa.exe' is in the above directory or your games won't play.")
		EndSelect
	EndFunc
errorcheck()
	
	