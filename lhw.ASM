                
title	Dan Foote		;program name
;---------------------------------------------------------------------------------
stacksg	segment	para stack 'Stack'	;define the stack
	db	32 dup (0)		;32 bytes, might want to set larger
stacksg	ends
;---------------------------------------------------------------------------------
datasg	segment para 'Data'	;data segment	
	;--- VARIABLES HERE --
	prompt db 'Enter up to 10 characters: $'
	paralst label byte
	maxlen db 10
	actlen db 0
	dbdata db 11 dup(?)
	endstring db '$'
datasg	ends
;---------------------------------------------------------------------------------
codesg	segment para 'Code'	;code segment
main    proc	far		;main procedure
	assume	ss:stacksg, ds:datasg, cs:codesg	;define segment registers
	mov	ax, datasg	;initialize data segment register
	mov	ds, ax
	mov es, ax
	;---- CODE HERE ----

	TOPPY:
	; Clear Screen
	mov ah, 06h
	mov al, 0
	mov ch, 0
	mov dh, 24
	mov cl, 0
	mov dl, 79
	mov bh, 01110100b
	int 10h
	
	; Move to message line
	mov ah, 02h
	mov bh, 0
	mov dh, 13
	mov dl, 30
	int 10h

	; Add terminator
	mov al, actlen
	cbw
	lea bx, dbdata
	add bx, ax
	mov byte ptr [bx], '$'

	; Print message
	mov ah, 09h
	lea dx, dbdata
	int 21h

	; Move cursor
	mov ah, 02h
	mov bh, 0
	mov dh, 12
	mov dl, 30
	int 10h

	; Print prompt
	mov ah, 09h
	lea dx, prompt
	int 21h

	; Get input
	mov ah, 0ah
	lea dx, paralst
	int 21h

	cmp actlen, 0
	jz ENDDY

	jmp TOPPY


	ENDDY:
	;---- END CODE ----
	mov	ax, 4c00h	;end processing
	int	21h
       
main	endp		;end of procedure
;new procedures go here


codesg	ends		;end of code segment
	end	main		;end of program