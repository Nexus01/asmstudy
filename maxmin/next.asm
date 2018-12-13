assume cs:code,ds:data
data segment
;dat db 01,02,03,04,05,06,07,08,09,10; signed -128~127  unsigned 0?255
;dat db -128,-127,-2,-1,0,1,2,126,127;if a byte >=80 ,it is a negative number
dat db -127,-2,-1,-128,0,1,2,127,126
;dat db 123,-20,1,110,0,3,2,10,126
;dat db 0,9,-125,3,-6,2,-9,100,-101
nong db 00,01
dispmax db 'the max of the quene is '
max db 0,0,'$'
dispmin db 'the min of the quene is '
min db 0,0,'$'
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
        ;lea di,nong
        mov cx,8h
        call branch
        mov ah,4ch
        int 21h
        int 3h
branch: jcxz a4
        push si
        push cx
        push bx
        push dx
        xor bx,bx
        mov bl,[si] ;bh~=bx bl~=dx
        mov dx,bx
        ;mov bl,bh
a1:     lodsb
        ;load the prelude
        cmp al,80h
        jb prela
        mov ah,0h
back1:  
        cmp bl,80h
        jb prelb
        mov bh,0
back2:  
        cmp dl,80h
        jb preld
        mov dh,0h
back3:
        cmp ax,bx; 0100 00ff
        jbe a2; below or equal ax<=bx
        mov bx,ax
        jmp a3
a2:     cmp ax,dx
        jae a3;above or equal ax>=dx
        ;cmp cx,8
        ;je a3
        mov dx,ax
a3:     loop a1
        ; min-> al
        lea di,min
        mov [si],dx
        call hexa
        lea di,max
        mov [si],bx; max-> ah
        call hexa
        lea dx,dispmax
        mov ah,09h
        int 21h
        mov dl,10
        mov ah,2
        int 21h
        lea dx,dispmin
        mov ah,09h
        int 21h
        pop dx
        pop bx
        pop cx
        pop si
a4:     ret
prela:  lea di,nong
        inc di
        mov ah,[di]
        jmp back1
prelb:  lea di,nong
        inc di
        mov bh,[di]
        jmp back2
preld:  lea di,nong
        inc di
        mov dh,[di]
        jmp back3
hexa:   mov al,[si]
        mov ah,al
        mov cl,4
        ror al,cl
        and ah,0fh
        and al,0fh
        add al,30h
        cmp al,39h
        jbe hex1
        cmp al,39h    
        jbe hex1      
        add al,07h    
hex1:   add ah,30h            
        cmp ah,39h    
        jbe hex2      
        add ah,07h    
hex2:   mov [di],ax              
        ret
code ends
end start                                        