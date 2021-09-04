#include-Once
; ====================================================================================================================================
; Title....................: plink_wrapper
; AutoIt Version...........: 3.3.6.1
; Language.................: English
; Description..............: UDF Functions to Control "plink.exe" allowing intelligent response to text displayed in terminal sessions
; Author...................: Joel Susser (susserj) + _Start_plink_serial(Marcinan Barbarzynca)
; Last Modified............: 04/09/2021
; Status:..................: In Production
; Testing Workstation......; WinXP sp3, win7 32bit (It likely works with other versions of Windows but I cannot confirm this right now )
; Tested Version of Autoit.; Autoit 3.3.6.1


; #FUNCTION# ====================================================================================================================
; Name...........: _Start_plink_serial
; Description ...: open a new plink.exe terminal session
; Author ........: Marcin Przyborowski (Marcinan Barbarzynca)
; Syntax.........: $plink_serial = "COM6"
; Syntax.........: $_plinkhandle=_Start_plink_serial($plink_serial)
; Parameters ....: $_plink_loc is the location of the plink.exe ececutable on you workstation
; Parameters ....: $_plinkserver is the location of the server you wish to access
; Example........: $_plinkhandle = _Start_plink("c:/putty/plink.exe", "testserver.com")
; Return values .: $plinkhandle, pid of cmd processor
; Remarks........; Default plink.exe location is set to @ScriptDir
; Remarks .......: Needs to be made more robust
; -serial \\.\COM9 -sercfg 9600,8,1,N,N
; ===============================================================================================================================

;start the plink serial session
func _Start_plink_serial($_plink_serial_port,$_plink_loc = '"'&@ScriptDir&"\plink.exe"&'"',$bound_rate = 9600, $frame_len = 8, $stop_bits = 1,$n1 = "N", $n2 ="N" )

_Plink_close(); close any stray plink sessions before starting
 ;~  	$_plink_loc=StringTrimLeft($_plink_loc,1)
;~ 	$_plink_loc=StringTrimRight($_plink_loc,1)
if (FileExists(StringReplace($_plink_loc,'"',''))) Then
	ConsoleWrite($_plink_loc&@CRLF)
Else
	MsgBox(0,"Error", "Unable to open plink.exe at:" & $_plink_loc,10)
	return false
 	Exit
	EndIf

if $_plink_loc = "" then
MsgBox(0, "Error", "Unable to open plink.exe",10)
return false
Exit
endif

if $_plink_serial_port = "" then
MsgBox(0, "Error", "Undefined port",10)
Exit
return false
endif

ConsoleWrite("RUN: "&@comspec & " /c " & $_plink_loc & " -serial \\.\" & $_plink_serial_port & " -sercfg "& $bound_rate&","&$frame_len&","&$n1&","&$n2&@CRLF)
$_plinkhandle = Run(@comspec & " /c " & $_plink_loc & " -serial \\.\" & $_plink_serial_port & " -sercfg "& $bound_rate&","&$frame_len&","&$n1&","&$n2 ,"",@SW_HIDE,7)
return $_plinkhandle
endFunc
; ===============================================================================================================================

