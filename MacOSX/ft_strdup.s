# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strdup.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/24 11:20:21 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/12 12:42:27 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_strdup

			global		_ft_strdup
			extern		_malloc
			extern		_ft_strlen
			extern		_ft_strcpy

_ft_strdup:	push		rbp
			mov			rbp, rsp

			mov			r12, rdi	; Copy original pointer to a non-volatile
									; register.

			call		_ft_strlen	; Length of string
			mov			rdi, rax

			inc			rdi			; +1 for '\0'
			call		_malloc		; Malloc appropriate no of bytes
			test		rax, rax	; Test if allocation was successful
			jz			exit
			mov			rdi, rax
			mov			rsi, r12
			call		_ft_strcpy	; rax = ft_strcpy(rdi, rsi)

exit:
			mov			rsp, rbp
			pop			rbp
			ret
