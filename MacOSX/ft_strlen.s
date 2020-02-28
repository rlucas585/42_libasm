# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strlen.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 12:20:10 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/28 17:26:25 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_strlen

; ft_strlen prototype: size_t	ft_strlen(const char *s);

			global		_ft_strlen

_ft_strlen:	push		rbp
			mov			rbp, rsp
			mov			al, 0
			mov			rcx, -1
			cld
			repne		scasb
			not			rcx
			dec			rcx
			mov			rax, rcx
			mov			rsp, rbp
			pop			rbp
			ret
