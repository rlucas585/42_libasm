# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_read.s                                          :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 10:39:44 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/28 17:18:51 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_read

; ft_read prototype:
; ssize_t	ft_read(int fildes, void *buf, size_t nbyte);

			global		_ft_read

_ft_read:	mov			rax, 0x2000003
			syscall
			jc			err
			ret

err:		mov			rax, -0x01
			ret
