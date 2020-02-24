# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strlen.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 12:20:10 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/22 11:54:44 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; This is the assembly language ft_strlen, with annotated comments.
; This version is for Linux systems, rather than MacOSX

; See the MacOSX variant for more extensive annotation

; rdi = str

			global		ft_strlen	; In Linux, the function does not require
									; an underscore '_' at the start

			section		.text
ft_strlen:	push		rbp
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
