;比较相邻的元素。如果第一个比第二个大，就交换他们两个。
;对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。这步做完后，最后的元素会是最大的数。
;针对所有的元素重复以上的步骤，除了最后一个。
;持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。
assume cs:code,ds:data
data segment
;ORI 	db 13,0,13 dup(0)
ORI 	db 100,0,100 dup(0)
; 2 0 1 6 1 0 3 2 0 0 5 7
;ORIEND  equ $-ORI;13
;THEND db '$'
data ends
code segment
start:	mov ax,data
	mov ds,ax
	mov dx,offset ORI
	mov ah,0ah
	int 21h
	mov dl,10
	mov ah,02h
	int 21h
	;bl storage [i]
	;bh storage [i+1]
	;i from 0 to end-1
EVE:
	xor cx,cx
	lea si,ORI
	inc si;real num
	mov cl,[si];cx=12
	dec cx;cx=11
	mov dx,cx
	lea di,ORI
	add di,2
LP1:xor bx,bx
	mov bl,[di]
	mov bh,[di+1]
	cmp bl,bh
	ja EXCH
	dec dx
FAN:inc di
	loop LP1
	cmp dx,0
	jnz EVE
	jmp DONE
EXCH:	mov [di],bh
		mov [di+1],bl
		jmp FAN
DONE:
    lea si,ORI
	inc si
	xor bx,bx
	mov bl,[si]
	add bl,2
	mov byte ptr [si+bx],'$'
	lea dx,ORI
	add dx,2
	mov ah,9h
	int 21h
	mov ah,4ch
	int 21h

code ends
end start
