# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_write.s                                         :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/19 15:56:05 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/22 00:52:14 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; This is the assembly language ft_write, with annotated comments.
; This version is for Linux systems, rather than MacOSX

; See the MacOSX variant for more extensive annotation

			global		ft_write

ft_write:	mov			rax, 1	; The system call for write on Linux
			syscall
			cmp			rax, 0
			jl			err
			ret

err:		mov			rax, -1
			ret
