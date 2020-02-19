# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ex11.s                                             :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/19 15:16:51 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/19 15:22:02 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

			global		_add42
			
			section		.text
_add42:		push		rbp
			mov			rbp, rsp
			mov			rax, rdi
			add			rax, 42
			mov			rsp, rbp
			pop			rbp
			ret
