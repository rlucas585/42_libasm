# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strcpy.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 17:05:34 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/29 13:21:06 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_strcpy, with annotated comments

; ft_strcpy prototype: char	*ft_strcpy(char *dst, const char *src);

; rdi = dst
; rsi = src

			global		_ft_strcpy

_ft_strcpy	push		rbp
			mov			rbp, rsp

			sub			rsp, 16
			mov			[rsp], rdi		; Allocating original pointer on stack

loop:
			cmp			[rsi], byte 0
			je			end
			mov			rax, [rsi]
			mov			[rdi], rax
			inc			rsi
			inc			rdi
			jmp			loop

end:		
			mov			rax, 0			; Null terminator
			mov			[rdi], rax
			mov			rax, [rsp]
			mov			rsp, rbp
			pop			rbp
			ret
