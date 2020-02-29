/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   libasm_bonus.h                                     :+:    :+:            */
/*                                                     +:+                    */
/*   By: rlucas <marvin@codam.nl>                     +#+                     */
/*                                                   +#+                      */
/*   Created: 2020/02/28 18:58:46 by rlucas        #+#    #+#                 */
/*   Updated: 2020/02/28 18:59:42 by rlucas        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_BONUS_H
# define LIBASM_BONUS_H

typedef struct			s_list
{
	void				*data;
	struct s_list		*next;
}						t_list;

int			ft_atoi(const char *str);
int			ft_atoi_base(char *str, char *base);
char		*ft_strchr(char *s, int c);
void		ft_list_push_front(t_list **begin_list, void *data);
int			ft_list_size(t_list *begin_list);
void		ft_list_sort(t_list **begin_list, int (*cmp)());
void		ft_list_remove_if(t_list **begin_list, void *data_ref,
		int (*cmp)());

#endif
