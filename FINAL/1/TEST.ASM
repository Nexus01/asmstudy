data segment
org 0100h
DEST DB 'GOOD AFTERNOON'
STRLEN DW $-DEST
data ends
code segment
assume cs:code,ds:data;,es:extra
start:  mov ax,data
        mov ds,ax
        mov es,ax
        cld
        mov al,'R'
        lea di,DEST
        mov cx,STRLEN
again:  scasb
        jz next
        dec cx
        jnz again
        mov bx,0
        jmp done
next:   dec di
        mov bx,di
done:   mov ah,4ch
        int 21h
code ends
end start
