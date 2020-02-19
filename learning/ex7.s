# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ex7.s                                              :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/19 09:31:27 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/19 09:46:12 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; 'call' pushes the instruction pointer to the stack, the address of the NEXT
; instruction is placed on the stack

; 'call' then performs a jump to the location of the named function.
; The return location does not need to be hard-coded due to this, and can
; be called from anywhere inside a function.

		global		_main

		section		.text
_main:	call		func
		mov			rax, 0x2000001
		syscall

func:	mov			rdi, 42
		;pop		rax			; pop into rax the value that was placed on the
								; stack by call, the address of the next
								; instruction in _main.
		;jmp		rax			; Jump to 'mov rax' in _main.
								; This code can be greatly simplified with
								; the 'ret' instruction.
		ret

; However, what if you want to use the stack in the 'func' function, and still
; return from it?
; It would of course be possible to carefully preserve the integrity of the
; stack, and keep the return location 'mov rax in _main' at the top of the
; stack.

; There is a much more convenient way to do this however, by preserving the
; stack by using a register known as the 'base register', see ex8 for more
