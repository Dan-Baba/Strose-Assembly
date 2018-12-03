                
title	Dan Foote		;program name
;---------------------------------------------------------------------------------
stacksg	segment	para stack 'Stack'	;define the stack
	db	32 dup (0)		;32 bytes, might want to set larger
stacksg	ends
;---------------------------------------------------------------------------------
datasg	segment para 'Data'	;data segment	
	;--- VARIABLES HERE --
	dan db 12
datasg	ends
;---------------------------------------------------------------------------------
codesg	segment para 'Code'	;code segment
main    proc	far		;main procedure
	assume	ss:stacksg, ds:datasg, cs:codesg	;define segment registers
	mov	ax, datasg	;initialize data segment register
	mov	ds, ax
	mov es, ax
	;---- CODE HERE ----
	mov ax, -4
	mov bx, 3
	call multy
	nop
	;---- END CODE ----
	mov	ax, 4c00h	;end processing
	int	21h
       
main	endp		;end of procedure
;new procedures go here
multy proc near
	push ax
	push bx
	push dx
	mov cx, 0
	mov dx, 0

	cmp ax, 0
	jge first_pos
	neg ax
	inc dx
	first_pos:
	cmp bx, 0
	jge loopy
	neg bx
	inc dx

	loopy:
	cmp bx, 0
	jle negative_check
	add cx, ax
	dec bx
	jmp loopy


	negative_check:
	cmp dx, 1
	jne enddy
	neg cx

	enddy:
	pop dx
	pop bx
	pop ax
	ret

multy endp

codesg	ends		;end of code segment
	end	main		;end of program