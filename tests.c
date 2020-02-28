/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   tests.c                                            :+:    :+:            */
/*                                                     +:+                    */
/*   By: rlucas <marvin@codam.nl>                     +#+                     */
/*                                                   +#+                      */
/*   Created: 2020/02/28 17:46:43 by rlucas        #+#    #+#                 */
/*   Updated: 2020/02/28 18:08:37 by rlucas        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include <criterion/criterion.h>
#include <libasm.h>

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

Test(Mandatory_Tests, strdup_test)
{
	strdup_test("A test with a moderate length string\n");
	strdup_test("");
	strdup_test("											"
			"							empty				"
			"with				tabs");
}

Test(Mandatory_Tests, strcmp_test)
{
	strcmp_test("STRing 1", "STRing 2");
	strcmp_test("", "STRing 2");
	strcmp_test("oadkfskfjl", "--wkwefjk3jf");
	strcmp_test("Exactly the same", "Exactly the same");
}
