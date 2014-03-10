; Original from https://gist.github.com/davejamesmiller/1965854
; Edited by Jeremy Betz to use left win + L to turn off monitor with windows lock

; Win+\ (Just turn monitor off)
#\::
    Sleep 1000
	SendMessage 0x112, 0xF140, 0, , Program Manager  ; Start screensaver
    SendMessage 0x112, 0xF170, 2, , Program Manager  ; Monitor off
    Return

; Left Win+L (Lock and turn monitor off)
<#L::
    Run rundll32.exe user32.dll`,LockWorkStation     ; Lock PC
    Sleep 1000
    SendMessage 0x112, 0xF170, 2, , Program Manager  ; Monitor off
    Return
