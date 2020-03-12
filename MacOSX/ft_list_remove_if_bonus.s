# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_list_remove_if_bonus.s                          :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/28 12:57:18 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/12 12:18:50 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_list_remove_if

; ft_list_remove_if prototype:
;	void	ft_list_remove_if(t_list **begin_list, void *data_ref,
;	int (*cmp)());

; rdi = **begin_list
; rsi = *data_ref
; rdx = (*cmp)()

				global		_ft_list_remove_if
				extern		_free

				section		.data
%define			CMPFUNC		[rbp - 32]
%define			HEAD		[rbp - 40]
%define			DATAREF		[rbp - 48]
				
				section		.text
_ft_list_remove_if:
				push		rbp
				mov			rbp, rsp

				test		rdi, rdi		; check if begin_list == NULL
				jz			exit

				push		r12				; r12: pointer to previous
				push		r13				; r13: pointer to current
				push		r14				; r14: pointer to next
				sub			rsp, 8
				mov			[rsp], rdx		; Storing (*cmp)() on the stack.

				sub			rsp, 8			; Storing **begin_list on stack.
				mov			[rsp], rdi

				sub			rsp, 8			; offset currently = 8, for call
											; to _free.
				mov			[rsp], rsi		; Storing *data_ref on stack.

				xor			r12, r12		; r12 = 0, r13 = 0, r14 = 0
				xor			r13, r13
				xor			r14, r14

init_setup:		
				mov			r12, 0
				mov			rcx, HEAD
				mov			r13, [rcx]		; r13 = current
				mov			r14, [r13 + 8]	; r14 = current->next

loop:
				test		r13, r13		; Check if element is NULL
				jz			process_complete

test_data:
				mov			rdi, [r13]		; rdi = current->data
				mov			rsi, DATAREF	; rsi = *data_ref
				call		CMPFUNC
				test		rax, rax
				jz			link_prev
				jmp			next_elem

link_prev:
				cmp			r12, 0
				je			new_head
				mov			[r12 + 8], r14
				jmp			next_elem

new_head:
				mov			rcx, HEAD
				mov			[rcx], r14		; *head = current->next

next_elem:
				mov			rcx, r13
				mov			r13, r14
				test		rax, rax
				jnz			set_new_prev

free_prev:
				mov			rdi, rcx		; Free the removed element.
				call		_free
				jmp			set_new_next

set_new_prev:
				mov			r12, rcx		; Set new previous element.
set_new_next:
				test		r14, r14		; if (current == NULL) {return}
				jz			process_complete
				mov			r14, [r13 + 8]	; next = current->next
				jmp			loop

process_complete:
				add			rsp, 24
				pop			r14
				pop			r13
				pop			r12

exit:
				mov			rsp, rbp
				pop			rbp
				ret
