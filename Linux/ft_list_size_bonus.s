# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_list_size_bonus.s                               :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/28 10:31:01 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/05 23:17:27 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_list_size
; For Linux Systems

; ft_list_size prototype:
;	int	ft_list_size(t_list *begin_list)

; A t_list has size 16

; rdi = *begin_list

				global		ft_list_size

ft_list_size:
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
