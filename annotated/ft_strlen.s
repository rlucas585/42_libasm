# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strlen.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 12:20:10 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/20 17:02:23 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; This is the assembly language ft_strlen, with annotated comments.

; In this example, we use a couple new concepts.
; The 'push rbp', 'mov rbp, rsp' lines are more important in 32-bit systems,
; where local variables are stored on the stack by the parent function.

; In 32-bit, we must use a pointer to the stack to access our parameters.
; In this case, we must push our old base pointer onto the stack, so that it
; can be restored should we make nested function calls, this is the reason for
; the 'push rbp' and 'mov rbp, rsp' lines, also known as the function 'prologue'
; , and the similar instructions at the end, known as the function 'epilogue'.

; While not strictly necessary in this case, the prologue and epilogue are
; included below.

; Of greater importance is the five new instructions: 'cld', 'repne', 'scasb'
; 'not' and 'dec'.

; dec: Decrement one from the register supplied.

; cld: Clears the direction flag (DF) in the EFLAGS register
; When this flag is set to 0, string operations (such as 'scasb') will 
; INCREMENT the index registers ('rsi' and/or 'rdi').

; not: Performs a bitwise NOT operation, setting all '1's to '0' and all
; '0's to '1' on the destination operand. This has the effect of turning a 
; negative integer into a positive, and vice-versa, when the TWO'S COMPLEMENT
; method of representing numbers is used
; (see https://softwareengineering.stackexchange.com/questions/239036/
; how-are-negative-signed-values-stored for reference).

; repne: One of a family of instructions called 'Repeat String Operations'.
; This particular instruction is to 'repeat the string instruction the number
; of times specified in the count register (rcx) OR until the indicated
; condition'. In the case below, by initialising 'rcx' to -1, we can ensure that
; rcx will never be zero, thus giving us an accurate count, albeit negative.
; This negative count is then made positive by using the 'not' instruction.

; scasb: 'Scan string for byte', moves through a string by byte increments
; looking for the byte that is stored in the register 'al'. In the case of
; strlen, this is 0.

			global		_ft_strlen

			section		.text
_ft_strlen:	push		rbp
			mov			rbp, rsp
			mov			al, 0
			mov			rcx, -1
			cld
			repne		scasb
			not			rcx
			dec			rcx
			mov			rax, rcx
			mov			rsp, rbp
			pop			rbp
			ret

; For the repeat prefix 'repne/repnz', the termination conditions are rcx=0,
; and ZF = 1

; Introduction to the Flag Register

; The Flag register is a bit register, with only 8 bits.
; The bits are: "S Z X AC X P X CY"

; The X are not used. The flag definitions are:

; S = Sign flag, S = 1 if MSB (Most Significant Bit) of ALU (Arithmetic/Logic
; Unit) is 1 ie, if the number is a negative number.

; Z = Zero flag, Z = 1 if the ALU result is 0 (00H = 0 in hexadecimal).

; P = Parity flag, P = 1 if the ALU result is even parity - ie 1 if the result
; is even, 0 if the result is odd.

; CY = Carry flag, this is used for UNSIGNED arithmetic, and tells you nothing
; for signed arithmetic. CY = 1 if the addition of two unsigned numbers takes
; causes a carry out of the most significant bit (the leftmost bit).
; e.g. if 1111 + 0001 = 0000 and the carry flag is turned on.
; The overflow flag is similar, but turned on if the carry affects the most
; significant bit, hence why it is only significant for signed integers.
; In Mac OSX - the Carry Flag is also used if an error occurs during system
; calls.
; the 'jc' instruction means 'jump if the carry flag is set'.

; AC = Auxiliary Carry -> only used by the computer, not relevant for the
; programmer.

; Additional flags:
; There appear to be flags outside of the Flag register, the Overflow flag
; being one of them (O);
