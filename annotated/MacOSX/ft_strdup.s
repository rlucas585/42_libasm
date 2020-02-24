# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_strdup.s                                        :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/24 11:20:21 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/24 11:58:08 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_strdup, with annotated comments

; I kept allocating only an empty string for this exercise, and troubleshooting
; was very difficult - eventually, mostly just through testing things, I found
; that by using 'mov r8, rdi' to store the pointer to the original string 
; instead of 'mov rdx, rdi', the function would work correctly.

; What I was attempting to do was to save a value that I was going to need later
; on, HOWEVER, saving values in a function using registries is NOT A GOOD
; PRACTICE - anytime that a function is called it is possible it might use
; that register, and overwrite whatever value you were trying to save.
; I suspect that this is what was occurring when I was using 'mov rdx, rdi',
; and that malloc (or something else), was using the 'rdx' register, removing
; my original pointer and leaving me with an empty string.

; The lesson to be learned from this - is to store values that you might need
; on the stack, not on registers. The second version of ft_strdup in this file
; uses this method - while both versions work, the second is much more
; responsible.

; VERSION 1: Using r8 to store pointer to original string ('s').

; ft_strdup prototype: char	*ft_strdup(const char *s);

; rdi = s

; 			global		_ft_strdup
; 			extern		_malloc
; 			extern		_ft_strlen
; 			extern		_ft_strcpy
;
; _ft_strdup:	push		rbp
; 			mov			rbp, rsp
;
; 			mov			r8, rdi	; THIS LINE DOES WORK
; 			; mov			rdx, rdi	; THIS LINE DOESN'T WORK
;
; 			call		_ft_strlen	; places len into rax
; 			; mov			rdx, rdi	; We need to use 'rdi' for our malloc call,
; 									; but it currently contains our string to
; 									; be duplicated, so we copy the address of
; 									; the string into rdx for later use
; 			mov			rdi, rax	; Place len into rdi for malloc call.
;
; 			inc			rdi
; 			call		_malloc		; Call malloc and allocate 'len' bytes
; 			cmp			rax, 0		; Check to see if malloc failed, 'rax' now
; 									; contains the address of the newly
; 									; allocated memory or NULL if malloc failed.
; 			je			err			; jump if rax was 0.
; 									; The original string now needs to be
; 									; register 'rsi', and the address of the
; 									; new string to 'rdi', to call ft_strcpy.
; 			mov			rdi, rax	; Move the pointer to the new address in
; 									; rax to rdi, ready for ft_strcpy.
;
; 			; mov			rsi, rdx	; THIS LINE DOESN'T WORK
; 			mov			rsi, r8	; THIS LINE DOES WORK
; 									; Pointer to 's' was moved to 'rdx' earlier
; 									; memory to rdi for ft_strcpy
;
; 			call		_ft_strcpy	; 'rax' still contains pointer to the new
; 									; memory address.
; err:		mov			rsp, rbp	; 'rax' will either contain pointer to
; 									; NULL or the new memory address
; 			pop			rbp
; 			ret

; VERSION 2: Using the stack to store pointer to original string ('s').

			global		_ft_strdup
			extern		_malloc
			extern		_ft_strlen
			extern		_ft_strcpy

_ft_strdup:	push		rbp
			mov			rbp, rsp

			sub			rsp, 16
			mov			[rsp], rdi	; We need to use 'rdi' for our malloc call,
									; but it currently contains our string to
									; be duplicated, so we copy the address of
									; the string onto the stack.

			call		_ft_strlen	; places len into rax
			mov			rdi, rax	; Place len into rdi for malloc call.

			inc			rdi			; Add one to rdi for NULL-terminator in
									; output string.
			call		_malloc		; Call malloc and allocate 'len' bytes
			cmp			rax, 0		; Check to see if malloc failed, 'rax' now
									; contains the address of the newly
									; allocated memory or NULL if malloc failed.
			je			err			; jump if rax was 0.
									; The original string now needs to be
									; register 'rsi', and the address of the
									; new string to 'rdi', to call ft_strcpy.
			mov			rdi, rax	; Move the pointer to the new address in
									; rax to rdi, ready for ft_strcpy.
			mov			rsi, [rsp]	; Pointer to 's' was moved to stack earlier
			add			rsp, 16		; for preservation, now it is moved to
									; rsi, ready for the call to ft_strcpy.

			call		_ft_strcpy	; 'rax' still contains pointer to the new
									; memory address.
err:		mov			rsp, rbp	; 'rax' will either contain pointer to
									; NULL or the new memory address
			pop			rbp
			ret
