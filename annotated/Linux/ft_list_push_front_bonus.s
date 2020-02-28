# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_list_push_front_bonus.s                         :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/28 09:53:09 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/28 09:53:36 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_list_push_front_bonus, with annotated comments
; For Linux systems

; ft_list_push_front_bonus prototype:
;	void	*ft_list_push_front_bonus(t_list **begin_list, void *data);

; A t_list has size 16, and this is the size used for the malloc.

; rdi = **begin_list
; rsi = *data

				global		ft_list_push_front
				extern		malloc
				
ft_list_push_front:
				push		rbp
				mov			rbp, rsp

				sub			rsp, 16
				mov			[rsp], rdi	; Storing **begin_list in stack
				sub			rsp, 16
				mov			[rsp], rsi	; Storing *data in stack

				mov			rdi, 16		; Size for new t_list structure
				call		malloc		
				test		rax, rax	; 'rax' is NULL if error, and the
										; pointer to the new area of memory
										; otherwise.
				jz			err			; Allocation failure
										
				mov			rcx, [rsp]	; places *data in 'rcx'
				mov			[rax], rcx	; Assign data pointer value to new
										; struct
				mov			rdx, [rsp + 16] ; Get **begin_list
				mov			rcx, [rdx]	; place *begin_list in rcx
				mov			[rax + 8], rcx		; Assign pointer to previous
												; head to new struct

				mov			rcx, [rsp + 16]		; plaxe **begin_list in rcx
				mov			[rcx], rax			; Change the head of the list
												; to our new struct

err:
				mov			rsp, rbp
				pop			rbp
				ret
				
