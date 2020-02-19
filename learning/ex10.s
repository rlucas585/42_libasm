# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ex10.s                                             :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/19 11:18:19 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/19 15:10:07 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; In this example, gcc is used as the linker instead of ld.
; An interesting point is that in C the _start is defined, the code must
; provide a main().
; For this reason, the function used in this example is 'main', and the
; assembly begins with 'global main'.

			global		_main
			extern		_printf	; Tells nasm that printf is expected to be an
								; external symbol

			section		.data
msg:		db			"Testing %i...", 0x0a, 0x00
						; %i will be replaced by an integer that we supply to
						; printf. The 0x0a here is for a newline character, to
						; be printed after the format string.
						; 0x00 is 0 in hex, to tell printf that the string
						; is terminated, this isn't handled automatically
						; in assembly.

			section		.text
_main:		push		rbp
			mov			rbp, rsp
			mov			rdi, msg
			mov			rsi, 123
			call		_printf
			mov			rax, 0
			mov			rsp, rbp
			pop			rbp
			ret
