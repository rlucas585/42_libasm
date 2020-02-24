# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_read.s                                          :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 10:39:44 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/22 00:52:41 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; This is the assembly language ft_read, with annotated comments.
; This version is for Linux systems, rather than MacOSX

; See the MacOSX variant for more extensive annotation

			global		ft_read			; No underscore '_' in linux asm

ft_read:	mov			rax, 0	; System call for read on Linux
			syscall
			cmp			rax, 0
			jl			err
			ret

err:		mov			rax, -0x01
			ret
