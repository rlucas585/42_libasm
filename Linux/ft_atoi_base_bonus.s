# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_atoi_base.s                                     :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/24 11:56:14 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/05 23:36:26 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_atoi_base
; For Linux Systems

; ft_atoi_base prototype: int	ft_atoi_base(char *str, char *base);

; rdi = str
; rsi = base

				global		ft_atoi_base
				extern		ft_strlen
				extern		ft_atoi
				extern		ft_strchr

ft_atoi_base:	push		rbp
				mov			rbp, rsp

				sub			rsp, 16		; Stack allocations
				mov			[rsp], rdi
				sub			rsp, 16
				mov			[rsp], rsi
				xor			r8, r8
				xor			r9, r9
				xor			r10, r10

				call		ft_strlen	; strlen for 'str'.
				test		rax, rax
				jz			err			; if 'rax' == 0

				mov			rdi, [rsp]	; 'rdi' = base
				call		ft_strlen	; strlen for 'base'.
				test		rax, rax
				jz			err

		; Both strings checked to see if empty

check_base_sign:
				mov			rdi, [rsp]	; 'rdi' = base
				xor			rsi, rsi
				mov			sil, 43
				call		ft_strchr	; Check for a '+' in 'base'
				test		rax, rax
				jnz			err

				mov			rdi, [rsp]	; 'rdi' = base
				xor			rsi, rsi
				mov			sil, 45
				call		ft_strchr	; Check for a '-' in 'base'
				test		rax, rax
				jnz			err

		; No '+' or '-' in base

				mov			rdi, [rsp]	; 'rdi' = base
				
				mov			rdi, [rsp]	; 'rdi' = base
				call		ft_atoi
				cmp			rax, 2
				jl			err
				cmp			rax, 36
				jg			err
				
				sub			rsp, 16
				mov			[rsp], rax	; Move base value onto stack

		; base is between 2 and 36

				mov			rdi, [rsp + 32]	; 'rdi' = str
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
				movzx		r9, byte [rsp]		; r9 = base
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
				mov			rdx, [rdi + r8]	; 'dl' = str[i]
				test		dl, dl
				jz			exit			; Exit if str[i] = '\0'
				jmp			make_lower
check_in_base:
				cmp			r9b, 10
				jle			_0_to_9_
				jmp			_a_to_z_

_0_to_9_:
				mov			r10b, dl
				add			r9b, 47
				cmp			r10b, r9b
				jg			err
				sub			r9b, 47
				mul			r9			; total *= 'r9' (base)
				sub			r10b, 48
				add			rax, r10
				jmp			inc_num_loop

_a_to_z_:
				mov			r10b, dl
				cmp			r10b, 48
				jl			err
				cmp			r10b, 57
				jg			check_under_a
				jle			_0_to_9_big_base
over_a:
				add			r9b, 86
				cmp			r10b, r9b
				jg			err
				sub			r9b, 86
				mul			r9			; total *= 'r9' (our base)
				sub			r10b, 87	; gives 'a' a value of 10.
				add			rax, r10
				jmp			inc_num_loop

_0_to_9_big_base:
				mul			r9			; total *= 'r9' (our base)
				sub			r10b, 48
				add			rax, r10
				jmp			inc_num_loop
				

check_under_a:
				cmp			r10b, 97
				jl			err
				jmp			over_a

make_lower:
				cmp			dl, byte 'A'
				jl			check_in_base
				cmp			dl, byte 'Z'
				jg			check_in_base
				add			dl, 32
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
