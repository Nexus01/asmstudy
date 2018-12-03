assume cs:code,ds:data,ss:stack
data segment
;SID db '201610320057'
SID dw 2016h,1032h,0057h
;20 16 10 32 00 57
;02 01 61 03 20 05 70
COUNT equ $-SID
M db 10h
BCD dw 0000h,0000h,0000h
EED db '$'
data ends
stack segment
SSS db 16 dup(0)
stack ends
code segment
start:  mov ax,data
        mov ds,ax
        mov ax,stack
        mov ss,ax
        mov cx,COUNT
        shr cx,1
        mov di,offset SID
movess:
        mov ax,0
        mov bx,0
        mov bl,[di]
        mov al,[di+1]
        push ax
        push bx
        add di,2
        loop movess
        mov cx,COUNT
        shr cx,1
        mov di,offset EED
        ;sub di,2
movein: 
        pop bx
        mov [di-1],bl
        pop ax
        mov [di-2],al
        sub di,2
        loop movein

LP1:    mov di,offset EED
        mov bl,[di-1]
        mov dx,0
        mov ax,0
        mov al,[di]
        inc di
        push di
        push ax;al=mult2

LP2:    cmp bl,0
        jz zero
        clc
        pop ax
        add al,dl
        daa
        mov dl,al
        ;tiaozheng
        adc al,0
        mov dh,al
        dec bl
        das
        mov bl,al
        loop LP1
zero:   ;display
        
        loop LP2
;         mov cx,COUNT
;         mov di,offset SID
; trans:  mov al,[di]
;         sub al,30h
;         mov [di],al
;         inc di
;         loop trans
;         mov cx,COUNT
;         mov di,offset SID
 
        ; mov dx,offset BCD
        ; mov ah,09h
        ; int 21h
        mov ah,4ch
        int 21h
code ends
end start