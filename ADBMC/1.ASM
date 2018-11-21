assume cs:code,ds:data
data segment
a db ?
b db ?
c db ?
data ends
code segment
start:  mov ax,data
        mov ds,ax
        xor ax,ax
        xor bx,bx
        mov di,offset a
        mov si,offset b
        mov al,byte ptr [di]
        mov bl,byte ptr [si]
       ; add byte ptr [di],byte ptr [si]
        add ax,bx
       ; mov al,byte ptr [di]
        mov di,offset c
        xor cx,cx
        mov cl,byte ptr [di]
        mul cx
        mov ah,4ch
        int 21h
code ends
end start
