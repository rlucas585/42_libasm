# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ex9.s                                              :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/19 10:19:50 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/19 11:18:13 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Arguments in x86 are passed onto the STACK

; In the example below, the argument '21' is pushed onto the stack to be used
; in the function 'times2'

			global		_main

			section		.text
_main:		
			push		255
			call		times2		; Remember that call will push a return
									; address onto the stack as well!
			mov			rdi, rax	; Putting the return value of the function
									; times2 into the exit status register.
			mov			rax, 0x2000001
			syscall
			

times2:		push		rbp			; Preserve old base pointer in case other
									; code was using it, although unnecessary
									; in this case.
			mov			rbp, rsp	
			mov			rax, [rbp + 16]	; putting the value of the 'argument'
									; into a register for use.
			add			rax, rax	; Adding argument to itself (times 2)
			mov			rsp, rbp	; This line is unnecessary here, as we
									; didn't use the stack, but it is good
									; practice to include it.
			pop			rbp
			ret

; This code took a very long time to debug, because I used the wrong number of
; 0's in the system call code. IT'S 5 ZEROES ALWAYS MAKE SURE!
