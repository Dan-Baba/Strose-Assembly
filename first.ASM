                
title	Daniel Foote		;program name
;---------------------------------------------------------------------------------
stacksg	segment	para stack 'Stack'	;define the stack
	db	32 dup (0)		;32 bytes, might want to set larger
stacksg	ends
;---------------------------------------------------------------------------------
datasg	segment para 'Data'	;data segment	
	x DB 57
	y DB 1
	str1 DB 'Hello'
	apple DW -1, 10
datasg	ends
;---------------------------------------------------------------------------------
codesg	segment para 'Code'	;code segment
main    proc	far		;main procedure
	assume	ss:stacksg, ds:datasg, cs:codesg	;define segment registers
	mov	ax, datasg	;initialize data segment register
	
	mov	ds, ax
	mov es, ax
	mov al, x
	mov cl, y
	add al, cl
	mov x, al
	lea bx, apple
	mov dx, [bx]
	inc bx
	inc bx
	mov ax, [bx]
	mov cl, str1
	mov y, cl
	
	


	mov	ax, 4c00h	;end processing
	int	21h
       
main	endp		;end of procedure
codesg	ends		;end of code segment
end	main		;end of program