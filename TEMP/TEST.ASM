assume cs:code,ds:data
data segment
PP dw 0,-39,0
data ends
code segment
start:  mov ax,data
        mov ds,ax
        mov ax,2
        mov cx,2
LP1:    add ax,ax
        loop LP1
        mov ah,4ch
        int 21h
code ends
end start
