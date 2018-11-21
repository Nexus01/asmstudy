DATA    	SEGMENT
X       	DW 9876H,5432H
Y       	DW 7678H,9123H
Z       	DW 3 DUP(0)
DATA    	ENDS
CODE    	SEGMENT
ASSUME  	CS:CODE,DS:DATA
START:  	MOV AX,DATA
        	MOV DS,AX
        	MOV AX,X+2
        	ADD AX,Y+2
        	MOV Z+4,AX
        	MOV AX,X
        	ADC AX,Y
        	MOV Z+2,AX
        	MOV Z,0
        	RCL Z,1
        	MOV AH,4CH
        	INT 21H
CODE    	ENDS
END 		START
