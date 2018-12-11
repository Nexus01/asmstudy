data segment
asc db '12345'
;count equ $-asc
bin db 2 dup(?)
count equ 5
data ends
code segment
assume cs:code,ds:data
start: mov ax,data
        mov ds,ax
        lea si,asc
        lea di,bin
        mov bx,000ah
        mov cx,count-1
        mov ah,0h
        ;mov dx,0
        mov al,[si]
        sub al,30h
lp1:    imul bx
        add al,[si+1]
        sub al,30h
        inc si
        loop lp1
        mov [di],ax
 ;       mov cx,4
;lp2:    sub dx,30h
        ;mov [di+2],dx
        mov ah,4ch
        int 21h
code ends       
end start
