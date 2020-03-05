# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strchr.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/26 10:48:29 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/05 23:19:01 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_strchr
; For Linux Systems

; ft_strchr prototype: char	*ft_strchr(char *s, int c);

; rdi = s
; rsi = c

			global		ft_strchr

ft_strchr:	
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
