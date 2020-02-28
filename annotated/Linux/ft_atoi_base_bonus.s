# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_atoi_base_bonus.s                               :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/28 09:51:02 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/28 09:51:45 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_atoi_base, with annotated comments
; For Linux systems

; ft_atoi_base prototype: int	ft_atoi_base(char *str, char *base);

; rdi = str
; rsi = base

				global		ft_atoi_base
				extern		ft_strlen
				extern		ft_atoi
				extern		ft_strchr

				section		.text
ft_atoi_base:	push		rbp
				mov			rbp, rsp

				sub			rsp, 16		; Allocating the pointers onto
				mov			[rsp], rdi	; the stack, so rdi and rsi can
				sub			rsp, 16		; be used in function calls
				mov			[rsp], rsi
				xor			r8, r8
				xor			r9, r9
				xor			r10, r10

				call		ft_strlen	; strlen for 'str'.
				test		rax, rax	; ZF set to 1 if 'rax' is zero.
				jz			err			; Jump if ZF is set.

				mov			rdi, [rsp]	; Moving 'base' into 'rdi'.
				call		ft_strlen	; strlen for 'base'.
				test		rax, rax	; ZF set to 1 if 'rax' is zero.
				jz			err			; Jump if ZF is set.

		; Both strings have now been checked to see if they are empty strings.

check_base_sign:
				mov			rdi, [rsp]	; Move 'base' into 'rdi'
				mov			r11b, 43
				movzx		rsi, r11b
				call		ft_strchr	; Check for a '+' in 'base', if present,
										; exit.
				test		rax, rax
				jnz			err

				mov			rdi, [rsp]	; Move 'base' into 'rdi'
				mov			r11b, 45
				movzx		rsi, r11b
				call		ft_strchr	; Check for a '-' in 'base', if present,
										; exit.
				test		rax, rax
				jnz			err

		; Now ft_atoi will be run on 'base'.
				
				mov			rdi, [rsp]	; Moving 'base' into 'rdi'
				call		ft_atoi
				cmp			rax, 2		; Check that base isn't below 2
				jl			err
				cmp			rax, 36		; And that base isn't over 36
				jg			err
				
				sub			rsp, 16
				mov			[rsp], rax	; Move base value onto stack

		; Both strings have been checked to see if they are empty, and
		; the value of 'base' is now validated to be between 2 and 36

				mov			rdi, [rsp + 32]	; Moving 'str' into 'rdi'
				mov			rax, 0
				xor			r8, r8		; Set r8 to 0.
				jmp			skip_whitespace

inc_whitespace:
				inc			r8
skip_whitespace:
				cmp			BYTE [rdi + r8], 0
				je			exit
				cmp			BYTE [rdi + r8], 32	; Compare with ' '
				jz			inc_whitespace
				cmp			BYTE [rdi + r8], 9	; compare with '\t'
				jl			exit
				cmp			BYTE [rdi + r8], 13	; compare with '<CR>'
				jg			check_num
				jmp			inc_whitespace

check_num:
				movzx		r9, byte [rsp]		; Moving the value of base into
											; 'r9', so 'r9b' can be used for
											; math.
				cmp			BYTE [rdi + r8], 43	; Compare with '+'
				je			is_positive
				cmp			BYTE [rdi + r8], 45	; Compare with '-'
				je			is_negative
				sub			rsp, 16
				mov			rcx, 0
				mov			[rsp], rcx
				jmp			num_loop

is_negative:
				sub			rsp, 16
				mov			rcx, 1
				mov			[rsp], rcx
				jmp			inc_num_loop
is_positive:
				sub			rsp, 16
				mov			rcx, 1
				mov			[rsp], rcx
inc_num_loop:
				inc			r8
num_loop:
				mov			rdx, [rdi + r8]	; 'dl' will be used as
													; byte of 'str'
				test		dl, dl
				jz			exit			; Exit for null-terminator
				jmp			make_lower
check_in_base:
				cmp			r9b, 10
				jle			_0_to_9_
				jmp			_a_to_z_

_0_to_9_:
				mov			r10b, dl
				add			r9b, 47		; r9b is our 'base', the new r9b is the
										; max value that 'dl' can have
				cmp			r10b, r9b	; Compare our value with its maximum
										; "allowed" value.
				jg			err
				sub			r9b, 47
				mul			r9			; total *= 'r9' (our base)
				sub			r10b, 48
				add			rax, r10
				jmp			inc_num_loop

_a_to_z_:
				mov			r10b, dl
				cmp			r10b, 48	; Checking if byte is below '0' in ascii
				jl			err
				cmp			r10b, 57	; Checking if byte is over '9' in ascii
				jg			check_under_a
				jle			_0_to_9_big_base	; If the character is between
										;'0' and '9', it must be handled
										; differently.
over_a:
				add			r9b, 86		; If base 11, then 'a' is valid and
										; no more. 'r9b' in this case will match
										; up to 'a' in ascii.
				cmp			r10b, r9b	; Compare our value (r10b) with the
										; max "allowed" value.
				jg			err
										; We now know we have a valid char
										; in the 'a' to 'z' range.
				sub			r9b, 86
				mul			r9			; total *= 'r9' (our base)
				sub			r10b, 87	; gives 'a' a value of 10.
				add			rax, r10
				jmp			inc_num_loop

_0_to_9_big_base:
				mul			r9			; total *= 'r9' (our base)
				sub			r10b, 48	; gives 'a' a value of 10.
				add			rax, r10
				jmp			inc_num_loop
				

check_under_a:
				cmp			r10b, 97	; Checking if byte is under 'a' in ascii
				jl			err
				jmp			over_a

make_lower:
				cmp			dl, byte 'A'
				jl			check_in_base
				cmp			dl, byte 'Z'
				jg			check_in_base
				add			dl, 32			; Makes uppercase number lowercase
				jmp			check_in_base

err:			mov			rax, 0
				mov			rsp, rbp
				pop			rbp
				ret
exit:			
				mov			rcx, [rsp]
				test		rcx, rcx
				jnz			apply_sign
				mov			rsp, rbp
				pop			rbp
				ret

apply_sign:
				mov			rcx, 0
				mov			[rsp], rcx
				not			rax
				inc			rax
				jmp			exit
