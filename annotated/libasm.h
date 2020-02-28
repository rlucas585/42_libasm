/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   libasm.h                                           :+:    :+:            */
/*                                                     +:+                    */
/*   By: rlucas <marvin@codam.nl>                     +#+                     */
/*                                                   +#+                      */
/*   Created: 2020/02/19 15:53:38 by rlucas        #+#    #+#                 */
/*   Updated: 2020/02/28 10:37:39 by rlucas        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

# ifndef BUFFER_SIZE
#  define BUFFER_SIZE 32
# endif
# define BLUE "\e[34m"
# define NORMAL "\e[0m"

# include <unistd.h>
# include <stdlib.h>
# include <fcntl.h>

typedef struct			s_list
{
	void				*data;
	struct s_list		*next;
}						t_list;

ssize_t		ft_write(int fildes, const void *buf, size_t nbyte);
ssize_t		ft_read(int fildes, void *buf, size_t nbyte);
size_t		ft_strlen(const char *s);
char		*ft_strcpy(char *dst, const char *src);
int			ft_strcmp(const char *s1, const char *s2);
char		*ft_strdup(const char *s);
int			ft_atoi(const char *str);
int			ft_atoi_base(char *str, char *base);
char		*ft_strchr(char *s, int c);
void		ft_list_push_front(t_list **begin_list, void *data);
int			ft_list_size(t_list *begin_list);

#endif
