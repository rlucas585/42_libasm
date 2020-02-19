/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   ex11.c                                             :+:    :+:            */
/*                                                     +:+                    */
/*   By: rlucas <marvin@codam.nl>                     +#+                     */
/*                                                   +#+                      */
/*   Created: 2020/02/19 15:18:19 by rlucas        #+#    #+#                 */
/*   Updated: 2020/02/19 15:20:46 by rlucas        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>

int		add42(int x);

int		main(void)
{
	int		x;

	x = 15;
	while (x < 30)
	{
		printf("result of assembly function with [%d] = %d\n", x, add42(x));
		x++;
	}
	return (0);
}
