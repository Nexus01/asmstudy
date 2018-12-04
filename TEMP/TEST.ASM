assume cs:code
code segment
start:  mov ax,2
        mov cx,2
LP1:    add ax,ax
        loop LP1
        mov ah,4ch
        int 21h
code ends
end start
