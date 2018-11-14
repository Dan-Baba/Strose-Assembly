                
title	Dan Foote		;program name
;---------------------------------------------------------------------------------
stacksg	segment	para stack 'Stack'	;define the stack
	db	32 dup (0)		;32 bytes, might want to set larger
stacksg	ends
;---------------------------------------------------------------------------------
datasg	segment para 'Data'	;data segment	
	;--- VARIABLES HERE --
	str1 DB 'aB$ Cat^^Zzt*'
datasg	ends
;---------------------------------------------------------------------------------
codesg	segment para 'Code'	;code segment
main    proc	far		;main procedure
	assume	ss:stacksg, ds:datasg, cs:codesg	;define segment registers
	mov	ax, datasg	;initialize data segment register
	mov	ds, ax
	mov es, ax
	;---- CODE HERE ----
	lea bx, str1
	dec bx

	loopy:
		inc bx
		cmp byte ptr [bx], '*'
		jz endy
		cmp byte ptr [bx], 'A'
		jb loopy
		cmp byte ptr [bx], 'Z'
		jbe toLower
		cmp byte ptr [bx], 'a'
		jb loopy
		cmp byte ptr [bx], 'z'
		jbe toUpper
		jmp loopy
	
	toLower:
		add byte ptr [bx], ' '
		jmp loopy

	toUpper:
		sub byte ptr [bx], ' '
		jmp loopy

	endy:
	;---- END CODE ----
	mov	ax, 4c00h	;end processing
	int	21h
       
main	endp		;end of procedure
codesg	ends		;end of code segment
	end	main		;end of program