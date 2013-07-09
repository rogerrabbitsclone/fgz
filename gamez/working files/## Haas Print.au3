#cs
REQUIREMENTS:
1. there must be a folder on the desktop named "haasprint" and 
inside there must be a folder with students name & card in PDF named "BC - HAAS.pdf"

2. must have a pdf in this location: \\bserver\DTP\AA - Use this for sample\UC BUS CARD\1-10 UCB Seals\do not throw away or move.pdf

3. this was written on a T3500 with 64bit win7, and will probably only work on such. 

compiled 09-29-2011
#CE

#include <File.au3>
#include <Array.au3>
MsgBox ("", "Printing Checklist", "READ THE FOLLOWING BEFORE YOU CONTINUE" & @lf & @lf & "1. Make sure you have Haas business card paper loaded in tray 5 of the Doc 242." & @lf & "2. The paper type must be set as 8.5x11 Heavyweight 3 side 2" & @lf & "3. You must enter THE QUANTITY you want printed, NOT THE AMOUNT OF CARDS."  & @lf & "example: " & @lf & "For 250 cards, you need to enter 25 when prompted for quantity." & @lf & @lf & "To stop this program anytime, press Ctrl+Alt+Delete and kill the ""Hass Print.exe"" process. ")



ShellExecute ("\\bserver\DTP\DTP Store\AA - Use this for sample\UC BUS CARD\1-10 UCB Seals\do not throw away or move.pdf")
;-----------------------------------------------set printer, scaling etc
WinWaitActive ("[CLASS:AcrobatSDIWindow]")
;open print dialog
send ("{ctrldown}")
send ("p")
send ("{ctrlup}")
WinWaitActive ("Print")
send ("!n")
send ("colo")
send ("{down}")
;set tray 5
send ("!s")
WinWaitActive ("Page Setup")
send ("!s")
send ("{down}")
send ("{down}")
send ("{down}")
send ("{down}")
send ("{down}")
send ("{down}")
sleep (300)
send ("{enter}")
;set scaling
WinWaitActive ("Print")
send ("!c")
send ("{tab}")
send ("{up}")
send ("{up}")
send ("{up}")
send ("{up}")
send ("{up}")
send ("{up}")
send ("{up}")
send ("{up}")
send ("{up}")
send ("{up}")
sleep (300)
send ("{enter}")


;---------------------------------------------

Local $folders = _FileListToArray(@DesktopDir & "\haasprint\", "*", 2);$folders is equal to all the folders in "haasprint"
Local $printinput[$folders[0] + 1] ;not quite sure what this does

For $I = 1 To $folders[0] ;create variable $I, its value will be 1 to the end of $folders array
    $printinput[$I] = InputBox("Quantity Check", "How many cards for" & @CRLF & '"' & $folders[$I] & '"')
	;ABOVE /\ associate the elements in $folders with the elements in $printinput 
Next

;-------------------------------------------start printing loop
For $s = 1 To $folders[0];create variable $s, its value will be 1 to the end of $folders array
	;are these single letter variables ($s and $I) only good in the loop in which they are used?
    ShellExecute(@DesktopDir & "\haasprint\" & $folders[$s] & "\BC - HAAS.pdf");open all the folders in the array $folders
   WinWaitActive ("BC - HAAS.pdf - Adobe Acrobat Pro")
   ;open quite imposing & play 10 up 
   send ("!p")
	send ("{right}")
	send ("{enter}")
	sleep (300)
if WinActive ("Sequences - define and use automation") then 
	mouseclick ("left", 813, 461)
	send ("{up}")
	send ("{up}")
	send ("{up}")
	send ("{up}")
	send ("{up}")
	send ("{up}")
	send ("{enter}")
	mouseclick ("left", 545, 678)
ElseIf WinActive ("Quite Imposing Plus - control panel") then
	mouseclick ("left", 556, 365)
	sleep (300)
	mouseclick ("left", 813, 461)
	send ("{up}")
	send ("{up}")
	send ("{up}")
	send ("{up}")
	send ("{up}")
	send ("{up}")
	send ("{enter}")
	mouseclick ("left", 545, 678)
EndIf
   WinWaitActive ("[CLASS:AcrobatSDIWindow]")
    Send("^p")
    WinWaitActive("Print")
    Sleep(200);I usualy find a delay is needed in certain places like this ....
    Send("!c")
    Send($printinput[$s]); send the values from $printinput, in the same order you are opening the values from $folders
	send ("{enter}")
Next
send ("{enter}")
sleep (5000)
ProcessClose ("acrobat.exe")

