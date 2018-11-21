assume ds:data,cs:code,ss:stack
;es:video
data segment
        db 'welcome to masm!'
        db 2h,24h,71h
data ends
stack segment
        dw 8 dup (0)
stack ends
code segment
        start:mov ax,data
              mov ds,ax
              mov ax,stack
              mov ss,ax
              mov ax,0B800h
              mov es,ax

code ends
end start
