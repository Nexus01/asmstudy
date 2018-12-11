assume cs:code,ds:data
data segment
;DAT db 01,02,03,04,05,06,07,08,09,10; signed -128~127  unsigned 0～255
;DAT db -128,-127,-2,-1,0,1,2,126,127;if a byte >=80 ,it is a negative number
DAT db -127,-2,-1,-128,0,1,2,127,126
NONG db 00,01
; 0  1  2 ....126 127 |-128 -127 -126.. -2  -1
; 00 01 02    7e  7f  | 80   81   82    fe  ff
;while all postive(including zero ) , compare directly
;while all negative, as described above
;while mixed, 
;method 1: extend to word
;correspond to 0100-00ff
; -128    -127   -126..  -2    -1    0      1    2 .... 126  127 
;  0080   0081   0082    00fe  00ff  0100 0101 0102    017e  017f  
;method 2: compare separately  + vs + /  - vs -
data ends
code segment
start:  mov ax,data
        mov ds,ax
        lea di,NONG
        ;mov ax,0100h
        ;mov bx,0ffh
        ;sub ax,bx
        mov cx,8h
        call BRANCH
        int 3h
BRANCH: jcxz A4
        push si
        push cx
        push bx
        push dx
        xor bx,bx
        mov bh,[si] ;bh~=bx bl~=dx
        mov dx,bx
        ;mov bl,bh
A1:     lodsb
        ;load the prelude
        cmp al,80h
        jb PRELa
        mov ah,0h
BACK1:  
        cmp bl,80h
        jb PRELb
        mov bh,0
BACK2:
        cmp ax,bx; 0100 00ff
        jbe A2; below or equal al<=bh
        mov bx,ax
        jmp A3
A2:     cmp ax,dx
        jae A3;above or equal al>=bl
        mov dx,ax
A3:     loop A1
        ;mov ax,bx
        mov ah,bl; max-> ah
        mov al,dl; min-> al
        pop dx
        pop bx
        pop cx
        pop si
A4:     ret
PRELa:   
        lea di,NONG
        inc di
        mov ah,[di]
        jmp BACK1
PRELb:   
        lea di,NONG
        inc di
        mov bh,[di]
        jmp BACK2
code ends
end start                                        