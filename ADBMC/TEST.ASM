assume cs:code,ds:data
data segment
a db 0ffh
b db 0ffh
c db 0ffh
data ends
code segment
start:  mov ax,data
        mov ds,ax
        xor ax,ax
        xor bx,bx
;        mov di,offset a
;        mov si,offset b
        mov al,a;byte ptr [di]
        mov bl,b;byte ptr [si]
       ; add byte ptr [di],byte ptr [si]
        add ax,bx
       ; mov al,byte ptr [di]
        ;mov di,offset c
        xor cx,cx
        mov cl,c;byte ptr [di]
        mul cx
        mov ah,4ch
        int 21h
code ends
end start
