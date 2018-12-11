assume cs:code,ds:data
data segment
DAT db 01,02,03,04,05,06,07,08,09,10; signed -128~127  unsigned 0～255
;DAT db -128,-127,-2,-1,0,1,2,126,127;if a byte >=80 ,it is a negative number
; 0  1  2 ....126 127 |-128 -127 -126.. -2  -1
; 00 01 02    7e  7f  | 80   81   82    fe  ff
;while all postive(including zero ) , compare directly
;while all negative, as described above
;while mixed, 
;method 1: extend to word
;method 2:
data ends
code segment
start:  mov ax,data
        mov ds,ax
        mov cx,8h
        call BRANCH
        int 3h
BRANCH: jcxz A4
        push si
        push cx
        push bx
        mov bh,[si]
        mov bl,bh
A1:     lodsb
        cmp al,bh
        jbe A2; below or equal al<=bh
        mov bh,al
        jmp A3
A2:     cmp al,bl
        jae A3;above or equal al>=bl
        mov bl,al
A3:     loop A1
        mov ax,bx
        pop bx
        pop cx
        pop si
A4:     ret
code ends
end start                                        