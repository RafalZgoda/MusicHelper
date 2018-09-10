#include <MsgBoxConstants.au3>

activateSound()
dowloadSpotify()


Func dowloadSpotify($text)

	$spotifyDownloadLink = "https://download.scdn.co/SpotifySetup.exe"
	$spotifyPathLink = @HomeDrive & @HomePath & "\Downloads\SpotifySetup.exe"

	Const $SaveWindowIdentifier = "[Title:Enregistrer sous]"
	Const $ChromeWindowIdentifier = "[Title:Google Chrome]"
	Const $InstallWindowIdentifier = "[Title:Fichier]"

	Opt("WinTitleMatchMode", 2)
	Opt("SendKeyDownDelay", Random(0,1)*1000+100)

	ShellExecute($spotifyDownloadLink)

	If Not WinExists($SaveWindowIdentifier) Then
		$timer = TimerInit()
		While Not WinExists($SaveWindowIdentifier)
			Sleep(500)
			If TimerDiff($timer) > 5 * 1000 Then ErrorMsg ("Timed out trying find Save Windows")
		WEnd
	endif
	$hwndSave = WinGetHandle($SaveWindowIdentifier)

	ControlSend($hwndSave,"","","+{ENTER}")
	echo("SAVE")

	If Not WinExists($ChromeWindowIdentifier) Then
		$timer = TimerInit()
		While Not WinExists($ChromeWindowIdentifier)
			Sleep(500)
			If TimerDiff($timer) > 5 * 1000 Then ErrorMsg ("Timed out trying find Chrome")
		WEnd
	endif
	$hwndChrome = WinGetHandle($ChromeWindowIdentifier)

	Sleep(3000)
	EnvSet("SEE_MASK_NOZONECHECKS","1")

	ShellExecute($spotifyPathLink)

	Sleep(2000)

	; Your script here
	EnvSet("SEE_MASK_NOZONECHECKS","0")

EndFunc


Func activateSound($text)
	Opt("SendKeyDownDelay", 1000)
	Send('#')
	Send("son")
	Send("{ENTER}")
	Send("{ENTER}")
EndFunc


;Send("e")

Func echo($text)
    ConsoleWrite ($text&@CRLF)
EndFunc

Func ErrorMsg($text)
    MsgBox(16,StringTrimRight(@ScriptName,4),$text)
    Exit
EndFunc
