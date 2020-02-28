# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strchr_bonus.s                                  :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/28 09:50:27 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/28 09:50:50 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_strchr, with annotated comments
; For Linux systems

; ft_strchr prototype: char	*ft_strchr(char *s, int c);

; rdi = s
; rsi = c

			global		ft_strchr

			section		.text

ft_strchr:	
			push		rbp			; Standard prologue
			mov			rbp, rsp
			mov			rax, rsi	; Move the character from 'rdi' to 'rax'.
									; 'al' will now refer to the last 8 bits
									; of the 'rax' register.
			xor			rcx, rcx	; Set rcx, our increment, to 0

loop:
			cmp			BYTE [rdi + rcx], byte 0	; Compare current byte to 0.
			je			err			; Exit with 'rax' == 0
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
