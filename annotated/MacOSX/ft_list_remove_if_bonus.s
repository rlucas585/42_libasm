# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_list_remove_if_bonus.s                          :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/28 12:57:18 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/28 15:21:30 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_list_remove_if, with annotated comments
; For MacOSX

; ft_list_remove_if prototype:
;	void	ft_list_remove_if(t_list **begin_list, void *data_ref,
;	int (*cmp)());

; rdi = **begin_list
; rsi = *data_ref
; rdx = (*cmp)()

				global		_ft_list_remove_if
				extern		_free

_ft_list_remove_if:
				push		rbp
				mov			rbp, rsp

				test		rdi, rdi		; Check if **begin_list is NULL
				jz			exit			; Exit if so

				push		r12				; r12 will be used as the pointer
											; to the previous element.
				push		r13				; r13 will be used as the pointer
											; to the current element.
				push		r14				; r14 will be used as the pointer
											; to the next element
				sub			rsp, 16
				mov			[rsp], rdx		; Storing (*cmp)() on the stack.

				sub			rsp, 16			; Storing **begin_list on stack.
				mov			[rsp], rdi

				sub			rsp, 16
				mov			[rsp], rsi		; Storing *data_ref on stack.

				xor			r12, r12		; Set all registers to 0.
				xor			r13, r13
				xor			r14, r14

	; Planning: Five basic steps:
	; + Check if current is NULL -> Exit if so
	; + On current, check if equal -> store value in rax
	; + If rax == 0, link previous (or head) to next
	; + Move to next
	; + If rax == 0, free previous

	; Special case when we must remove current, and previous is not an element

init_setup:		
				mov			r12, 0
				mov			rcx, [rsp + 16]	; 'rcx' = **begin_list
				mov			r13, [rcx]		; 'r13' = *begin_list
				mov			r14, [r13 + 8]

loop:
				test		r13, r13
				jz			process_complete

test_data:
				mov			rdi, [r13]	; current->data
				mov			rsi, [rsp]	; data_ref
				call		[rsp + 32]	; call cmp() function.
				test		rax, rax
				jz			link_prev
				jmp			next_elem

link_prev:
				cmp			r12, 0		; Causing segmentation fault
				je			new_head
				mov			[r12 + 8], r14	; Link previous to next
				jmp			next_elem

new_head:
				mov			rcx, [rsp + 16]	; 'rcx' = **begin_list
				mov			[rcx], r14		; set_new_head as 'next' of head
											; element.

next_elem:
				mov			rcx, r13	; Store current in 'rcx'
				mov			r13, r14	; current = current->next
				test		rax, rax
				jnz			set_new_prev

free_prev:
				mov			rdi, rcx
				call		_free
				jmp			set_new_next

set_new_prev:
				mov			r12, rcx
set_new_next:
				test		r14, r14
				jz			process_complete
				mov			r14, [r13 + 8]
				jmp			loop

process_complete:
				add			rsp, 48
				pop			r14
				pop			r13
				pop			r12

exit:
				mov			rsp, rbp
				pop			rbp
				ret
