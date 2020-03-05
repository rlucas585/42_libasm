/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   tests.c                                            :+:    :+:            */
/*                                                     +:+                    */
/*   By: rlucas <marvin@codam.nl>                     +#+                     */
/*                                                   +#+                      */
/*   Created: 2020/02/28 17:46:43 by rlucas        #+#    #+#                 */
/*   Updated: 2020/03/05 23:45:48 by rlucas        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include <criterion/criterion.h>
#include <libasm.h>

void	expect_eq(char *actual, const char *expected);
void	strdup_test(const char *str);
void	strcmp_test(const char *str1, const char *str2);
void	strlen_test(const char *str);
void	strcpy_test(const char *str);
void	read_test(const char *str);
void	write_test(const char *str);

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
	strlen_test(
			"Did you ever hear the tragedy of Darth Plagueis The Wise? I thought not."
			" It's not a story the Jedi would tell you. It's a Sith legend. Darth "
			"Plagueis was a Dark Lord of the Sith, so powerful and so wise he could "
			"use the Force to influence the midichlorians to create life... He had "
			"such a knowledge of the dark side, he could even keep the ones he cared "
			"about from dying. The dark side of the Force is a pathway to many "
			"abilities some consider to be unnatural. He became so powerful... the "
			"only thing he was afraid of was losing his power, which eventually, "
			"of course, he did. Unfortunately, he taught his apprentice everything "
			"he knew, then his apprentice killed him in his sleep. Ironic. He could "
			"save others from death, but not himself.\n");
	strlen_test(
			"Porcupines are large rodents with coats of sharp spines, or "
			"quills, that protect them against predators. The term covers "
			"two families of animals: the Old World porcupines of family "
			"Hystricidae, and the New World porcupines af family Erethizontidae"
			". Both families belong to the infraorder Hystricognathi within the"
			" profoundly diverse order Rodentia and display superficially "
			"similar coats of quills: despite this, the two groups are distinct"
			" from each other and are not closely related to each other within "
			"the Hystricognathi."
			);
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
	read_test("tests/texts/testread.txt");
	read_test("tests/texts/notafile.txt");
}

Test(Mandatory_Tests, write_test)
{
	char		*str;

	str = strdup(
	"Did you ever hear the tragedy of Darth Plagueis The Wise? I thought not."
	 " It's not a story the Jedi would tell you. It's a Sith legend. Darth "
	 "Plagueis was a Dark Lord of the Sith, so powerful and so wise he could "
	 "use the Force to influence the midichlorians to create life... He had "
	 "such a knowledge of the dark side, he could even keep the ones he cared "
	 "about from dying. The dark side of the Force is a pathway to many "
	 "abilities some consider to be unnatural. He became so powerful... the "
	 "only thing he was afraid of was losing his power, which eventually, "
	 "of course, he did. Unfortunately, he taught his apprentice everything "
	 "he knew, then his apprentice killed him in his sleep. Ironic. He could "
	 "save others from death, but not himself.\n");
	write_test(str);
	free(str);
}
