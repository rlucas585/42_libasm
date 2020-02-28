# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_list_size_bonus.s                               :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/28 10:31:01 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/28 11:06:27 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_list_size, with annotated comments
; For MacOSX

; ft_list_size prototype:
;	int	ft_list_size(t_list *begin_list)

; A t_list has size 16

; rdi = *begin_list

				global		_ft_list_size

_ft_list_size:
				push		rbp
				mov			rbp, rsp

				xor			rax, rax	; Set 'rax' to zero

loop:
				test		rdi, rdi	; Check if pointer is NULL
				jz			exit

				inc			rax			; Increase count by 1
				mov			rcx, [rdi + 8]	; Reassign rdi to 'next', using rcx.
				mov			rdi, rcx
				jmp			loop


exit:
				mov			rsp, rbp
				pop			rbp
				ret
