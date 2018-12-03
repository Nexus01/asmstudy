assume cs:code,ds:data,ss:stack
data segment
asc db 9,0,8 dup(0)
bin db 4 dup(0)
outbuf db 8 dup(30),'$'
data ends
stack segment
carry dw 3 dup(0)
; 00 00,00 00,00 00
stack ends
code segment
start:  mov ax,data
        mov ds,ax
        mov ax,stack
        mov ss,ax
        sub sp,6
        lea dx,asc
        mov ah,0ah;input the string
        int 21h
        mov dl,10
        mov ah,2
        int 21h
        lea si,asc+2
        lea di,bin
        mov bx,0ah;mult num is 10
        mov ah,0h
        mov dx,0
        mov cx,0
        mov cl,[si-1]
        dec cl;9-1=8

        mov al,[si]
        sub al,30h
lp1:    mul bx;dx storage high 16 bit,ax storage low 16 bit ;low 4 bit
        add al,[si+1]
        sub al,30h
        inc si
        mov carry,ax;storage the low 16bit result
        mov ax,carry+2
        mov carry+4,dx

        mul bx;high 4 bit
        add ax,carry+4
        mov carry+2,ax
        mov ax,carry;get the low 16bit result

        loop lp1
        mov dx,carry+2
        




        mov ah,4ch
        int 21h
code ends
end start
