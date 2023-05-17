#InstallKeybdHook
#SingleInstance force
/*
Hotkeys:
CTRL-ALT-T: make window always on top

CTRL-ALT-W: make window less transparent
CTRL-ALT-S: make window more transparent

CTRL-ALT-X: make window clickthoughable
CTRL-ALT-Z: make window under mouse unclickthroughable
*/

^!t::
WinGet, currentWindow, ID, A
WinGet, ExStyle, ExStyle, ahk_id %currentWindow%
if (ExStyle & 0x8)  ; 0x8 is WS_EX_TOPMOST.
{
	Winset, AlwaysOnTop, off, ahk_id %currentWindow%
	SplashImage,, x0 y0 b fs12, OFF always on top.
	Sleep, 1500
	SplashImage, Off
}
else
{
	WinSet, AlwaysOnTop, on, ahk_id %currentWindow%
	SplashImage,,x0 y0 b fs12, ON always on top.
	Sleep, 1500
	SplashImage, Off
}
return

^!w::
WinGet, currentWindow, ID, A
if not (%currentWindow%)
{
	%currentWindow% := 255
}
if (%currentWindow% != 255)
{
	%currentWindow% += 5
	WinSet, Transparent, % %currentWindow%, ahk_id %currentWindow%
}
SplashImage,,w100 x0 y0 b fs12, % %currentWindow%
SetTimer, TurnOffSI, 1000, On
Return

^!s::
SplashImage, Off
WinGet, currentWindow, ID, A
if not (%currentWindow%)
{
	%currentWindow% := 255
}
if (%currentWindow% != 5)
{
	%currentWindow% -= 5
	WinSet, Transparent, % %currentWindow%, ahk_id %currentWindow%
}
SplashImage,, w100 x0 y0 b fs12, % %currentWindow%
SetTimer, TurnOffSI, 1000, On
Return

^!x::
WinGet, currentWindow, ID, A
WinSet, ExStyle, +0x80020, ahk_id %currentWindow%
return

^!z::
MouseGetPos,,, MouseWin ; Gets the unique ID of the window under the mouse
WinSet, ExStyle, -0x80020, ahk_id %currentWindow%
Return

TurnOffSI:
SplashImage, off
SetTimer, TurnOffSI, 1000, Off
Return
