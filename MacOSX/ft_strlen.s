# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strlen.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 12:20:10 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/12 12:47:46 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_strlen

; ft_strlen prototype: size_t	ft_strlen(const char *s);

			global		_ft_strlen

_ft_strlen:
			push		rbp
			mov			rbp, rsp
			xor			rax, rax
loop:
			mov			cl, BYTE [rdi + rax]
			test		cl, cl
			jz			exit
			inc			rax
			jmp			loop

exit:
			mov			rsp, rbp
			pop			rbp
			ret
