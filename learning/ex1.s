# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ex1.asm                                            :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/14 17:09:51 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/19 09:29:01 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

		global		_main

		section		.text
_main:	mov			rax, 0x2000004
		mov			rdi, 1
		mov			rsi, msg
		mov			rdx, len
		syscall
		mov			rax, 0x2000001
		mov			rdi, 0
		syscall

		section		.data
msg		db			"Now it's supa dupa mega long", 0x0a
len		equ			$ - msg
