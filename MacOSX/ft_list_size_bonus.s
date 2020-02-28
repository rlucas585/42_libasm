# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_list_size_bonus.s                               :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/28 10:31:01 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/28 17:13:15 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_list_size

; ft_list_size prototype:
;	int	ft_list_size(t_list *begin_list)

; A t_list has size 16

; rdi = *begin_list

				global		_ft_list_size

_ft_list_size:
				push		rbp
				mov			rbp, rsp

				xor			rax, rax	; rax = 0

loop:
				test		rdi, rdi
				jz			exit

				inc			rax			; rax++
				mov			rcx, [rdi + 8]	; rcx = current->next
				mov			rdi, rcx	; current = current->next
				jmp			loop


exit:
				mov			rsp, rbp
				pop			rbp
				ret
