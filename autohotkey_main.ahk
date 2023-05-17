/*
Hotkeys:
Ctrl-space: toggle window always on top

Win-U: little ustream window

0: autorun in Arma

*/



#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
^SPACE::  
Winset, Region, , A
Winset, Alwaysontop, , A
return

#U::  
Winmove A,, 1200, 0, 400, 600
Winset, Region, 0-140 W400 H300 , A
Winset, Alwaysontop, , A
return



#IfWinActive, Arma 3
{
  #MaxThreadsPerHotkey 2

  0::
  arma3AutoRun := !arma3Autorun  
  if (arma3AutoRun) {
    send {LShift down}
    send {w down}
    sleep 60000
    send {LShift up}
    send {w up}
  } else {
    send {LShift up}
    send {w up}
  }

  return
}




#IfWinActive, 7 Days To Die
{
  #MaxThreadsPerHotkey 2

  0::
  arma3AutoRun := !arma3Autorun  
  if (arma3AutoRun) {
    send {LShift down}
    send {w down}
    sleep 60000
    send {LShift up}
    send {w up}
  } else {
    send {LShift up}
    send {w up}
  }

  return
}



