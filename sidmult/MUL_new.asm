data 	segment
asc db 13,0,12 dup(0)
dat 	db 6 dup(0)
datnum 	db 0
mulnum2	db 10h
carry   db 0
result 	db 7 dup(0) 
outbuf db 14 dup(30),'$'
data 	ends
stack 	segment stack
		dw 100 dup (?) 
top 	label word
stack 	ends
code 	segment
assume 	cs:code,ds:data,ss:stack
start: 	mov ax,data
		mov ds,ax
		mov ax,stack
		mov ss, ax
		mov sp,offset top
		lea dx,asc ;键盘输入
		mov ah,0ah
		int 21h
		mov dl,10 ;光标下移
		mov ah,2
		int 21h 
		call tran
		lea si,dat
		lea di,result
		xor cx,cx
		mov cl,datnum
		add si,cx
		dec si
		add di,cx
lp1:	call dmulbll
		dec di
		dec si
		loop lp1
		mov bl,carry
		mov [di],bl
		call output
		mov ah,4ch
		int 21h
		
dmulbll  proc near
		push ax
		push dx
		push cx
		mov bl,[si]
		xor dx,dx
		add dl,carry
lp2:	clc
		add dl,mulnum2
		mov al,dl
		daa
		mov dl,al
		adc dh,0
		dec bl
		mov al,bl
		das
		mov bl,al
		cmp bl,0
		ja lp2
		mov [di],dl
		mov carry,dh
		pop cx
		pop dx
		pop ax
		ret
dmulbll	endp

tran  proc near
		push ax
		push dx
		push cx
		lea si,asc
		inc si
		xor cx,cx
		mov cl,[si]
		mov dl,datnum
		inc si
		lea di,dat
llpp1:	mov ax,[si]
		dec cl
		sub al,30h
		sub ah,30h
		mov bh,ah
		mov bl,10h
		mul bl
		add al,bh
		mov [di],al
		add si,2
		inc di
		inc dx
		loop llpp1
		mov datnum,dl
		pop cx
		pop dx
		pop ax
		ret
tran	endp


output  proc near
		push ax
		push dx
		push cx
		mov cx,7
		lea di,outbuf
		lea si,result
llpp:	mov al,[si]
		mov ah,al
		mov bx,cx
		mov cl,4
		ror al,cl
		mov cx,bx
		and ah,0fh
		and al,0fh
		add al,30h
		cmp al,39h
		jbe hex1
		add al,07h
hex1:	add ah,30h
		cmp ah,39h
		jbe hex2
		add ah,07h
hex2:	mov [di],ax
		add di,2
		inc si
		loop llpp
		lea dx,outbuf
		mov ah,9
		int 21h
		pop cx
		pop dx
		pop ax
		ret
output	endp		
		
code 	ends
end 	start
