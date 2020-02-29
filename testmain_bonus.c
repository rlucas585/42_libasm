/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   testmain_bonus.c                                   :+:    :+:            */
/*                                                     +:+                    */
/*   By: rlucas <marvin@codam.nl>                     +#+                     */
/*                                                   +#+                      */
/*   Created: 2020/02/29 13:36:23 by rlucas        #+#    #+#                 */
/*   Updated: 2020/02/29 14:40:04 by rlucas        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include <criterion/criterion.h>
#include <libasm_bonus.h>

void	ft_atoi_base_test(const char *test, const char *base,
		int expected);

Test(Bonus_Tests, ft_atoi_base_test)
{
	ft_atoi_base_test("", "", 0);
	ft_atoi_base_test("lmao", "-28", 0);
	ft_atoi_base_test("lmao", "28", 478544);
	ft_atoi_base_test("", "", 0);
	ft_atoi_base_test("", "", 0);
	ft_atoi_base_test("", "", 0);
	ft_atoi_base_test("", "", 0);
	ft_atoi_base_test("", "", 0);
	ft_atoi_base_test("", "", 0);
	ft_atoi_base_test("", "", 0);
	ft_atoi_base_test("", "", 0);
	ft_atoi_base_test("", "", 0);
}
