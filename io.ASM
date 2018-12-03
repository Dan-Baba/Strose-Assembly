                
title	Dan Foote		;program name
;---------------------------------------------------------------------------------
stacksg	segment	para stack 'Stack'	;define the stack
	db	32 dup (0)		;32 bytes, might want to set larger
stacksg	ends
;---------------------------------------------------------------------------------
datasg	segment para 'Data'	;data segment	
	;--- VARIABLES HERE --
	message db 'Hello $'
	paralst label byte
	maxlen db 20
	actlen db ?
	dbdata db 20 dup(' ')
datasg	ends
;---------------------------------------------------------------------------------
codesg	segment para 'Code'	;code segment
main    proc	far		;main procedure
	assume	ss:stacksg, ds:datasg, cs:codesg	;define segment registers
	mov	ax, datasg	;initialize data segment register
	mov	ds, ax
	mov es, ax
	;---- CODE HERE ----
	
	; Accept input from keyboard
	mov ah, 0ah
	lea dx, paralst
	int 21h


	; Clear screen set background
	mov ah, 06h
	mov al, 0
	mov ch, 0
	mov dh, 24
	mov cl, 0
	mov dl, 25
	mov bh, 00100001b
	int 10h

	mov ah, 06h
	mov al, 0
	mov ch, 0
	mov dh, 24
	mov cl, 26
	mov dl, 53
	mov bh, 01110000b
	int 10h

	mov ah, 06h
	mov al, 0
	mov ch, 0
	mov dh, 24
	mov cl, 54
	mov dl, 79
	mov bh, 01000000b
	int 10h

	; Blinking cursor mid screen
	mov ah, 02h
	mov bh, 0
	mov dh, 12
	mov dl, 32
	int 10h

	; Display string
	mov ah, 09h
	lea dx, message
	int 21h

	mov ah, 09h
	lea dx, paralst
	int 21h


	;---- END CODE ----
	mov	ax, 4c00h	;end processing
	int	21h
       
main	endp		;end of procedure
;new procedures go here
codesg	ends		;end of code segment
	end	main		;end of program