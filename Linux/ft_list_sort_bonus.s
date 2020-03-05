# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_list_sort_bonus.s                               :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/28 11:07:49 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/05 23:17:39 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_list_sort

; ft_list_sort prototype:
;	void	ft_list_sort(t_list **begin_list, int (*cmp)());

; int (*cmp)() is a pointer to a function that can compare data held in two
; addresses (the *data in each t_list), for example ft_strcmp.

; rdi = **begin_list
; rsi = (*cmp)()

				global		ft_list_sort

ft_list_sort:
				push		rbp
				mov			rbp, rsp

				test		rdi, rdi		; (rdi == NULL)
				jz			exit

				push		r15				; r15: Check if swaps
				push		r12				; r12: Current element
				push		r13				; r13: Next element
				sub			rsp, 8			; Stack alignment

				sub			rsp, 16			; (*cmp)() on stack.
				mov			[rsp], rsi

				sub			rsp, 16			; **begin_list
				mov			[rsp], rdi

				mov			r15, 1			; r15 = 1
				xor			r14, r14		; r14 = NULL

reset:
				cmp			r15, 0			; (r15 == 0)
				je			sort_done

				xor			r15, r15		; r15 = 0
				mov			rcx, [rsp]
				mov			r12, [rcx]
				jmp			loop

next_elem:
				mov			r12, r13		; current = current->next

loop:
				xor			rax, rax
				mov			r13, [r12 + 8]	; next = current->next
				test		r13, r13		; (next == NULL)
				jz			reset
				mov			rdi, [r12]		; rdi = current->data
				mov			rsi, [r13]		; rsi = next->data
				call		[rsp + 16]		; rax = cmp(rdi, rsi)
				cmp			eax, 0			; if 'rax', does not work correctly
				jle			next_elem
											
				inc			r15				; r15++
				mov			rcx, [r13]		; 'rcx' = next->data
				mov			r10, [r12]		; 'r10' = current->data
				mov			[r13], r10
				mov			[r12], rcx
				jmp			next_elem


sort_done:
				add			rsp, 32
				pop			r13				; Restore preserved registers
				pop			r12
				pop			r15

exit:
				mov			rsp, rbp
				pop			rbp
				ret
