# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strdup.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/24 11:20:21 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/05 23:21:53 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_strdup
; For Linux Systems

			global		ft_strdup
			extern		malloc
			extern		ft_strlen
			extern		ft_strcpy

ft_strdup:	push		rbp
			mov			rbp, rsp

			sub			rsp, 16
			mov			[rsp], rdi	; Stack allocate original pointer

			call		ft_strlen	; Length of string
			mov			rdi, rax

			inc			rdi			; +1 for '\0'
									
			call		malloc
			test		rax, rax
			jz			exit
			mov			rdi, rax
			mov			rsi, [rsp]
			call		ft_strcpy	; rax = ft_strcpy(rdi, rsi)

exit:
			mov			rsp, rbp
			pop			rbp
			ret
