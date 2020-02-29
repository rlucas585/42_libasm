/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   tests.c                                            :+:    :+:            */
/*                                                     +:+                    */
/*   By: rlucas <marvin@codam.nl>                     +#+                     */
/*                                                   +#+                      */
/*   Created: 2020/02/28 17:46:43 by rlucas        #+#    #+#                 */
/*   Updated: 2020/02/28 19:27:33 by rlucas        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include <criterion/criterion.h>
#include <libasm.h>
#include <libasm_bonus.h>

void	assert_eq(char *actual, const char *expected);
void	strdup_test(const char *str);
void	strcmp_test(const char *str1, const char *str2);
void	strlen_test(const char *str);
void	strcpy_test(const char *str);

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
	strcmp_test("String for compare", "");
}

Test(Mandatory_Tests, strlen_test)
{
	strlen_test("string with length");
	strlen_test("longlonglonglonglonglonglonglonglonglonglonglonglong"
			"longlonglonglonglonglonglonglonglonglonglong"
			"longlonglonglonglonglonglonglonglonglonglonglonglong");
	strlen_test("");
}

Test(Mandatory_Tests, strcpy_test)
{
	strcpy_test("Baba Ganoush");
	strcpy_test("");
	strcpy_test("akfjdsklfjsenioeanvevjawklcjekcmkescaklemcklejacklejaklj"
			"cjeisojfesickjcskljeksjeksjcklesjcklejskcje");
	strcpy_test("Have you ever heard the story of Darth Plageuius the Wise?"
			"I thought not. It's not a story the Jedi would teach you.");
}

Test(Mandatory_Tests, read_test)
{
	read_test("testread.txt");
}
