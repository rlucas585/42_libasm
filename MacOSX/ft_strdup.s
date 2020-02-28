# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strdup.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/24 11:20:21 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/28 17:25:23 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_strdup

			global		_ft_strdup
			extern		_malloc
			extern		_ft_strlen
			extern		_ft_strcpy

_ft_strdup:	push		rbp
			mov			rbp, rsp

			sub			rsp, 16
			mov			[rsp], rdi	; Stack allocate original pointer

			call		_ft_strlen	; Length of string
			mov			rdi, rax

			inc			rdi			; +1 for '\0'
									
			call		_malloc
			test		rax, rax
			jz			exit
			mov			rdi, rax
			mov			rsi, [rsp]
			call		_ft_strcpy	; rax = ft_strcpy(rdi, rsi)

exit:
			mov			rsp, rbp
			pop			rbp
			ret
