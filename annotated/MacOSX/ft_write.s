# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_write.s                                         :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/19 15:56:05 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/24 17:38:09 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; This is the assembly language ft_write, with annotated comments.

; When a function is called in assembly, the 'calling convention' determines
; how it's parameters shall be passed to it.
; In 32-bit (I'm pretty sure), this is done by passing the parameters on the
; stack. In 64-bit, the calling convention is to pass the arguments by the
; registers 'rdi', 'rsi', 'rdx', 'rcx', 'r8' and 'r9'.

; write's prototype is ssize_t	write(int fildes, void *buf, size_t n)
; where rdi:fildes, rsi:buf and rdx:n

; In our ft_write however, we don't even need to worry about which arguments
; are stored where, as they are already in the correct place for our system
; call when ft_write is called from it's parent function.

; When using system calls, the system call value must be passed into the
; 'rax' register. 'rax' is also where the return value from a function is
; to be placed prior to the function ending.

; If there is any issues executing the system call, then the carry flag in
; the flag register will be set - this can then be checked with the 'jc'
; instruction, which means 'jump to this location if the carry flag is set'.
; Thus, if there is an error while executing write, we move to the label 'err',
; where the return value for the function is set to '-1' (-0x01 in hex).

; rdi = fd
; rsi = buf
; rcx = n

			global		_ft_write

_ft_write:	mov			rax, 0x2000004	; The system call for write on Mac OSX
			syscall						; Execute the system call
			jc			err				; Jump to 'err' if error in writing.
			ret							; return to parent function

err:		mov			rax, -0x01		; Set return value to -1
			ret							; return to _ft_write
