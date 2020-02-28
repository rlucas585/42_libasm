# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Makefile                                           :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 10:00:23 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/28 14:44:04 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

#-------------------------Find Operating System---------------------------------

OS := $(shell uname)
ifeq ($(OS),Linux)
	DIR = Linux/
else
	DIR = MacOSX/
endif

#-----------------------------Select sources------------------------------------

ASM = $(DIR)ft_write.s \
	  $(DIR)ft_read.s \
	  $(DIR)ft_strlen.s \
	  $(DIR)ft_strcpy.s \
	  $(DIR)ft_strcmp.s \
	  $(DIR)ft_strdup.s \
	  $(DIR)ft_atoi_bonus.s \
	  $(DIR)ft_atoi_base_bonus.s \
	  $(DIR)ft_strchr_bonus.s \
	  $(DIR)ft_list_push_front_bonus.s \
	  $(DIR)ft_list_size_bonus.s \
	  $(DIR)ft_list_sort_bonus.s \
	  $(DIR)ft_list_remove_if_bonus.s
SRC = main.c

#----------------------------Select Objects-------------------------------------

ODIR = obj/
ASMOBJ = $(patsubst $(DIR)%.s,$(ODIR)%.o,$(ASM))
OBJ = $(ODIR)$(SRC:.c=.o) 

#------------------------Library and Flags definitions--------------------------

LIBRARY = libasm.h
FLAGS = -Wall -Wextra -Werror
ifeq ($(OS),Linux)
	FLAGS += -no-pie
endif

#--------------------------Compile test executable------------------------------

all: $(OBJ) $(ASMOBJ)
	@gcc $(FLAGS) -I. -o testexec $(OBJ) $(ASMOBJ)

#-------------Create and fill objects directory with main.c source--------------

$(OBJ): $(SRC) $(LIBRARY)
	@mkdir -p $(ODIR)
	@gcc -c -o $@ $(FLAGS) -I. $<

#-------------Create and fill objects directory with assembly sources-----------

$(ASMOBJ): $(ASM)
	@mkdir -p $(ODIR)
ifeq ($(OS),Linux)
	@nasm -felf64 -o $@ $(patsubst $(ODIR)%.o,$(DIR)%.s,$@)
else
	@nasm -fmacho64 -o $@ $(patsubst $(ODIR)%.o,$(DIR)%.s,$@)
endif

#------------------------Utility Make Instructions------------------------------

clean:
	@rm -f $(OBJ) $(ASMOBJ)

fclean: clean
	@rm -f testexec

re: fclean all

#-----------------------------Phony instructions--------------------------------

.PHONY: clean fclean all re
