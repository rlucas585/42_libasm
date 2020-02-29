/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   tests_bonus.c                                      :+:    :+:            */
/*                                                     +:+                    */
/*   By: rlucas <marvin@codam.nl>                     +#+                     */
/*                                                   +#+                      */
/*   Created: 2020/02/29 13:42:31 by rlucas        #+#    #+#                 */
/*   Updated: 2020/02/29 14:39:01 by rlucas        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include <criterion/criterion.h>
#include <libasm_bonus.h>
#include <stdio.h>

void	ft_atoi_base_test(const char *test, const char *base,
		int expected)
{
	int		actual;

	actual = ft_atoi_base((char *)test, (char *)base);
	cr_assert(actual == expected);
}
