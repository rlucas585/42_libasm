/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   testmain.c                                         :+:    :+:            */
/*                                                     +:+                    */
/*   By: rlucas <marvin@codam.nl>                     +#+                     */
/*                                                   +#+                      */
/*   Created: 2020/02/28 19:02:53 by rlucas        #+#    #+#                 */
/*   Updated: 2020/03/05 23:57:56 by rlucas        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include <criterion/criterion.h>
#include <criterion/redirect.h>
#include <libasm.h>
#include <stdio.h>

void	expect_eq(char *actual, const char *expected)
{
	if (!actual)
		cr_expect_fail("*Actual*: NULL\nExpected: \"%s\"", expected);
	else
		cr_expect_str_eq(actual, expected, "*Actual*: \"%s\""
				"\nExpected: \"%s\"", actual, expected);
}

void	strdup_test(const char *str)
{
	char		*mystr;
	char		*teststr;

	mystr = ft_strdup(str);
	teststr = strdup(str);
	expect_eq(mystr, teststr);
	free(mystr);
	free(teststr);
}

void	strcmp_test(const char *str1, const char *str2)
{
	char		*str3;
	char		*str4;

	str3 = strdup(str1);
	str4 = strdup(str2);
	cr_expect(strcmp(str3, str4) == ft_strcmp(str3, str4));
	free(str3);
	free(str4);
}

void	strlen_test(const char *str)
{
	cr_expect(strlen(str) == ft_strlen(str));
}

void	strcpy_test(const char *str)
{
	char		*str1;
	char		*str2;
	char		str3[300];
	char		str4[300];

	str1 = (char *)malloc(sizeof(char) * strlen(str) + 1);
	if (!str1)
		return ;
	str2 = (char *)malloc(sizeof(char) * strlen(str) + 1);
	if (!str2)
	{
		free(str1);
		return ;
	}
	strcpy(str1, str);
	ft_strcpy(str2, str);
	cr_expect_str_eq(str2, str1, "*Actual*: \"%s\""
			"\nExpected: \"%s\"", str2, str1);
	free(str1);
	free(str2);
	strcpy(str3, str);
	ft_strcpy(str4, str);
	cr_expect_str_eq(str4, str3, "*Actual*: \"%s\""
			"\nExpected: \"%s\"", str4, str3);
	bzero(str3, 300);
	bzero(str4, 300);
}

void	read_test(const char *str)
{
	int		fd;
	int		ret;
	char	mybuf[40];
	char	sysbuf[40];

	fd = open(str, O_RDONLY);
	ret = read(fd, sysbuf, 30);
	sysbuf[ret] = '\0';
	close(fd);
	fd = open(str, O_RDONLY);
	ret = ft_read(fd, mybuf, 30);
	mybuf[ret] = '\0';
	cr_expect_str_eq(mybuf, sysbuf, "*Actual*: \"%s\""
			"\nExpected: \"%s\"", mybuf, sysbuf);
	close(fd);
}

void	write_test(const char *str)
{
	int		fd;
	int		i;
	FILE	*file;
	FILE	*expected;

	fd = open("tests/texts/output.txt", O_RDWR | O_CREAT | O_TRUNC, 0644);
	i = 0;
	while (str[i])
	{
		ft_write(fd, &str[i], 1);
		i++;
	}
	close(fd);
	file = fopen("tests/texts/output.txt", "r");
	expected = fopen("tests/texts/darth_plagueis.txt", "r");
	cr_expect_file_contents_eq(file, expected);
	fclose(file);
	fclose(expected);
}
