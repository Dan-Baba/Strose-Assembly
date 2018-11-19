                
title	Dan Foote		;program name
;---------------------------------------------------------------------------------
stacksg	segment	para stack 'Stack'	;define the stack
	db	32 dup (0)		;32 bytes, might want to set larger
stacksg	ends
;---------------------------------------------------------------------------------
datasg	segment para 'Data'	;data segment	
	;--- VARIABLES HERE --
	nums db 100, -7, 102, 48, 0
	sumIt dw 0
datasg	ends
;---------------------------------------------------------------------------------
codesg	segment para 'Code'	;code segment
main    proc	far		;main procedure
	assume	ss:stacksg, ds:datasg, cs:codesg	;define segment registers
	mov	ax, datasg	;initialize data segment register
	mov	ds, ax
	mov es, ax
	;---- CODE HERE ----
	mov dx, sumIt
	mov ax, 0
	lea bx, nums
	LOOPY:
		cmp byte ptr [bx], 0
		jz ENDDY
		.386 ;maybe this works?
		movsx al, [bx]
		;cbw
		add dx, ax
		inc bx
		jmp LOOPY

	ENDDY:
	mov sumIt, ax
	;---- END CODE ----
	mov	ax, 4c00h	;end processing
	int	21h
       
main	endp		;end of procedure
codesg	ends		;end of code segment
	end	main		;end of program