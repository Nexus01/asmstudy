assume cs:code,ds:data,ss:stack
data segment
TAB     dw  LAB0
        dw  LAB1
        dw  LAB2
        dw  LAB3
        dw  LAB4
        dw  LAB5
        dw  LAB6
data ends
stack segment stack 'stack' 
dw 32 dup(?)
TOP     LABEL WORD
stack ends
code segment
BEGIN:  mov ax,data
        mov ds,ax
        mov ah,1
        int 21h
        cmp al,'A'
        jb MRET
        cmp al,'G'
        ja MRET
        sub al,'A'
        and ax,0fh
        shl ax,1
        mov bx,ax
        jmp TAB[bx]

LAB0:   mov dl,'A'
        jmp DONE
LAB1:   mov dl,'B'
        jmp DONE
LAB2:   mov dl,'C'
        jmp DONE
LAB3:   mov dl,'D'
        jmp DONE
LAB4:   mov dl,'E'
        jmp DONE
LAB5:   mov dl,'F'
        jmp DONE
LAB6:   mov dl,'G'
        jmp DONE
DONE:   mov ah,2
        int 21h
MRET:    mov ah,4ch
        int 21h
code ends
end BEGIN                