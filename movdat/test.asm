assume cs:code,ds:data;,ss:stack
data segment
STR1  		DB 'FJDKLSAJFDKA;FJDKSA;FJ'
STR2  		DB 'DKDKKDKDKDKDKDKDKDKDKD'
COUNT 	DB STR2-STR1
data ends
code segment
START:  	MOV AX,data
        	MOV DS,AX
        	MOV CX,0010H
        	LEA SI,STR1
        	MOV DI,OFFSET STR2
        	CMP SI,DI
        	JA LP2
        	ADD SI,CX
        	ADD DI,CX
        	DEC SI
        	DEC DI
LP1:    	MOV AL,[SI]
        	MOV [DI],AL
        	DEC SI
        	DEC DI
        	DEC CX
        	JNE LP1
        	JMP LP3
LP2:    	MOV AL,[SI]
        	MOV [DI],AL
        	INC SI
        	INC DI
        	DEC CX
        	JNE LP2
LP3:    	MOV AH,4CH
        	INT 21H
            code ends
END 		START
