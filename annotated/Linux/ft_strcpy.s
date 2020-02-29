# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strcpy.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 17:05:34 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/29 13:25:13 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_strcpy, with annotated comments
; This version is for Linux systems, rather than MacOSX

; ft_strcpy prototype: char	*ft_strcpy(char *dst, const char *src);

; See the MacOSX variant for more extensive annotation

; rdi = dst
; rsi = src

			global		ft_strcpy		; No '_' in linux assembly

ft_strcpy:	push		rbp
			mov			rbp, rsp

			sub			rsp, 16			; Allocating 16 bytes on the stack
			mov			[rsp], rdi		; Moving initial pointer value into
										; the stack. MORE RELIABLE THAN
										; USING A REGISTER, AS ANOTHER FUNCTION
										; MAY BE USING THE REGISTER.

loop:		cmp			[rsi], byte 0	; compare the value rsi points to with 0
										; to check for the null terminator
			je			end				; if equal, jump to end
			mov			rax, [rsi]		; mov byte into rax...
			mov			[rdi], rax		; and move from rax to [rdi]
			inc			rsi				; increment both pointers
			inc			rdi
			jmp			loop			; Repeat the loop again

end:
			mov			rax, 0			; Add null-terminator
			mov			[rdi], rax
			mov			rax, [rsp]		; Set return value as initial pointer
										; to dst
			mov			rsp, rbp
			pop			rbp
			ret
