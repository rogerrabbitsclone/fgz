#cs ----------------------------------------------------------------------------

company
name
streetaddress
citystatezip
phone1
phone2
fax
email
----------------
recieved (default to today)
due (default to 2 days)
inv
PO
chartstring
ccaccount
tby (taken by)
-----------------------------------------------------
$companyin
$namein
$streetaddressin
$citystatezipin
$phone1in
$phone2in
$faxin
$emailin
$recievedin
$duein
$invin
$poin
$chartstringin
$ccaccountin
$tbyin

#ce ----------------------------------------------------------------------------
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
ShellExecute("C:\Program Files (x86)\Adobe\Adobe InDesign CS6\InDesign.exe")
Func GUIforinvoice()
	$gui = GUICreate("Create New Invoice", 747, 300)

	$companyin = GUICtrlCreateInput("", 10, 30, 220, 20);FIRST
	$company = GUICtrlCreateLabel("Company", 10, 10, 136, 15)

	$namein = GUICtrlCreateInput("", 240, 30, 220, 20);SECOND
	$name = GUICtrlCreateLabel("Name", 240, 10, 136, 20)

	$streetaddressin = GUICtrlCreateInput("", 470, 30, 220, 20);THIRD
	$streetaddress = GUICtrlCreateLabel("Street address", 470, 10, 136, 20)

	$citystatezipin = GUICtrlCreateInput("", 10, 80, 220, 20);FIRST
	$citystatezip = GUICtrlCreateLabel("City, State, ZIP", 10, 60, 136, 20)

	$phone1in = GUICtrlCreateInput("", 240, 80, 220, 20);SECOND
	$phone1 = GUICtrlCreateLabel("Work Phone", 240, 60, 136, 20)

	$phone2in = GUICtrlCreateInput("", 470, 80, 220, 20);THIRD
	$phone2 = GUICtrlCreateLabel("Personal Phone", 470, 60, 136, 20)

	$faxin = GUICtrlCreateInput("", 10, 130, 220, 20);FIRST
	$fax = GUICtrlCreateLabel("Fax", 10, 110, 136, 20)

	$emailin = GUICtrlCreateInput("", 240, 130, 220, 20);SECOND
	$email = GUICtrlCreateLabel("Email", 240, 110, 136, 20)

	$recievedin = GUICtrlCreateInput(@MON & " - " & @MDAY &" - "&  @YEAR, 470, 130, 220, 20);THIRD
	$recieved = GUICtrlCreateLabel("Recieved Date", 470, 110, 136, 20)

	$duein = GUICtrlCreateInput("", 10, 180, 220, 20);FIRST
	$due = GUICtrlCreateLabel("Due Date", 10, 160, 136, 20)

	;$invin = GUICtrlCreateLabel("If you cancel the invoice, manually rollback invoice number.", 240, 180, 240, 20);SECOND
	;$inv = GUICtrlCreateLabel("Invoice number will be generated automatically.", 240, 160, 240, 20)

	$poin = GUICtrlCreateInput("", 470, 180, 220, 20);THIRD
	$po = GUICtrlCreateLabel("Customer PO#", 470, 160, 136, 20)

	$chartstringin = GUICtrlCreateInput("",10, 230, 220, 20);FIRST
	$chartstring = GUICtrlCreateLabel("Chartstring", 10, 210, 136, 20)

	$ccaccountin = GUICtrlCreateInput("", 240, 230, 220, 20);SECOND
	$ccaccount = GUICtrlCreateLabel("CC Account Number", 240, 210, 136, 20)

	$tbyin = GUICtrlCreateInput("", 470, 230, 220, 20)
	$tby = GUICtrlCreateLabel("Taken By", 470, 210, 136, 20)


	$ok=GUICtrlCreateButton("CREATE",8.5,260,730,30)
	GUISetState()
	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = $GUI_EVENT_CLOSE
				Exit
			Case $msg = $ok
				
				ExitLoop
		EndSelect
	WEnd
	
	
	
	local $return[15]
	$return[0] =  GUICtrlRead($companyin)
	$return[1] =  GUICtrlRead($namein)
	$return[2] =  GUICtrlRead($streetaddressin)
	$return[3] =  GUICtrlRead($citystatezipin)
	$return[4] =  GUICtrlRead($phone1in)
	$return[5] =  GUICtrlRead($phone2in)
	$return[6] =  GUICtrlRead($faxin)
	$return[7] =  GUICtrlRead($emailin)
	$return[8] =  GUICtrlRead($recievedin)
	$return[9] =  GUICtrlRead($duein)
	$return[10] =  GUICtrlRead("NOTGENERATED")
	$return[11] =  GUICtrlRead($poin)
	$return[12] =  GUICtrlRead($chartstringin)
	$return[13] =  GUICtrlRead($ccaccountin)
	$return[14] =  GUICtrlRead($tbyin)
	return $return
	
endfunc

local $invoiceinfo = GUIforinvoice()
if Not fileexists(@scriptdir & "\data\invoice#.txt") Then
	msgbox(48, "ATTENTION", "Invoice tracking file cannot be found. The program will now exit and this invoice will be terminated. To fix this read the 'readme.txt' file in the install directory."& @CRLF & @ScriptDir & "\READ ME.txt")
	Exit
endif
$filelocation = @scriptdir & "\data\invoice#.txt"
$file = fileopen($filelocation, 0)
$invoicenumber = FileRead($file)
fileclose($file)
if $invoicenumber = 30343571 Then
	FileDelete(@scriptdir & "\data\invoice#.txt")
	msgbox(48, "ATTENTION", "There are no more avaliable invoice numbers left. The program will now exit and this invoice will be terminated. ")
	Exit
endif
$invoiceinfo[10] = $invoicenumber
$invoicenumber = $invoicenumber + 1
fileopen($filelocation, 2)
FileWrite($file, $invoicenumber)
fileclose($file)
MsgBox(1, "Invoice Number", "Invoice Number " &$invoiceinfo[11]& " has been created", 2000)

winactivate ("[CLASS:indesign]")
winwaitactive ("[CLASS:indesign]")
shellexecute (@ScriptDir & "\data\invoice project.indd")
winwaitactive("invoice project.indd @ 125%")
sleep (5)
send ("^f")
winwaitactive ("[CLASS:InDesign_Window:5660125]")
sleep(500)
func findandreplace($find, $replace)
	send("!f")
	send($find)
	if winactive("Adobe InDesign", "Cannot find match.") Then
		send("{ENTER}")
	else	
		send ("!c")
		send("{BACKSPACE}")
		send($replace)
		send("!n")
		send("!h")
		sleep(500)
	endif
EndFunc
findandreplace("<<company>>", $invoiceinfo[0])
findandreplace("<<name>>", $invoiceinfo[1])
findandreplace("<<streetaddress>>", $invoiceinfo[2])
findandreplace("<<citystatezip>>", $invoiceinfo[3])
findandreplace("<<phone1>>", $invoiceinfo[4])
findandreplace("<<phone2>>", $invoiceinfo[5])
findandreplace("<<fax>>", $invoiceinfo[6])
findandreplace("<<email>>", $invoiceinfo[7])
findandreplace("<<recieved>>", $invoiceinfo[8])
findandreplace("<<due>>", $invoiceinfo[9])
findandreplace("<<inv>>", $invoiceinfo[10])
findandreplace("<<PO>>", $invoiceinfo[11])
findandreplace("<<chartstring>>", $invoiceinfo[12])
findandreplace("<<CCaccount>>", $invoiceinfo[13])
findandreplace("<<tby>>", $invoiceinfo[14])
sleep(500)
send ("!d")
msgbox(1, "Quality Check", "Please double check the customers information")

send("^p")
sleep(2000)
send("{ENTER}")