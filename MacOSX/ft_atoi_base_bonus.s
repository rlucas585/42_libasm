# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_atoi_base.s                                     :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/24 11:56:14 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/12 11:21:36 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_atoi_base

; ft_atoi_base prototype: int	ft_atoi_base(char *str, char *base);

; rdi = str
; rsi = base

				global		_ft_atoi_base
				extern		_ft_strlen
				extern		_ft_atoi
				extern		_ft_strchr

				section		.data
%define			STR			[rbp - 48]
%define			BASE		[rbp - 40]
%define			SIGN		[rbp - 32]

				section		.text
_ft_atoi_base:	push		rbp
				mov			rbp, rsp

				push		r12			; Will be used to store length of base
				push		r13			; Return value
				push		r14			; Increment over 'str'

				sub			rsp, 8
				xor			rcx, rcx
				mov			[rsp], rcx	; SIGN variable
				sub			rsp, 8
				mov			[rsp], rsi	; BASE variable
				sub			rsp, 8
				mov			[rsp], rdi	; Address of 'str'

				call		_ft_strlen
				test		rax, rax
				jz			err

				mov			rdi, BASE	; rdi = 'base'
				call		_ft_strlen
				test		rax, rax
				jz			err

		; Both strings checked to see if empty

check_base_sign:
				mov			rdi, BASE	; 'rdi' = base
				xor			rsi, rsi
				mov			sil, 43
				call		_ft_strchr	; Check for a '+' in 'base'
				test		rax, rax
				jnz			err

				mov			rdi, BASE	; 'rdi' = base
				xor			rsi, rsi
				mov			sil, 45
				call		_ft_strchr	; Check for a '-' in 'base'
				test		rax, rax
				jnz			err

		; No '+' or '-' in base

				xor			r12, r12
				mov			SIGN, r12
check_no_dup:
				mov			rdi, BASE	; 'rdi' = base
				cmp			BYTE [rdi + r12], 0
				je			atoi_begin
				movzx		rsi, BYTE [rdi + r12]
				add			rdi, r12
				inc			rdi
				call		_ft_strchr	; Call ft_strchr from character after
										; current, to check for dup
				test		rax, rax
				jnz			err
				inc			r12
				jmp			check_no_dup

atoi_begin:
				cmp			r12, 1		; Check that base is over 1
				jle			err
				mov			rdi, [rsp]	; 'rdi' = str
				mov			rax, 0
				xor			r14, r14	; Set r14 to 0.

check_num:
				cmp			BYTE [rdi + r14], 43	; Compare with '+'
				je			is_positive
				cmp			BYTE [rdi + r14], 45	; Compare with '-'
				je			is_negative
				mov			qword SIGN, 0
				jmp			num_loop

is_negative:
				mov			qword SIGN, 1
				jmp			inc_num_loop
is_positive:
				mov			qword SIGN, 0
inc_num_loop:
				inc			r14
num_loop:
				mov			rdi, STR
				mov			rsi, [rdi + r14]	; 'sil' = str[i]
				test		sil, sil
				jz			exit			; Exit if str[i] = '\0'
				mov			qword rdi, BASE
				call		_ft_strchr		; find str[i] in base
				test		rax, rax
				jz			err
				sub			rax, BASE		; len to char str[i] in
											; strchr of base.
				mov			rcx, rax
				mov			rax, r13
				mul			r12
				add			rax, rcx
				mov			r13, rax
				jmp			inc_num_loop

err:
				mov			rax, 0
				jmp			no_sign
exit:			
				mov			rax, r13
				mov			rcx, SIGN
				cmp			rcx, 0
				je			no_sign
				not			rax
				inc			rax
no_sign:
				add			rsp, 24
				pop			r14
				pop			r13
				pop			r12
				mov			rsp, rbp
				pop			rbp
				ret

