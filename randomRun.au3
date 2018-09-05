;******************************************************************
; Zgoda Rafal
;------------------------------------------------------------------

$spotifyURI = "spotify:user:uq60z0x11at13v44sormagxn0:playlist:1O6ESWV9THN8Y7W5LPoyqB"
;******************************************************************
Opt("WinTitleMatchMode",-2)
Const $SpotifyWindowIdentifier = "[Title:Spotify Premium]"

While 1
	RandomReboot()
	Sleep(Random(0,1)*1000*60*60)
WEnd

Func RandomReboot()
	$rndReb = Random(0,1)
	echo($rndReb)
	If($rndReb > 0.85) Then
		 ProcessClose("Spotify.exe")
	Else
		 PlaySpotifyPlaylist($spotifyURI)
	EndIf
EndFunc

Func PlaySpotifyPlaylist($spotifyURI,$retry = 0)

	ProcessClose("Spotify.exe")
    ShellExecute($spotifyURI)
    If Not WinExists($SpotifyWindowIdentifier) Then
        echo ("Pausing existing song (To find spotify window)")
        $timer = TimerInit()
        While Not WinExists($SpotifyWindowIdentifier)
            Send("{MEDIA_PLAY_PAUSE}")
            Sleep(50000)
            If TimerDiff($timer) > 5 * 1000 Then ErrorMsg ("Timed out trying pause existing song")
        WEnd
    endif

    $hwndSpotify = WinGetHandle($SpotifyWindowIdentifier)

    echo ("Attempting to play playlist")

    $timer = TimerInit()
	Sleep(10000)

	ControlSend($hwndSpotify,"","","+{TAB 2}")
	Sleep(Random(0,1)*500)
	echo ("1")
	For $i = 1 To 7 Step 1
		ControlSend($hwndSpotify,"","","+{down}")
		Sleep(Random(0,1)*3000)
		echo($i)
	Next
	ControlSend($hwndSpotify,"","","{ENTER}")
EndFunc

Func echo($text)
    ConsoleWrite ($text&@CRLF)
EndFunc

Func ErrorMsg($text)
    MsgBox(16,StringTrimRight(@ScriptName,4),$text)
    Exit
EndFunc



