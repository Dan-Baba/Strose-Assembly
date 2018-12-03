                
title	Dan Foote		;program name
;---------------------------------------------------------------------------------
stacksg	segment	para stack 'Stack'	;define the stack
	db	32 dup (0)		;32 bytes, might want to set larger
stacksg	ends
;---------------------------------------------------------------------------------
datasg	segment para 'Data'	;data segment	
	;--- VARIABLES HERE --
	datav db 3, 4, 6, 5, 9, 7, 8, 0
	sumeven db ?
	sumodd db ?
datasg	ends
;---------------------------------------------------------------------------------
codesg	segment para 'Code'	;code segment
main    proc	far		;main procedure
	assume	ss:stacksg, ds:datasg, cs:codesg	;define segment registers
	mov	ax, datasg	;initialize data segment register
	mov	ds, ax
	mov es, ax
	;---- CODE HERE ----
	lea bx, datav
	mov ax, 0
	LOOPY:
	mov dl, [bx]
	cmp dl, 0
	jz END_LOOP
	test dl, 1
	jnz ADD_ODD
	add ah, dl
	jmp END_IF
	ADD_ODD:
	add al, dl
	END_IF:
	inc bx
	jmp LOOPY

END_LOOP:
	mov sumeven, ah
	mov sumodd, al

	;---- END CODE ----
	mov	ax, 4c00h	;end processing
	int	21h
       
main	endp		;end of procedure
codesg	ends		;end of code segment
	end	main		;end of program