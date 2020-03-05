# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strcpy.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 17:05:34 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/05 23:55:52 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_strcpy
; For Linux Systems

; ft_strcpy prototype: char	*ft_strcpy(char *dst, const char *src);

; rdi = dst
; rsi = src

			global		ft_strcpy

ft_strcpy	push		rbp
			mov			rbp, rsp

			sub			rsp, 16
			mov			[rsp], rdi		; Allocating original pointer on stack
			xor			rax, rax

loop:
			cmp			[rsi], byte 0
			je			end
			mov			al, byte [rsi]
			mov			[rdi], al
			inc			rsi
			inc			rdi
			jmp			loop

end:		
			mov			rax, 0			; Null terminator
			mov			[rdi], al
			mov			rax, [rsp]
			mov			rsp, rbp
			pop			rbp
			ret
