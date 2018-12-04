assume cs:code,ds:data;,ss:stack
data segment
str1  		db 'fjdklsajfdka;fjdksa;fj'
str2  		db 'dkdkkdkdkdkdkdkdkdkdkd'
count 	db str2-str1
data ends
code segment
start:  	mov ax,data
        	mov ds,ax
        	mov cx,0010h
        	lea si,str1
        	mov di,offset str2
        	cmp si,di
        	ja lp2
        	add si,cx
        	add di,cx
        	dec si
        	dec di
lp1:    	mov al,[si]
        	mov [di],al
        	dec si
        	dec di
        	dec cx
        	jne lp1
        	jmp lp3
lp2:    	mov al,[si]
        	mov [di],al
        	inc si
        	inc di
        	dec cx
        	jne lp2
lp3:    	mov ah,4ch
        	int 21h
            code ends
end 		start
