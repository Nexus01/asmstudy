assume cs:code,ds:data
data segment
Bmult      db     '45','$';定义十进制相乘左操作数
mult     db     '23','$';定义十进制相乘右操作数
;Bleft     dw      0;
;Bright    dw      0;
result    db      0;
c10       dw     10;十进制进位数
output db 8 dup(0),'$'
data ends
code segment
start:  mov ax,data
        mov ds,ax
        xor cx,cx
        mov bl,mult
HEX:    push cx
        mov cl,4
        rol al,cl
        pop cx;mov bl,ax
        and bl,0fh
        add bl,30h
        cmp bl,3ah
        jl HEX2
        add bl,7h
HEX2:   mov dl,bl
        mov ah,2
        int 21h
        dec ch
        jnz HEX

        lea si,Bmult
        lea di,result
        mov cx,4
LP1:    mov al,[si]
        mul bl
        aam
        mov [di],ax
        inc di

        loop LP1
        lea dx,output
        mov ah,9h
        int 21h
CODE ENDS
END START
