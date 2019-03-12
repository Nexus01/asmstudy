assume cs:code,ds:data
data segment
pattern db 0h
table db ?

data ends
code segment
start:mov ax,data
      mov ds,ax
      mov ah,01    ;进行输入
      int 21h
      mov pattern,al
      mov ah,0ah
	    int 21h
	    mov dl,10
	    mov ah,02h
	    int 21h
      mov ah,2    ;进行输出
      mov dl,pattern
      int 21h
      mov al,pattern
      mov ah,10
      mul ah
      mov pattern,al
      mov ah,4Ch
      int 21h



code ends
end start
