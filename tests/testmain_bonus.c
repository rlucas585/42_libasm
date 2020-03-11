/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   testmain_bonus.c                                   :+:    :+:            */
/*                                                     +:+                    */
/*   By: rlucas <marvin@codam.nl>                     +#+                     */
/*                                                   +#+                      */
/*   Created: 2020/02/29 13:36:23 by rlucas        #+#    #+#                 */
/*   Updated: 2020/03/11 19:39:02 by rlucas        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include <criterion/criterion.h>
#include <libasm_bonus.h>

#define INT 1
#define STRING 2
#define PRINT 1
#define NO_PRINT 0

void	ft_atoi_test(const char *test);
void	ft_atoi_base_test(const char *test, const char *base,
		int expected, int print);
void	ft_list_push_front_test(int type, void *data, int len);
void	ft_list_size_test(int type, void *data, int len);
void	ft_list_sort_test(int type, void *data, int len);
void	ft_list_remove_if_test(int type, void *data, int len);

Test(Bonus_Tests, ft_atoi_test)
{
	ft_atoi_test("147928");
	ft_atoi_test("-1234897");
	ft_atoi_test("        -1234897");
	ft_atoi_test("    -123aaa");
	ft_atoi_test("			2829b");
	ft_atoi_test("abcdefg");
	ft_atoi_test("12893472974920849824");
	ft_atoi_test("    -12893472974920849824");
	ft_atoi_test("1289347297492084982428472847");
	ft_atoi_test("    -1289347297492084982428472847");
}

Test(Bonus_Tests, ft_atoi_base_test)
{
	ft_atoi_base_test("510", "011", 0, NO_PRINT);
	ft_atoi_base_test("510", "0123456789", 510, NO_PRINT);
	ft_atoi_base_test("-ryan", "0123456789abcdefghijklmnopqrstuvwxyz",
			-1304159, NO_PRINT);
	ft_atoi_base_test("+ryan", "0123456789abcdefghijklmnopqrstuvwxyz",
			1304159, NO_PRINT);
	ft_atoi_base_test("ryan", "0123456789abcdefghijklmnopqrstuvwxyz",
			1304159, NO_PRINT);
	ft_atoi_base_test("aec", "0abcdefghi", 153, NO_PRINT);
	ft_atoi_base_test("11001010101011", "01", 12971, NO_PRINT);
	ft_atoi_base_test("", "01", 0, NO_PRINT);
	ft_atoi_base_test("1500", "", 0, NO_PRINT);
	ft_atoi_base_test("15		", "	123456789", 1500, NO_PRINT);
	ft_atoi_base_test("	1500", "0123456789", 0, NO_PRINT);
	ft_atoi_base_test("			\n-15   00", "0123456789", 0, NO_PRINT);
	ft_atoi_base_test("-X4ny;;;", ";xy4[]fnGX", -9372000, NO_PRINT);
	ft_atoi_base_test("-X4ny;;;", ";xy4[ffnGX", 0, NO_PRINT);
	ft_atoi_base_test("XXX", "OoXx", 42, NO_PRINT);
	ft_atoi_base_test("01010", "01", 10, NO_PRINT);
	ft_atoi_base_test("0101010", "01", 42, NO_PRINT);
	ft_atoi_base_test("thijs", "0123456789abcdefghijklmnopqrstuvwxyz",
			49526056, NO_PRINT);
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
