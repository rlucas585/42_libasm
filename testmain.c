/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   testmain.c                                         :+:    :+:            */
/*                                                     +:+                    */
/*   By: rlucas <marvin@codam.nl>                     +#+                     */
/*                                                   +#+                      */
/*   Created: 2020/02/28 19:02:53 by rlucas        #+#    #+#                 */
/*   Updated: 2020/02/28 19:27:16 by rlucas        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include <criterion/criterion.h>
#include <libasm.h>
#include <libasm_bonus.h>

void	assert_eq(char *actual, const char *expected)
{
	if (!actual)
		cr_assert_fail("*Actual*: NULL\nExpected: \"%s\"", expected);
	else
		cr_assert_str_eq(actual, expected, "*Actual*: \"%s\""
				"\nExpected: \"%s\"", actual, expected);
}

void	strdup_test(const char *str)
{
	char		*mystr;
	char		*teststr;

	mystr = ft_strdup(str);
	teststr = strdup(str);
	assert_eq(mystr, teststr);
	free(mystr);
	free(teststr);
}

void	strcmp_test(const char *str1, const char *str2)
{
	char		*str3;
	char		*str4;

	str3 = strdup(str1);
	str4 = strdup(str2);
	cr_assert(strcmp(str3, str4) == ft_strcmp(str3, str4));
	free(str3);
	free(str4);
}

void	strlen_test(const char *str)
{
	cr_assert(strlen(str) == ft_strlen(str));
}

void	strcpy_test(const char *str)
{
	char		*str1;
	char		*str2;

	str1 = (char *)malloc(sizeof(char) * strlen(str));
	str2 = (char *)malloc(sizeof(char) * strlen(str));
	strcpy(str1, str);
	ft_strcpy(str2, str);
	cr_assert_str_eq(str2, str1, "*Actual*: \"%s\""
			"\nExpected: \"%s\"", str2, str1);
	free(str1);
	free(str2);
}

void	read_test(const char *str)
{
	int		fd;
	int		x;
	int		ret;
	char	mybuf[40];
	char	sysbuf[40];

	fd = open(str, O_RDONLY);
	x = 0;
	while (x < 10)
	{
		ret = read(fd, sysbuf, 30);
		sysbuf[ret] = '\0';
		ret = ft_read(fd, mybuf, 30);
		mybuf[ret] = '\0';
		cr_assert_str_eq(mybuf, sysbuf, "*Actual*: \"%s\""
				"\nExpected: \"%s\"", mybuf, sysbuf);
		x++;
	}
	close(fd);
}
