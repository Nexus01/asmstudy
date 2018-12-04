;比较相邻的元素。如果第一个比第二个大，就交换他们两个。
;对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。这步做完后，最后的元素会是最大的数。
;针对所有的元素重复以上的步骤，除了最后一个。
;持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。
assume cs:code,ds:data
data segment
;ORI	db 12 dup(0)
ORI 	db 12,0,12 dup(0)
; 2 0 1 6 1 0 3 2 0 0 5 7
ORIEND  equ $-ORI;13
THEND db '$'
STOBUF db 3 dup(0);[0] storage [i],[1] storage [i+1],[2] storage temp
OUTBUF  db 12 dup(0),'$'
HAVEX	db 0
data ends
code segment
start:	mov ax,data
	mov ds,ax
	lea dx,ORI
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
	mov cl,ORIEND
	sub cx,2;11
	mov dx,cx
	;inc dx
	lea di,ORI
	;lea si,STOBUF
LP1:xor bx,bx
	mov bl,[di]
	mov bh,[di+1]
	cmp bl,bh
	ja EXCH
	dec dx
FAN:
	inc di
	dec cx
	loop LP1
	cmp dx,0
	jnz EVE
	jmp DONE
EXCH:	mov [di],bh
		mov [di+1],bl
		jmp FAN
		; inc di
		; dec dx
		; jmp LP1
;DONE:
	;mov cx,12
LP2:
	lea si,ORI
	add si,2

DONE:
	lea dx,ORI
	add dx,2
	mov ah,9h
	int 21h

	mov ah,4ch
	int 21h

code ends
end start
