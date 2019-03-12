assume cs:code,ds:data
data segment
data ends
code segment
start:  xor ax,ax
        mov al,8ah
        push ax
        and al,0f0h
        mov cl,4
        ror al,cl
        ;cmp al,0ah
        add al,30h
        cmp al,'9'
        jbe noadd
        add al,7h
noadd:  mov bh,al
        pop ax
        and al,0fh
        ;cmp al,0ah
        add al,30h
        cmp al,'9'
        jbe next
        add al,7h
next:   mov bl,al
        mov ah,4ch
        int 21h
code ends
end start
