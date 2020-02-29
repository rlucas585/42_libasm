/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   testmain_bonus.c                                   :+:    :+:            */
/*                                                     +:+                    */
/*   By: rlucas <marvin@codam.nl>                     +#+                     */
/*                                                   +#+                      */
/*   Created: 2020/02/29 13:36:23 by rlucas        #+#    #+#                 */
/*   Updated: 2020/02/29 19:10:53 by rlucas        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include <criterion/criterion.h>
#include <libasm_bonus.h>

#define INT 1
#define STRING 2

void	ft_atoi_base_test(const char *test, const char *base,
		int expected);
void	ft_list_push_front_test(int type, void *data, int len);
void	ft_list_size_test(int type, void *data, int len);
void	ft_list_sort_test(int type, void *data, int len);
void	ft_list_remove_if_test(int type, void *data, int len);

Test(Bonus_Tests, ft_atoi_base_test)
{
	ft_atoi_base_test("", "", 0);
	ft_atoi_base_test("lmao", "-28", 0);
	ft_atoi_base_test("lmao", "28", 478544);
	ft_atoi_base_test("bouncy", "   36", 706868674);
	ft_atoi_base_test("10101011111", "5", 10172656);
	ft_atoi_base_test("-10101011111", "2", -1375);
	ft_atoi_base_test("-1221020", "3", -1410);
	ft_atoi_base_test("FEED", "16", 65261);
	ft_atoi_base_test("hOlA", "23", 0);
	ft_atoi_base_test("    -hOlA", "25", -281160);
	ft_atoi_base_test("Ryan", "36", 1304159);
	ft_atoi_base_test("111", "1", 0);
}

Test(Bonus_Tests, ft_list_push_front_test)
{
	int		int_array[4] = {5, 20, 35, 70};
	char	*str_array[8] = {
		"Giraffe",
		"Monkey",
		"Anteater",
		"Lion",
		"Thijs",
		"Baboon",
		"Chimpanzee",
		"Rhinoceros"
	};

	ft_list_push_front_test(INT, int_array, 4);
	ft_list_push_front_test(STRING, str_array, 8);
}

Test(Bonus_Tests, ft_list_size_test)
{
	int		int_array[4] = {5, 20, 35, 70};
	char	*str_array[8] = {
		"Giraffe",
		"Monkey",
		"Anteater",
		"Lion",
		"Thijs",
		"Baboon",
		"Chimpanzee",
		"Rhinoceros"
	};

	ft_list_size_test(INT, int_array, 4);
	ft_list_size_test(STRING, str_array, 8);
}

Test(Bonus_Tests, ft_list_sort_test)
{
	int		int_array[8] = {20, 5, 70, 35, -400, 999, 13, 420};
	char	*str_array[8] = {
		"Giraffe",
		"Monkey",
		"Anteater",
		"Lion",
		"Thijs",
		"Baboon",
		"Chimpanzee",
		"Rhinoceros"
	};

	ft_list_sort_test(INT, int_array, 8);
	ft_list_sort_test(STRING, str_array, 8);
}

Test(Bonus_Tests, ft_list_remove_if_test)
{
	char	*str_array[8] = {
		"Glorious Vim User",
		"Disgraceful Visual Studio Code User",
		"Disgraceful Visual Studio Code User",
		"Disgraceful Visual Studio Code User",
		"Glorious Vim User",
		"Glorious Vim User",
		"An emacs user???",
		"Glorious Vim User"
	};

	ft_list_remove_if_test(STRING, str_array, 8);
}
