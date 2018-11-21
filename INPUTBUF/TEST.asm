assume cs:code,ds:data
data segment
INPUTBUF        DB 21,?,21 DUP(?)
data ends
code segment
start:  mov ax,data
        mov ds,ax
;        mov ax,code
;        mov ds,ax
        mov dx,offset INPUTBUF
        mov ah,0ah
        int 21h
        mov ah,4ch
        int 21h
code ends
end start
