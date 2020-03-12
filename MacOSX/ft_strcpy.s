# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strcpy.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 17:05:34 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/12 12:36:03 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_strcpy, with annotated comments

; ft_strcpy prototype: char	*ft_strcpy(char *dst, const char *src);

; rdi = dst
; rsi = src

			global		_ft_strcpy

_ft_strcpy	push		rbp
			mov			rbp, rsp

			xor			rcx, rcx

loop:
			cmp			[rsi + rcx], byte 0
			je			end
			mov			al, byte [rsi + rcx]
			mov			BYTE [rdi + rcx], al
			inc			rcx
			jmp			loop

end:		
			mov			rax, 0			; Null terminator
			mov			[rdi + rcx], al
			mov			rax, rdi		; Return value = pointer to dst
			mov			rsp, rbp
			pop			rbp
			ret
