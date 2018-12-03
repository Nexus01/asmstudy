;20bit 16 ary  need 21 bit 16ary
assume cs:code,ds:data
data segment
;X dw 1000h,2000h,3000h,4000h,5000h
X dw 0ffffh,0ffffh,0ffffh,0ffffh,0ffffh
Y dw 0ffffh,0ffffh,0ffffh,0ffffh,0ffffh
;Y dw 0001h,0002h,0003h,0004h,0005h
Z dw 6 dup(0)
data ends
code segment
start:  mov ax,data
        mov ds,ax
        mov ax,X+8
        add ax,Y+8
        mov Z+10,ax
        mov ax,X+6
        adc ax,Y+6
        mov Z+8,ax
        mov Z+6,0
        rcl Z+6,1

        mov ax,X+4
        adc ax,Y+4
        mov Z+6,ax
        mov Z+4,0
        rcl Z+4,1

        mov ax,X+2
        adc ax,Y+2
        mov Z+4,ax
        mov Z+2,0
        rcl Z+2,1

        mov ax,X
        adc ax,Y
        mov Z+2,ax
        mov Z,0
        rcl Z,1
        mov ah,4ch
        int 21h
code ends
end start