;******************************************************************
; Zgoda Rafal
;******************************************************************

$spotifyURI = "spotify:user:uq60z0x11at13v44sormagxn0:playlist:1O6ESWV9THN8Y7W5LPoyqB"
Const $SpotifyWindowIdentifier = "[Title:Spotify]"

$DeezerURI = "deezer://www.deezer.com/playlist/4856499964?autoplay=true"
Const $DeezerWindowIdentifier = "[Title:Deezer]"

While 1
	RandomRebootSpotify()
	RandomRebootDeezer()
	Sleep(Random(0,1)*1000*60*10)
WEnd


Func RandomRebootSpotify()
	$rndReb = Random(0,1)
	echo($rndReb)
	If($rndReb > 0.85) Then
		 ProcessClose("Spotify.exe")
	Else
		PlaySpotifyPlaylist($spotifyURI)
	EndIf
EndFunc

Func RandomRebootDeezer()
	$rndReb = Random(0,1)
	echo($rndReb)
	If($rndReb > 0.85) Then
		 ProcessClose("Deezer")
	Else
		PlayDeezerPlaylist($DeezerURI)
	EndIf
EndFunc

Func PlaySpotifyPlaylist($spotifyURI,$retry = 0)
	ProcessClose("Spotify.exe")
    ShellExecute($spotifyURI)
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
	LaunchPlaylist()
EndFunc


Func PlayDeezerPlaylist($DeezerURI,$retry = 0)
	ProcessClose("Deezer.exe")
    ShellExecute($DeezerURI)
	Opt("WinTitleMatchMode", 2)

    If Not WinExists($DeezerWindowIdentifier) Then
        echo ("Pausing existing song (To find Deezer window)")
        $timer = TimerInit()
        While Not WinExists($DeezerWindowIdentifier)
            Sleep(500)
            If TimerDiff($timer) > 5 * 1000 Then ErrorMsg ("Timed out trying pause existing song")
        WEnd
    endif
    $hwndDeezer = WinGetHandle($DeezerWindowIdentifier)
EndFunc

Func LaunchPlaylist()
	echo ("Attempting to play playlist")
    $timer = TimerInit()
	Sleep(5000)
	;ControlSend($hwndSpotify,"","","+{TAB}")
	Sleep(Random(0,1)*500)
	For $i = 1 To 10 Step 1
		;ControlSend($hwndSpotify,"","","+{down}")
		Send("{TAB}")
		Sleep(Random(0,1)*500)
		echo($i)
	Next
	Send("{ENTER}")
	;ControlSend($hwndSpotify,"","","{ENTER}")
EndFunc


Func echo($text)
    ConsoleWrite ($text&@CRLF)
EndFunc

Func ErrorMsg($text)
    MsgBox(16,StringTrimRight(@ScriptName,4),$text)
    Exit
EndFunc
