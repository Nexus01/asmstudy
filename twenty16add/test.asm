;20bit 16 ary  need 21 bit 16ary
assume cs:code,ds:data
data segment
;X dw 1000h,2000h,3000h,4000h,5000h
;X dw 0ffffh,0ffffh,0ffffh,0ffffh,0ffffh
;Y dw 0ffffh,0ffffh,0ffffh,0ffffh,0ffffh
X dw 9876h,5432h,9876h,5432h,9876h
Y dw 9123h,7678h,9123h,7678h,9123h
;Y dw 0001h,0002h,0003        ; mov ax,[bx+di]
        ; add ax,[bx+si]
        ; mov [si+12+bx],ax
        ; sub bx,2h,0004h,0005h
Z dw 6 dup(0)
data ends
code segment
start:  mov ax,data
        mov ds,ax
        mov bx,8
        lea di,X
        lea si,Y
        mov cx,5
        ; mov ax,[bx+di]
        ; add ax,[bx+si]
        ; mov [si+12+bx],ax
        ; sub bx,2
        ; mov dx,0
        ; push dx
; LP:     pop dx
;         mov ax,[bx+di]
;         adc ax,[bx+si]
        ;adc ax,0
        ; mov ax,[bx+di]
        ; adc ax,[bx+si]
        ; mov [si+12+bx],ax
        ; adc word ptr [si+10+bx],0
        ; mov ax,[si+10+bx]
        ; push ax
        ; sub bx,2
LP:     
        mov ax,[bx+di]
        adc ax,[bx+si]
        mov [si+12+bx],ax
        ;adc word ptr [si+12+bx],0
        ;pop ax
        ;adc word ptr [si+10+bx],ax
        ;adc ax,[si+12+bx]
        ;adc word ptr [si+12+bx],0
        ;add [si+12+bx],dx
        ;adc word ptr [si+10+bx],0
        ;mov ax,[si+10+bx]
        ;push ax
        dec bx
        dec bx
        ;sub bx,2
        ;mov dx,[si+10+bx]
        ;push dx
        ;mov word ptr [si+10+bx],0
        ;rcl word ptr [si+10+bx],1
        ;mov dx,0
        ;adc dx,0
        ;push dx
        ;and bx,11111101b
        
        loop LP
        mov Z,0
        adc Z,0
        ;adc word ptr [si+12+bx],0
        ;clc
        ; mov ax,X+8
        ; add ax,Y+8
        ; mov Z+10,ax
        ; ;adc Z+8,0
        ; ; mov Z+8,0
        ; ; rcl Z+8,1

        ; mov ax,X+6
        ; add ax,Y+6
        ; mov Z+8,ax
        ; adc Z+6,0
        ; ; mov Z+6,0
        ; ; rcl Z+6,1

        ; mov ax,X+4
        ; add ax,Y+4
        ; mov Z+6,ax
        ; adc Z+4,0
        ; ; mov Z+4,0
        ; ; rcl Z+4,1

        ; mov ax,X+2
        ; add ax,Y+2
        ; mov Z+4,ax
        ; adc Z+2,0
        ; ; mov Z+2,0
        ; ; rcl Z+2,1

        ; mov ax,X
        ; add ax,Y
        ; mov Z+2,ax
        ; adc Z,0
        ; mov Z,0
        ; rcl Z,1

        mov ah,4ch
        int 21h
code ends
end start