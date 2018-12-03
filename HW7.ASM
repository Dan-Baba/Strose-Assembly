                
title	Dan Foote		;program name
;---------------------------------------------------------------------------------
stacksg	segment	para stack 'Stack'	;define the stack
	db	32 dup (0)		;32 bytes, might want to set larger
stacksg	ends
;---------------------------------------------------------------------------------
datasg	segment para 'Data'	;data segment	
	;--- VARIABLES HERE --
	nums db 34, 12, 9
datasg	ends
;---------------------------------------------------------------------------------
codesg	segment para 'Code'	;code segment
main    proc	far		;main procedure
	assume	ss:stacksg, ds:datasg, cs:codesg	;define segment registers
	mov	ax, datasg	;initialize data segment register
	mov	ds, ax
	mov es, ax
	;---- CODE HERE ----
	; Save Registers
	push ax
	push bx
	push cx
	push dx
	push si
	push di

	lea bx, nums
	mov ax, 0
	mov cx, 3 ; Size of our list on numbers

OUTER_LOOP:
	
	mov si, 0
	mov di, 0
	mov ah, [si]
	INNER_LOOP:
		cmp ah, [bx + di]
		jge NO_SWAP
		mov si, di
		mov ah, [bx + si]
		NO_SWAP:
		inc di
		cmp di, cx
		jl INNER_LOOP
	; Perform swap of two numbers.
	mov al, [bx + di - 1]
	mov [bx + di - 1], ah
	mov [bx + si], al
	dec cx
	cmp cx, 1
	jz END_PROG
	jmp OUTER_LOOP

END_PROG:
	; Restore registers
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	;---- END CODE ----
	mov	ax, 4c00h	;end processing
	int	21h
       
main	endp		;end of procedure
codesg	ends		;end of code segment
	end	main		;end of program