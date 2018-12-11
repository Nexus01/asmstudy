assume cs:code,ds:data
data segment
BUF db 20 dup(0)
TIP db 'please input N for calculating the factor of N','$'
N   db 6,0,6 dup(0)
BIN db 2 dup(0)
LEN dw 0
OUTBUF db 20 dup(0),'$'
data ends
code segment
start:  mov ax,data
        mov ds,ax 
        call BRANCH
        mov ah,4ch
        int 21h
BRANCH: lea dx,TIP
        mov ah,09h
        int 21h
        mov dl,10
        mov ah,2
        int 21h
        lea dx,N
        mov ah,0ah
        int 21h
        mov dl,10
        mov ah,2
        int 21h
        lea di,N
        inc di
        xor bx,bx
        mov bl,[di]
        mov byte ptr [di+1+bx],0
        call TTT
        ;lea di,BIN
        mov bp,[di]
        cmp bp,1
        lea si,BUF
        jbe ONE
        call CALN
DISP:   ;lea si,N ;ten to two(hex)
;         inc si
;         xor bx,bx
;         mov bl,[si]
        lea di,BUF

        ;mov byte ptr [di+bx],'$'
        lea dx,OUTBUF
        mov ah,09h
        int 21h
FIN:    ret

TTT:    lea si,N ;ten to two(hex)
        inc si
        xor cx,cx
        mov cl,[si]
        dec cx
        inc si
        lea di,BIN
        mov bx,000ah
        ;mov cx,count-1
        mov ah,0h
        mov al,[si]
        sub al,30h
        mov dl,[si+1]
        cmp dl,0
        je BAC
    lp1:imul bx
        add al,[si+1]
        add al,dl
        sub al,30h
        inc si
        loop lp1
    BAC:mov [di],ax
        ret

ONE:    mov byte ptr [si],'1'
        jmp DISP
CALN:   lea di,BUF
        mov [di],bp
BADX:
        dec bp
        cmp bp,1
        je DISP
        clc
        xor bx,bx
        mov cx,LEN
MULL:   mov ax,bp
        mul word ptr [si+bp]
        adc ax,0
        jc ADDH;judge CF
BADDH:  mov word ptr [si+bp],ax
        sal dx,1
        inc si
        loop MULL
        cmp dx,0
        je BADX
        mov ax,LEN
        inc ax
        mov LEN,ax
        mov word ptr [si+bx],dx
        jmp BADX
ADDH:   inc dx
        jmp BADDH
code ends
end start
