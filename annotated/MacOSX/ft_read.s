# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_read.s                                          :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 10:39:44 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/20 13:37:40 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; This is the assembly language ft_read, with annotated comments.

; Most of the information from ft_write holds true here also.
; The arguments 'rdi', 'rsi' and 'rdx' are already passed to our function,
; so all that must be done is to set the correct code to call read from the
; system, and check that no error occurs.

			global		_ft_read

_ft_read:	mov			rax, 0x2000003	; System call for read on Mac OSX
			syscall						; Execute the system call
			jc			err				; Jump to 'err' if error in reading.
			ret							; return to parent function

err:		mov			rax, -0x01		; Set return value to -1
			ret							; return to ft_read
