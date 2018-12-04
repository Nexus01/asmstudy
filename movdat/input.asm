assume cs:code,ds:data
data segment
STR1    db 100,0,100 dup (0)
STR2    db 'DKDKKDKDKDKD'
secend   db '$'
COUNT2   equ secend-STR2
data ends
code segment
start:  mov ax,data
        mov ds,ax
        lea dx,STR1
        mov ah,0ah
        int 21h
	mov dl,10 ;光标下移
	mov ah,2
	int 21h 
        lea si,STR1
        mov cl,[si+1]
        mov ch,0
        add si,2
        lea di,STR2
        add si,cx
        add di,cx
        dec si
        dec di
LP1:    mov al,[si]
        mov [di],al
        dec si
        dec di
        dec cx
        jne LP1
        
    
        lea si,secend
        mov al,[si]
        lea si,STR1
        inc si
        mov bl,[si]
        mov bh,0
        inc si
        add si,bx
        mov [si],al;put a end sign in the end of str1
        lea di,STR2
        add di,bx
        mov [di],al;put a end sign in the end of str1 copy
DISP:        
        lea dx,STR1
        add dx,2
        mov ah,9h
        int 21h
	mov dl,10 ;光标下移
	mov ah,2
	int 21H 
        lea dx,STR2
        mov ah,9h
        int 21h
        mov ah,4ch
        int 21h
code ends
end start
