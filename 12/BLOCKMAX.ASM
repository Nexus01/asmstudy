ASSUME CS:CODE,DS:DATA
DATA SEGMENT
;BLOCK DB 10 dup(22h,11h,44h,33h,66h,77h,99h,88h,10h,55h)
BLOCK db 100 dup(?)
MAX DB ?
DATA ENDS
CODE SEGMENT

START:  MOV AX,DATA
        MOV DS,AX
        MOV CX,99
        LEA BX,BLOCK
        MOV AH,[BX]
        INC BX
AGAIN:  CMP AH,[BX]
        JG NEXT
        MOV AH,[BX]
NEXT:   INC BX
        DEC CX
        JNE AGAIN
        MOV MAX,AH
DONE:   MOV AX,4C00H
        INT 21H
CODE ENDS
END START
