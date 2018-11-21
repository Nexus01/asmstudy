DATA SEGMENT
ASC db '12345678'
COUNT EQU $-ASC
BIN DB 4 DUP(?)
;COUNT EQU 5
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START: MOV AX,DATA
        MOV DS,AX
        LEA SI,ASC
        LEA DI,BIN
        MOV BX,000AH
        MOV CX,COUNT-1
        MOV AH,0H
        MOV DX,0
        MOV AL,[SI]
        SUB AL,30H
LP1:    IMUL BX
        ADD AL,[SI+1]
        SUB AL,30H
        INC SI
        LOOP LP1
        MOV [DI],AX
        MOV [DI+2],DX
        MOV AH,4CH
        INT 21H
CODE ENDS       
END START
