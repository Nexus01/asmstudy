assume cs:code,ds:data,ss:stack
data segment
db 'Welcome to masm!'
db 02h,24h,71h
data ends
stack segment
db 8 dup(0)
stack ends
start:	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax
	mov sp,10h
	
