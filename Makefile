# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Makefile                                           :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/20 10:00:23 by rlucas        #+#    #+#                  #
#    Updated: 2020/03/05 23:40:56 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

#-------------------------Find Operating System---------------------------------

OS := $(shell uname)
ifeq ($(OS),Linux)
	DIR = Linux/
else
	DIR = MacOSX/
endif

#-------------------------------------------------------------------------------

ifdef WITH_BONUS
	NAME = libasm_bonus.a
else
	NAME = libasm.a
endif

LIBRARIES = libasm_bonus.a \
			libasm.a

TESTDIR = tests/

TESTEXEC = testexec

#-----------------------------Select sources------------------------------------

ASM = $(DIR)ft_write.s \
	  $(DIR)ft_read.s \
	  $(DIR)ft_strlen.s \
	  $(DIR)ft_strcpy.s \
	  $(DIR)ft_strcmp.s \
	  $(DIR)ft_strdup.s

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

SRC = $(TESTDIR)tests.c \
	  $(TESTDIR)testmain.c
BONUSSRC = $(TESTDIR)testmain_bonus.c \
		   $(TESTDIR)tests_bonus.c

ifdef WITH_BONUS
	SRC += $(BONUSSRC)
endif

BONUSOBJ = $(patsubst $(TESTDIR)%.c, $(ODIR)%.o,$(BONUSSRC))

#----------------------------Select Objects-------------------------------------

ODIR = obj/
ASMOBJ = $(patsubst $(DIR)%.s,$(ODIR)%.o,$(ASM))
OBJ = $(patsubst $(TESTDIR)%.c,$(ODIR)%.o,$(SRC))
ALLOBJ = $(patsubst $(DIR)%.s,$(ODIR)%.o,$(ASM) $(BONUS)) \
		 $(OBJ) \
		 $(BONUSOBJ)

#------------------------Library and Flags definitions--------------------------

HEADERS = libasm.h libasm_bonus.h
FLAGS = -Wall -Wextra -Werror

#------------------------------Compile Library----------------------------------

all: $(NAME)

$(NAME): $(ASMOBJ)
	@ar -rc $(NAME) $(ASMOBJ)

#-----------------------------Compile with bonus--------------------------------

check:
	@echo $(ASM)

bonus:
	@$(MAKE) WITH_BONUS=1 all

bonustest:
	@$(MAKE) WITH_BONUS=1 test

#--------------------------Compile test executable------------------------------

test: $(OBJ) $(NAME)
ifdef WITH_BONUS
	@gcc $(FLAGS) -I. -o $(TESTEXEC) $(OBJ) -L. -lasm_bonus -lcriterion -no-pie
else
	@gcc $(FLAGS) -I. -o $(TESTEXEC) $(OBJ) -L. -lasm -lcriterion -no-pie
endif

#-------------Create and fill objects directory with *.c sources----------------

$(OBJ): $(SRC) $(HEADER)
	@mkdir -p $(ODIR)
	@gcc $(FLAGS) -I. -c -o $@ $(patsubst $(ODIR)%.o, $(TESTDIR)%.c,$@)

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
	@rm -f $(ALLOBJ)
	@rm -f $(TESTDIR)texts/output.txt

fclean: clean
	@rm -f $(TESTEXEC)
	@rm -f $(LIBRARIES)

re: fclean all

#-----------------------------Phony instructions--------------------------------

.PHONY: clean fclean all re
