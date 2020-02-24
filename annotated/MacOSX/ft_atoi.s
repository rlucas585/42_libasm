# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_atoi.s                                          :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/24 12:24:14 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/24 17:19:49 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_atoi, with annotated comments

; ft_atoi prototype: int	ft_atoi_base(const char *str);

; rdi = str

				global		_ft_atoi

_ft_atoi:		push		rbp			; Standard prologue
				mov			rbp, rsp

				sub			rsp, 16
				mov			[rsp], rdi	; Saving initial pointer.
				sub			rsp, 16
				mov			qword [rsp], 0	; Allocating space for 'sign'
										; variable.
										; Which will be 1 for negative numbers,
										; and 0 for positive numbers.

			; In the above code, qword must be used to specify that 64-bits
			; are being used.

				mov			qword rax, 0	; Initialise return value to 0.
				dec			rdi				; Reduce pointer by 1 to allow inc
											; 'rdi' at the start of the loop.

whitespace:		inc			rdi
				cmp			[rdi], byte 0	; compare for null byte
				jz			exit			; String's first non-whitespace is
											; not a number.
				cmp			[rdi], byte 32	; Compare with space
				jz			whitespace
				cmp			[rdi], byte 48	; Compare with '0'
				jge			checkifnum
checkifsign:	cmp			[rdi], byte 43	; Compare with '+'.
				jz			plussign
				cmp			[rdi], byte 45	; Compare with '-'.
				jz			minussign
notnum:			cmp			[rdi], byte 9	; Compare with tab
				jl			exit			; String's first non-whitespace is
											; not a number.
				cmp			[rdi], byte 13	; Compare with carriage return
				jg			exit			; String's first non-whitespace is
											; not a number.
				jmp			whitespace		; Return to start of loop

checkifnum:		cmp			[rdi], byte 57	; Compare with '9'
				jle			number			; rdi has reached numbers in string
				jmp			notnum

minussign:		mov			qword [rsp], 1	; Sets 'sign' to 1 if number is
											; negative
plussign:		inc			rdi				; Increment pointer.
number:			cmp			[rdi], byte 0	; Check for null-byte
				jz			numdone
				cmp			[rdi], byte 48
				jl			numdone
				cmp			[rdi], byte 57
				jg			numdone

				mov			qword rcx, 10
				mul			rcx				; 'mul' applies to the 'rax'
											; register by default.
				jo			overflow
				movzx		rcx, byte [rdi]		; Move current byte into 'rcx'
											; 'movzx' means move with zeroes -
											; allowing a byte value to be moved
											; into a 64-bit register.
				sub			rcx, 48			; Subtract 48 to convert character
											; to integer.
				add			rax, rcx		; Add to total
				jo			overflow
				inc			rdi
				jmp			number			; Restart loop

overflow:		mov			rax, -1
				cmp			qword [rsp], 0
				jz			exit
				mov			rax, 0
				jmp			exit

numdone:		cmp			qword [rsp], 0	; Check if 'sign' == 0, if not,
											; make return value negative.
				jz			exit
				not			rax				; Reverse all bits in 'rax', making
											; it negative.
				inc			rax				; When bits are reversed, the
											; negative number is 1 greater than
											; the positive (due to 0).

exit:			mov			rsp, rbp	; Standard epilogue
				pop			rbp
				ret
