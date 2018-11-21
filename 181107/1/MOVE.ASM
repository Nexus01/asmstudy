        .MODEL TINY
        .STACK 100
        .CODE
START:  MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX
        NOP
        MOV CX,100H
        MOV SI,3000H
        MOV DX,2000H
START1: MOV AL,[SI]
        OUT DX,AL
        INC SI
        INC DX
        LOOP START1
        MOV DI,6000H
        MOV DX,2000H
        MOV CX,100H
START2: IN AL,DX
        MOV [DI],AL
        INC DI
        INC DX
        LOOP START2
        JMP $
;MOVE    ENDP
        END START
