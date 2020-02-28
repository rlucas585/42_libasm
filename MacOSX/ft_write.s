# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_write.s                                         :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/19 15:56:05 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/28 17:27:46 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_write

; ft_write prototype:
; ssize_t	ft_write(int fildes, void *buf, size_t nbyte);

			global		_ft_write

_ft_write:	mov			rax, 0x2000004
			syscall
			jc			err
			ret

err:		mov			rax, -0x01
			ret
