# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strchr.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/26 10:48:29 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/28 17:19:44 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_strchr

; ft_strchr prototype: char	*ft_strchr(char *s, int c);

; rdi = s
; rsi = c

			global		_ft_strchr

_ft_strchr:	
			push		rbp
			mov			rbp, rsp
			mov			rax, rsi
			xor			rcx, rcx

loop:
			cmp			BYTE [rdi + rcx], byte 0
			je			err
			cmp			BYTE [rdi + rcx], al
			je			match
			inc			rcx
			jmp			loop

match:
			add			rdi, rcx
			mov			rax, rdi
			jmp			exit

err:
			mov			rax, 0
exit:
			mov			rsp, rbp
			pop			rbp
			ret
