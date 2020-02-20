# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Makefile                                           :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 10:00:23 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/20 17:18:58 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

ASM = ft_write.s \
	  ft_read.s \
	  ft_strlen.s \
	  ft_strcpy.s

SRC = main.c

ASMOBJ = $(ASM:.s=.o)

OBJ = $(SRC:.c=.o) 

LIBRARY = libasm.h

FLAGS = -Wall -Wextra -Werror

all: $(OBJ) $(ASMOBJ)
	@gcc $(FLAGS) -I. -o testexec $(OBJ) $(ASMOBJ)

$(OBJ): $(SRC) $(LIBRARY)
	@gcc -c $(FLAGS) -I. $<

$(ASMOBJ): $(ASM)
	@nasm -fmacho64 -o $@ $(patsubst %.o,%.s,$@)

clean:
	@rm -f $(OBJ) $(ASMOBJ)

fclean: clean
	@rm -f testexec

re: fclean all

.PHONY: clean fclean all re
