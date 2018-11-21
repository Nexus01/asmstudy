; xor dest,11111111b   can get the oppo of the dest
assume cs:code,ds:data
data segment
X db 218
data ends
code segment
start:  mov ax,data
        mov ds,ax
        mov di,offset X
        mov al,byte ptr [di]
        push ax
        shl al,1
        jc nega
post:   jmp last
nega:   pop ax
        xor al,11111111b
        inc al
        and al,01111111b
;        mov bl,11111111b
;        sub bl,al
        mov byte ptr [di],al
        jmp last
last:   mov ah,4ch
        int 21h
code ends
end start
