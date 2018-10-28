;******************************************************************
; Zgoda Rafal
;******************************************************************

$spotifyURI = "https://open.spotify.com/playlist/1O6ESWV9THN8Y7W5LPoyqB"
Const $SpotifyWindowIdentifier = "[Title:Chrome]"

While 1
	RandomRebootSpotify()
	Sleep(Random(0,1)*1000*60*240+60000)
WEnd


Func RandomRebootSpotify()
	$rndReb = Random(0,1)
	echo($rndReb)
	If($rndReb > 0.85) Then
		ProcessClose("chrome.exe")
	Else
		PlaySpotifyPlaylist($spotifyURI)
	EndIf
EndFunc

Func PlaySpotifyPlaylist($spotifyURI,$retry = 0)
	ProcessClose("chrome.exe")
	ShellExecute("chrome.exe", "https://open.spotify.com/playlist/1O6ESWV9THN8Y7W5LPoyqB --new-window")

	Opt("WinTitleMatchMode", 2)
	    If Not WinExists($SpotifyWindowIdentifier) Then
        echo ("Pausing existing song (To find spotify window)")
        $timer = TimerInit()
        While Not WinExists($SpotifyWindowIdentifier)
            Sleep(500)
            If TimerDiff($timer) > 5 * 1000 Then ErrorMsg ("Timed out trying pause existing song")
        WEnd
    endif
    $hwndSpotify = WinGetHandle($SpotifyWindowIdentifier)
	Sleep(20000)
	ControlSend($hwndSpotify,"","","{SPACE}")

EndFunc


Func echo($text)
    ConsoleWrite ($text&@CRLF)
EndFunc

Func ErrorMsg($text)
    MsgBox(16,StringTrimRight(@ScriptName,4),$text)
    Exit
EndFunc