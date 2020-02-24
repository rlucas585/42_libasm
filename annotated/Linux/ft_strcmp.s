# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strcmp.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <ryanl585codam@gmail.com>             +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/22 00:56:40 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/22 10:43:28 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_strcmp, with annotated comments
; This version is for Linux systems, rather than MacOSX

; ft_strcmp prototype: int	ft_strcmp(const char *s1, const char *s2);

; rdi = s1
; rsi = s2

			global		ft_strcmp

ft_strcmp:	push		rbp
			mov			rbp, rsp
loop:		mov			al, 0
			mov			al, [rdi]
			sub			al, [rsi]
			cmp			[rdi], byte 0
			je			diff
			cmp			[rsi], byte 0
			je			diff
			cmp			al, 0
			jne			diff
			inc			rsi
			inc			rdi
			jmp			loop
diff:		mov			rsp, rbp
			pop			rbp
			movsx		rax, byte al
			ret

; So many things went wrong while writing this function.
; Firstly, I was using 'rax' as the register to store the values from the char
; comparisons - this isn't appropriate, as 'rax' is a 64-bit register, and
; when comparing bytes (chars), we only need to use 8-bits. For this reason I
; switched to using the 'ah' register.

; But THEN, I was getting a new error, 'cannot use high register in rex
; instruction'. From http://www.felixcloutier.com/x86/MOV.html: "In 64-bit mode,
; r/m8 can not be encoded to access the following byte registers if a REX prefix
; is used: 'AH' 'BH' 'CH' 'DH'". These 'high-byte registers' will be redefined
; to DIL, SIL, BPL and SPL if a REX prefix is present (see below).

; So I had to change my register from 'ah' to 'al', and that was the solution.

; Instructions with a REX prefix are:
; - anything with the R8..R15 regs and parts thereof.
; - anthing that accesses the new 8 bit regs: DIL, SIL, BPL, SPL
; - anything that accesses the 64 bit registers

; For a long time I also thought that I was using the 'cmp' or 'je' instructions
; incorrectly, and I probably was, but all works properly now.
