# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ex8.s                                              :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/19 09:46:17 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/19 10:11:46 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; In this exercise, the base pointer register 'rbp' is used to hold the
; value of 'rsp', the top of your stack when the function was entered.
; In this way, the top of the stack can be restored before returning from
; the function.

		global		_main

		section		.text
_main:	call		func
		mov			rax, 0x2000001
		mov			rdi, 0
		syscall

func:	push		rbp			; pushing the previous rbp value, see endnote
		mov			rbp, rsp	; as rsp can now be restored, we are free
								; to manipulate rsp, the stack pointer.
		sub			rsp, 3		; move two bytes up the stack "allocating
								; stack memory"
		mov			[rsp], byte 'H'
		mov			[rsp + 1], byte 'i'
		mov			[rsp + 2], byte 0x0a
		mov			rax, 0x2000004
		mov			rdi, 1
		mov			rsi, rsp
		mov			rdx, 3
		syscall
		mov			rsp, rbp;	; Restoring rsp, "de-allocating" the space we
								; just allocated, and restoring the stack
								; to its previous condition.
		pop			rbp			; restoring rbp value, see endnote
		ret						; and now return can be executed correctly.

; Note the issue, if 'func' calls another function, that also uses rbp, then
; we would be unable to return to '_main' from func, as we would have lost the
; return address.
; Thus, it is a common practice to push the previous value of rbp onto the
; stack with 'push rbp', to preserve the old value, then popping it back
; immediately prior to the function return.
; This allows for nested function calls without functions interfering with
; each others stack.

; There are terms for these actions, the setup 'push rbp', saving the stack
; pointer with 'mov rbp, rsp', and allocating space with 'sub rsp, 3' is
; known as the prologue of the function.

; The restoring of the stack with 'mov rsp, rbp', 'pop rbp' and returning with
; 'ret' is known as the epilogue of the function.
