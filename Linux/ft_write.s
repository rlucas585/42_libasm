# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_write.s                                         :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/19 15:56:05 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/05 23:41:48 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly ft_write
; For Linux Systems

; ft_write prototype:
; ssize_t	ft_write(int fildes, void *buf, size_t nbyte);

			global		ft_write

ft_write:	mov			rax, 1
			syscall
			jc			err
			ret

err:		mov			rax, -0x01
			ret
