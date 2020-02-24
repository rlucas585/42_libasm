# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_atoi_base.s                                     :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/24 11:56:14 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/24 17:23:00 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_atoi_base, with annotated comments

; ft_atoi_base prototype: int	ft_atoi_base(char *str, char *base);

; rdi = str
; rsi = base

				global		_ft_atoi_base
				extern		_ft_strlen

				section		.data
validchars:		db			"+-0123456789abcdefghijklmnopqrstuvwxyz", 0x00

				section		.text
_ft_atoi_base:	push		rbp
				mov			rbp, rsp

				sub			rsp, 16		; Allocating the pointers onto
				mov			[rsp], rdi	; the stack, so rdi and rsi can
				sub			rsp, 16		; be used in function calls
				mov			[rsp], rsi

				call		_ft_strlen	; strlen for 'str'.
				test		rax, rax	; ZF set to 1 if 'rax' is zero.
				jz			err			; Jump if ZF is set.

				mov			rdi, [rsp]	; Moving 'base' into 'rdi'.
				call		_ft_strlen	; strlen for 'base'.
				test		rax, rax	; ZF set to 1 if 'rax' is zero.
				jz			err			; Jump if ZF is set.

		; Both strings have now been checked to see if they are empty strings.
				mov			rax, 15
				mov			rsp, rbp
				pop			rbp
				ret


err:			mov			rax, 0
				mov			rsp, rbp
				pop			rbp
				ret
