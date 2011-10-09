code segment ;PROGRAM START

	mov bp,inpmsg ;input message
	call printmsg ;is printed first

;Get first string
	xor si,si
	mov bp,temp
	call readstr ;reading the first string
	mov bx,bp	;bx stores the beginning address of the first string

;Get second string
	inc si
	add bp,si
	xor si,si
	call readstr ;reading the second string
	
;search the second string in first
;bp is the beginning of the second string
	xor si,si
	call srcocc ;searching the occurence

;finish the program
finish:
	int 20h

printmsg:
	mov ah,02h ;for writing to screen
	xor si,si

msgloop:
	mov dl,[bp+si]
	cmp dl,0h ;Finish writing when 
	je endmsg ;0 is found
	int 21h
	inc si
	jmp msgloop

endmsg:
	ret

readstr:
	mov ah,01h
	int 21h
	
	cmp al,0dh ;Finish reading 
	je endstr  ;when enter is pressed
	cmp al,20h ;or
	je endstr  ;when space is pressed
	
	mov [bp+si],al ;move text to memory
	inc si
	jmp readstr
	
endstr:
	mov b[bp+si],0dh ;Add enter character at the end of the string
	ret
 
srcocc:	
	cmp b[bp+si],0dh ;If end of the second string comes
	je matched	;it means string is found
	
	cmp b[bx+si],0dh ;If end of the first string comes
	je notmatched	;it means string is not found
	
	mov al,[bx+si]
	cmp al,[bp+si] 		;If characters are equal
	je equal			;next character should be checked
	call notequal		;else first string should be checked beginning from the next character
	
equal:
	inc si
	jmp srcocc
	
notequal:
	inc bx			;checking the first string beginning
	xor si,si		;from the next character
	jmp srcocc
	
notmatched:
	call newline	;printing newline
	mov bp,no		
	call printmsg	;printing 'n'
	call finish

matched:
	call newline	;printing newline
	mov bp,yes
	call printmsg	;printing 'y'
	call finish
	
newline:
	mov ah,02h
	mov dl,0ah
	int 21h
	mov dl,0dh
	int 21h
	ret
	
inpmsg:
	db 'Please enter your strings:'
	db 0h	
yes:
	db 'y'
	db 0h
no:
	db 'n'
	db 0h	
temp:
	db ?

code ends
