#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.8.1
 Author:         myName

 Script Function:
	Template AutoIt script.
	
	http://freegames.org/super-weird-invaders/
    http://media.freegames.org/swf/super-weird-invaders.swf
#ce ----------------------------------------------------------------------------
$where = InputBox("", "enter URL")
$name = StringTrimLeft($where, 21)
$name2 = StringTrimRight($name, 1)
$get = "http://media.freegames.org/swf/" + $name2  + ".swf"
MsgBox(1, "", $name2 & @CRLF & "  http://media.freegames.org/swf/" & $name2  & ".swf     "& @CRLF & @scriptdir & "\" & $name)
InetGet("http://media.freegames.org/swf/" & $name2  & ".swf", @scriptdir & "\" & $name2 & ".swf")



