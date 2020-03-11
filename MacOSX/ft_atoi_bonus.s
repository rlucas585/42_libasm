# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_atoi_bonus.s                                    :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/27 23:26:50 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/11 19:38:46 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_atoi

; ft_atoi prototype: int	ft_atoi_base(const char *str);

; rdi = str

				global		_ft_atoi

				section		.data
%define			SIGN		[rbp - 8]

				section		.text
_ft_atoi:
				push		rbp			; Standard prologue
				mov			rbp, rsp

				sub			rsp, 8
				mov			qword [rsp], 0	; Stack allocation of 'sign'
											; 1 for negative numbers,
											; and 0 for positive numbers.
				xor			rax, rax
				xor			rcx, rcx
				mov			qword SIGN, 0
				jmp			whitespace

inc_whitespace:
				inc			rcx
whitespace:
				cmp			[rdi + rcx], byte 0	; compare for '\0'
				jz			exit
				cmp			[rdi + rcx], byte 32	; Compare with ' '
				jz			inc_whitespace
				cmp			[rdi + rcx], byte 48	; Compare with '0'
				jge			checkifnum
checkifsign:
				cmp			[rdi + rcx], byte 43	; Compare with '+'.
				jz			plussign
				cmp			[rdi + rcx], byte 45	; Compare with '-'.
				jz			minussign
notnum:
				cmp			[rdi + rcx], byte 9	; Compare with '\t'
				jl			exit
				cmp			[rdi + rcx], byte 13; Compare with carriage return
				jg			exit
				jmp			inc_whitespace

checkifnum:
				cmp			[rdi + rcx], byte 57	; Compare with '9'
				jle			number
				jmp			notnum

minussign:
				mov			qword SIGN, 1
plussign:
				inc			rcx
number:
				cmp			[rdi + rcx], byte 0	; Check for null-byte
				jz			numdone
				cmp			[rdi + rcx], byte 48
				jl			numdone
				cmp			[rdi + rcx], byte 57
				jg			numdone

				mov			qword rdx, 10
				mul			rdx				; 'mul' applies to the 'rax'
				jo			overflow
				cmp			rax, 2147483647
				jge			check_32_overflow
no_overflow:
				movzx		rdx, byte [rdi + rcx]
				sub			rdx, 48
				add			rax, rdx
				jo			overflow
				inc			rcx
				jmp			number

check_32_overflow:
				cmp			qword SIGN, 0
				je			overflow
				mov			r8, qword 2147483648
				cmp			rax, r8
				jge			overflow
				jmp			no_overflow


overflow:
				mov			rax, -1
				cmp			qword SIGN, 0
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
