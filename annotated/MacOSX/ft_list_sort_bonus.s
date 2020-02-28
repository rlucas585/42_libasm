# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_list_sort_bonus.s                               :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/28 11:07:49 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/28 12:48:58 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_list_sort, with annotated comments
; For MacOSX

; ft_list_sort prototype:
;	void	ft_list_sort(t_list **begin_list, int (*cmp)());

; int (*cmp)() is a pointer to a function that can compare data held in two
; addresses (the *data in each t_list), for example ft_strcmp.

; rdi = **begin_list
; rsi = (*cmp)()

; When calling a function (such as (*cmp)), we do not know that they will not
; interfere with the values of several of our registers. Some registers are
; known as the 'scratch registers', and can be overwritten by any function.
; Other registers however are expected to be preserved, if we store the previous
; values of these registers on the stack, then we can use these registers as
; much as we like, knowing that the functions called will not lose their values,
; as long as we make sure to restore the registers to their original values at
; the end of our function.

				global		_ft_list_sort

_ft_list_sort:
				push		rbp
				mov			rbp, rsp

				test		rdi, rdi		; Check if **begin_list is NULL
				jz			exit			; Exit if so

				push		r15				; r15 will be used to check if there
											; were any swaps in a single loop.
				push		r12				; r12 will be used as the pointer
											; to the current element.
				push		r13				; r13 will be used as the pointer
											; to the next element.

				sub			rsp, 16			; Storing (*cmp)() on the stack.
				mov			[rsp], rsi

				sub			rsp, 16			; Storing **begin_list on stack.
				mov			[rsp], rdi

				mov			r15, 1			; Set counter to 1 initially.
				xor			r14, r14		; Set r14 to 0 for first element.

reset:
				cmp			r15, 0			; Check if counter is 0 still.
				je			sort_done

				xor			r15, r15		; Sets counter to 0
				mov			rcx, [rsp]		; 'rcx' = **begin_list
				mov			r12, [rcx]		; 'r12' = *begin_list (*current)
				jmp			loop

next_elem:
				mov			r12, r13		; 'r12' (current) = current->next

loop:
				mov			r13, [r12 + 8]	; 'r13' = *next
				test		r13, r13		; Check if *next is NULL ('r12' is
											; last element)
				jz			reset			; Move back to head of list, or
											; complete sort.

				mov			rdi, [r12]		; rdi = current->data
				mov			rsi, [r13]		; rsi = next->data

				; 'rdi' and 'rsi' are prepared for the call to ft_strcmp

				call		[rsp + 16]		; Jumping to supplied function.
				cmp			rax, 0
				jle			next_elem		; Nothing to be done, move to next
											; element.

											; List members data must be swapped
				inc			r15				; r15 incremented to record a swap
											; has occurred
				mov			rcx, [r13]	; 'rcx' = next->data
				mov			r10, [r12]	; 'r10' = current->data
				mov			[r13], r10
				mov			[r12], rcx
				jmp			next_elem


sort_done:
				add			rsp, 32
				pop			r13				; Restore original value of r13.
				pop			r12				; Restore original value of r12.
				pop			r15				; Restore original value of r15.

exit:
				mov			rsp, rbp
				pop			rbp
				ret
