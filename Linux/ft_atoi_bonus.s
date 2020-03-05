# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_atoi_bonus.s                                    :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/27 23:26:50 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/05 23:16:39 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_atoi
; For Linux Systems

; ft_atoi prototype: int	ft_atoi_base(const char *str);

; rdi = str

				global		ft_atoi

ft_atoi:		push		rbp			; Standard prologue
				mov			rbp, rsp

				sub			rsp, 16
				mov			[rsp], rdi	; Stack allocation of initial pointer
				sub			rsp, 16
				mov			qword [rsp], 0	; Stack allocation of 'sign'
											; 1 for negative numbers,
											; and 0 for positive numbers.
				mov			rax, 0
				jmp			whitespace

inc_whitespace:
				inc			rdi
whitespace:
				cmp			[rdi], byte 0	; compare for '\0'
				jz			exit
				cmp			[rdi], byte 32	; Compare with ' '
				jz			inc_whitespace
				cmp			[rdi], byte 48	; Compare with '0'
				jge			checkifnum
checkifsign:
				cmp			[rdi], byte 43	; Compare with '+'.
				jz			plussign
				cmp			[rdi], byte 45	; Compare with '-'.
				jz			minussign
notnum:
				cmp			[rdi], byte 9	; Compare with '\t'
				jl			exit
				cmp			[rdi], byte 13	; Compare with carriage return
				jg			exit
				jmp			inc_whitespace

checkifnum:
				cmp			[rdi], byte 57	; Compare with '9'
				jle			number
				jmp			notnum

minussign:
				mov			qword [rsp], 1
plussign:
				inc			rdi
number:
				cmp			[rdi], byte 0	; Check for null-byte
				jz			numdone
				cmp			[rdi], byte 48
				jl			numdone
				cmp			[rdi], byte 57
				jg			numdone

				mov			qword rcx, 10
				mul			rcx				; 'mul' applies to the 'rax'
				jo			overflow
				movzx		rcx, byte [rdi]
				sub			rcx, 48
				add			rax, rcx
				jo			overflow
				inc			rdi
				jmp			number

overflow:
				mov			rax, -1
				cmp			qword [rsp], 0
				jz			exit
				mov			rax, 0
				jmp			exit

numdone:
				cmp			qword [rsp], 0
				jz			exit
				not			rax
				inc			rax

exit:
				mov			rsp, rbp	; Standard epilogue
				pop			rbp
				ret
