                
title	Dan Foote		;program name
;---------------------------------------------------------------------------------
stacksg	segment	para stack 'Stack'	;define the stack
	db	32 dup (0)		;32 bytes, might want to set larger
stacksg	ends
;---------------------------------------------------------------------------------
datasg	segment para 'Data'	;data segment	
	;--- VARIABLES HERE --
	nums dw -10, 178, 45, -5, 200, '*'
	maxx dw ?
	minn dw ?
datasg	ends
;---------------------------------------------------------------------------------
codesg	segment para 'Code'	;code segment
main    proc	far		;main procedure
	assume	ss:stacksg, ds:datasg, cs:codesg	;define segment registers
	mov	ax, datasg	;initialize data segment register
	mov	ds, ax
	mov es, ax
	;---- CODE HERE ----
	mov ax, nums
	mov dx, nums
	lea bx, nums
loopy:
	add bx, 2
	cmp word ptr [bx], '*'
	je endy

	cmp [bx], ax
	jng not_greater
	mov ax, [bx]
not_greater:

	cmp [bx], dx
	jnl not_less
	mov dx, [bx]
not_less:

	jmp loopy

endy:
	mov maxx, ax
	mov minn, dx
	;---- END CODE ----
	mov	ax, 4c00h	;end processing
	int	21h
       
main	endp		;end of procedure
codesg	ends		;end of code segment
	end	main		;end of program