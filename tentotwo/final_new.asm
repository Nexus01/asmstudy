data segment
asc db 9,0,8 dup(0)
;      9 0 31 32 33 34 35 36 37 38
;count equ $-asc
; carry1 dw 0
; carry2 dw 0
; carry3 dw 0
bin db 4 dup(?)
outbuf db 8 dup(30),'$'
data ends
stack segment
carry dw 3 dup(0)
stack ends
code    segment
		assume cs:code,ds:data,ss:stack
start:  mov ax,data
		mov ds,ax
		mov ax,stack
		mov ss,ax
		mov sp,0
		lea dx,asc
		mov ah,0ah
		int 21h
		mov dl,10
		mov ah,2
		int 21h
		lea si,asc
		add si,2
		lea di,bin
		mov bx,000ah
		xor dx,dx
		xor cx,cx
		mov cl,[si-1]
		sub cl,1
		mov ah,00h
		mov al,[si]
		sub al,30h
lp1:	mul bx
		; add al,[si+01]
		; sub al,30h
		; inc si
		; mov carry1,ax 
		; mov ax,carry2
		; mov carry3,dx
		; mul bx
		; add ax,carry3
		; mov carry2,ax
		; mov ax,carry1
		; loop lp1
		; mov dx,carry2

		add al,[si+1]
        sub al,30h
        inc si
        push ax
        mov sp,2
        pop ax
        mov sp,4
        push dx

        mul bx
        pop dx
        add ax,dx
        mov sp,2
        push ax
        mov sp,0
        pop ax

        loop lp1
		mov sp,2
		pop dx
		mov [di],ax
        add di,02h
		mov [di],dx
		mov cx,4
		lea di,outbuf
		add di,6
		lea si,bin
lp2:    mov al,[si]
		mov ah,al
		mov bx,cx
		mov cl,4
		ror al,cl
		mov cx,bx
		and ah,0fh
		and al,0fh
		add al,30h
		cmp al,39h;
		jbe hex1;al<=39h
		add al,07h;A<=al<=F
hex1:	add ah,30h
		cmp ah,39h
		jbe hex2
		add ah,07h
hex2:	mov [di],ax
		sub di,2
		inc si
		loop lp2
		lea dx,outbuf
		mov ah,9
		int 21h
		mov ah,4ch
		int 21h	
code ends
end start
