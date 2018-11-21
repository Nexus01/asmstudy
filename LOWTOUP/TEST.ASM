assume cs:code,ds:data
data segment
buf db 0
data ends
code segment
start:  mov ax,data
        mov ds,ax
        mov ah,8h
        int 21h
        and al,11011111b
        mov buf,al
        mov ah,4ch
        int 21h
code ends
end start
