                
title	Dan Foote		;program name
;---------------------------------------------------------------------------------
stacksg	segment	para stack 'Stack'	;define the stack
	db	32 dup (0)		;32 bytes, might want to set larger
stacksg	ends
;---------------------------------------------------------------------------------
datasg	segment para 'Data'	;data segment	
	;--- VARIABLES HERE --
	prompt db 'Enter your name: $'
	paralst label byte
	maxlen db 20
	actlen db ?
	dbdata db 20 dup('$')
	message db 'Hello, $'
datasg	ends
;---------------------------------------------------------------------------------
codesg	segment para 'Code'	;code segment
main    proc	far		;main procedure
	assume	ss:stacksg, ds:datasg, cs:codesg	;define segment registers
	mov	ax, datasg	;initialize data segment register
	mov	ds, ax
	mov es, ax
	;---- CODE HERE ----
	; Clear screen
	mov ah, 06h
	mov al, 0
	mov ch, 0
	mov dh, 24
	mov cl, 0
	mov dl, 79
	mov bh, 00000111b
	int 10h

	; Move cursor
	mov ah, 02h
	mov bh, 0
	mov dh, 0
	mov dl, 0
	int 10h

	; Output prompt
	mov ah, 09h
	lea dx, prompt
	int 21h

	; Get input
	mov ah, 0ah
	lea dx, paralst
	int 21h

	; Move cursor
	mov ah, 02h
	mov bh, 0
	mov dh, 1
	mov dl, 0
	int 10h


	; Write message
	mov ah, 09h
	lea dx, message
	int 21h
	lea dx, dbdata
	int 21h




	;---- END CODE ----
	mov	ax, 4c00h	;end processing
	int	21h
       
main	endp		;end of procedure
;new procedures go here
codesg	ends		;end of code segment
	end	main		;end of program