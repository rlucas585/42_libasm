# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Makefile                                           :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 10:00:23 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/28 18:16:35 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

NAME = libasm.a

DIR = MacOSX/

TESTEXEC = testexec

#-----------------------------Select sources------------------------------------

ASM = $(DIR)ft_write.s \
	  $(DIR)ft_read.s \
	  $(DIR)ft_strlen.s \
	  $(DIR)ft_strcpy.s \
	  $(DIR)ft_strcmp.s \
	  $(DIR)ft_strdup.s \

BONUS = $(DIR)ft_atoi_bonus.s \
		$(DIR)ft_atoi_base_bonus.s \
		$(DIR)ft_strchr_bonus.s \
		$(DIR)ft_list_push_front_bonus.s \
		$(DIR)ft_list_size_bonus.s \
		$(DIR)ft_list_sort_bonus.s \
		$(DIR)ft_list_remove_if_bonus.s

ifdef WITH_BONUS
	ASM += $(BONUS)
endif

SRC = tests.c

#----------------------------Select Objects-------------------------------------

ODIR = obj/
ASMOBJ = $(patsubst $(DIR)%.s,$(ODIR)%.o,$(ASM))
OBJ = $(ODIR)$(SRC:.c=.o) 
ALLOBJ = $(patsubst $(DIR)%.s,$(ODIR)%.o,$(SRC)$(ASM)$(BONUS))

#------------------------Library and Flags definitions--------------------------

LIBRARY = libasm.h
FLAGS = -Wall -Wextra -Werror

#------------------------------Compile Library----------------------------------

all: $(NAME)

$(NAME): $(ASMOBJ)
	@ar -rc $(NAME) $(ASMOBJ)

#-----------------------------Compile with bonus--------------------------------

bonus:
	@$(MAKE) WITH_BONUS=1 all

bonustest:
	@$(MAKE) WITH_BONUS=1 test

#--------------------------Compile test executable------------------------------

test: $(OBJ) $(NAME)
ifdef WITH_BONUS
	@gcc $(FLAGS) -I. -o $(TESTEXEC) $(OBJ) -L. -lasm -lcriterion
else
	@gcc $(FLAGS) -I. -o $(TESTEXEC) $(OBJ) -L. -lasm -lcriterion
endif

#-------------Create and fill objects directory with *.c sources----------------

$(OBJ): $(SRC) $(LIBRARY)
	@mkdir -p $(ODIR)
	@gcc -c -o $@ $(FLAGS) -I. $<

#-------------Create and fill objects directory with assembly sources-----------

$(ASMOBJ): $(ASM)
	@mkdir -p $(ODIR)
	@nasm -fmacho64 -o $@ $(patsubst $(ODIR)%.o,$(DIR)%.s,$@)

#------------------------Utility Make Instructions------------------------------

clean:
	@rm -f $(ALLOBJ)

fclean: clean
	@rm -f $(TESTEXEC)
	@rm -f $(NAME)

re: fclean all

#-----------------------------Phony instructions--------------------------------

.PHONY: clean fclean all re
