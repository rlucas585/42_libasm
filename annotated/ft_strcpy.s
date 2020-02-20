# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strcpy.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 17:05:34 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/20 17:49:38 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_strcpy, with annotated comments

; ft_strcpy prototype: char	*ft_strcpy(char *dst, const char *src);

; rdi = dst
; rsi = src

; Looping is working properly here, without the need for additional instructions
; as was done in ft_strlen. ft_strlen could very well be rewritten with these
; principles.
; I'm not sure why 'mov [rdi] [rsi]' doesn't work, but it doesn't with the error
; message "invalid combination of opcode and operands" given. I've gotten around
; it by just moving the value into 'rax' and then from 'rax' to '[rdi]'.

			global		_ft_strcpy

_ft_strcpy	push		rbp
			mov			rbp, rsp
			mov			rdx, rdi		; Saving initial pointer value for
										; return at end of function
loop:		cmp			[rsi], byte 0	; compare the value rsi points to with 0
										; to check for the null terminator
			je			end				; if equal, jump to end
			mov			rax, [rsi]		; mov byte into rax...
			mov			[rdi], rax		; and move from rax to [rdi]
			inc			rsi				; increment both pointers
			inc			rdi
			jmp			loop			; Repeat the loop again
end:		mov			rax, rdx		; Set return value as initial pointer
										; to dst
			mov			rsp, rbp
			pop			rbp
			ret

; Notes for strdup
;push		al
;	Call to strdup
;pop			al
