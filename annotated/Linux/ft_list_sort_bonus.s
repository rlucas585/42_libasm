# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    ft_list_sort_bonus.s                               :+:    :+:             #
#                                                      +:+                     #
#    By: rlucas <marvin@codam.nl>                     +#+                      #
#                                                    +#+                       #
#    Created: 2020/02/28 11:07:56 by rlucas        #+#    #+#                  #
#    Updated: 2020/02/28 11:10:26 by rlucas        ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

; Assembly language ft_list_sort, with annotated comments
; For Linux

; ft_list_sort prototype:
;	void	ft_list_sort(t_list **begin_list, int (*cmp)());

; int (*cmp)() is a pointer to a function that can compare data held in two
; addresses (the *data in each t_list), for example ft_strcmp.

; rdi = **begin_list
; rsi = (*cmp)()
