# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strcmp.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <ryanl585codam@gmail.com>             +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/22 00:56:40 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/12 12:29:22 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_strcmp

; ft_strcmp prototype: int	ft_strcmp(const char *s1, const char *s2);

; rdi = s1
; rsi = s2

			global		_ft_strcmp

_ft_strcmp:	
			push		rbp
			mov			rbp, rsp

loop:
			xor			al, al
			mov			al, byte [rdi]
			sub			al, byte [rsi]
			cmp			[rdi], byte 0
			je			diff
			cmp			al, 0
			jne			diff
			inc			rsi
			inc			rdi
			jmp			loop

diff:		
			movsx		rax, byte al
			mov			rsp, rbp
			pop			rbp
			ret
