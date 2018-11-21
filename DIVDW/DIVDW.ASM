ASSUME CS:CODE,DS:DATA,SS:STACK
DATA SEGMENT
BEDIV   dd 000F4240h
DIVNUM  dw 0Ah
DATA ENDS
STACK SEGMENT
db 8 dup (0)
STACK ENDS
CODE SEGMENT
start:
        mov ax,STACK
        mov ss,ax
        mov ax,DATA
        mov ds,ax
        mov dx,000FH
        mov ax,4240H
        mov cx,0Ah
        call divdw
	mov ax,4c00h
	int 21h
divdw:  push ax
	mov ax,dx
	mov dx,0
	div cx
	
	mov bx,ax ;put the consult into bx
        pop ax
	
	div cx
	mov cx,dx
	mov dx,bx
	ret
CODE ENDS 
end start
