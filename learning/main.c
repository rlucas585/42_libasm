/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   main.c                                             :+:    :+:            */
/*                                                     +:+                    */
/*   By: rlucas <marvin@codam.nl>                     +#+                     */
/*                                                   +#+                      */
/*   Created: 2020/02/20 09:50:55 by rlucas        #+#    #+#                 */
/*   Updated: 2020/02/29 18:56:13 by rlucas        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <libasm.h>
#include <libasm_bonus.h>

int			write_tests(void)
{
	char	*str;
	int		ft_ret;
	int		n_ret;
	int		fd;

	str = strdup("Hello!\n");
	if (!str)
		return (-1);

	fd = -1;
	while (fd <= 3)
	{
		printf("ft_write\n-------------------------\n");
		ft_ret = ft_write(fd, str, 7);
		printf("fd = %d ret = %d\n\n", fd, ft_ret);
		printf("system write\n-------------------------\n");
		n_ret = write(fd, str, 7);
		printf("fd = %d ret = %d\n\n", fd, n_ret);
		if (n_ret != ft_ret)
		{
			free(str);
			return (-1);
		}
		fd++;
	}
	free(str);
	return (0);
}

int			read_tests(void)
{
	char	buf[50];
	int		ft_ret;
	int		n_ret;
	int		fd;
	int		fd2;

	printf(BLUE);
	printf("TESTING READ\n");
	printf(NORMAL);
	fd = -1;
	fd2 = open("testread.txt", O_RDONLY);
	buf[0] = '\0';
	if (fd2 != 3)
		return (-1);
	while (fd <= 3)
	{
		if (fd == 1 || fd == 2)
		{
			fd++;
			continue ;
		}
		if (fd == 0)
			printf("Reading from standard in, type something!! \n\n");
		printf("ft_read\n-------------------------\n");
		while((ft_ret = ft_read(fd, buf, BUFFER_SIZE)) > 0)
		{
			buf[ft_ret] = '\0';
			printf("fd = %d ret = %d buf = %s\n\n", fd, ft_ret, buf);
		}
		printf("fd = %d ret = %d buf = %s\n\n", fd, ft_ret, buf);
		if (fd == 3)
		{
			close(fd);
			fd2 = open("testread.txt", O_RDONLY);
		}
		printf("system read\n-------------------------\n");
		while((n_ret = read(fd, buf, BUFFER_SIZE)) > 0)
		{
			buf[n_ret] = '\0';
			printf("fd = %d ret = %d buf = %s\n\n", fd, n_ret, buf);
		}
		printf("fd = %d ret = %d buf = %s\n\n", fd, n_ret, buf);
		if (n_ret != ft_ret)
		{
			close(fd2);
			return (-1);
		}
		fd++;
	}
	close(fd2);
	return (0);
}

int			strlen_tests(void)
{
	char		*str;

	/* str = strdup("You Belong With Me\n"); */
	/* str = strdup("You Belong\n"); */
	str = strdup("ajdfklaewhkjhaefljaeklfjklaejfklaejfkljakfjekljfe"
			"ajsgflrnglrsmflkjaeklfjmaeklsfjklaesjfklejsfjesfkljsljf"
			"lsejfklaejfkljfgkljseklfjeklsjfkljsefkjeklfj"
			"kldsjfklejfkljeklfjeklsjfklesjfklejsfkjeklfjs"
			"askjfalefiaewjflejaklfjaelkfjeklsjfklesjfklejsfklj"
			"afjefjaelfjklaesjafklejfkljeklfjeskfjeklsjfklaejfkljewlkfj"
			"fjklsjfleafklaejflkesjfkljeklfjesklfjklesjafkljefkljaeljek"
			"fjsajnfaeoinmcklemsklcneklsfneklsnfklesfklnesfesklfjklfjklaen");
	if (!str)
		return (-1);
	printf("ft_strlen result = %ld\n", ft_strlen(str));
	printf("strlen result = %ld\n", strlen(str));
	if (strlen(str) != ft_strlen(str))
	{
		free(str);
		return (-1);
	}
	free(str);
	str = strdup("");
	printf("ft_strlen result = %ld\n", ft_strlen(str));
	printf("strlen result = %ld\n", strlen(str));
	if (strlen(str) != ft_strlen(str))
	{
		free(str);
		return (-1);
	}
	free(str);
	str = strdup("3289qhdwh4fhqwh383hqf784q84fh34q8q7hg83wwhgierwhgiuwhiuo");
	printf("ft_strlen result = %ld\n", ft_strlen(str));
	printf("strlen result = %ld\n", strlen(str));
	if (strlen(str) != ft_strlen(str))
	{
		free(str);
		return (-1);
	}
	free(str);
	return (0);
}

int			strcpy_tests(void)
{
	char		buf[50];
	char		buf2[50];
	char		*ptr;

	ptr = strcpy(buf, "Hello this has been copied into a buffer.");
	printf("strcpy result = \"%s\"\n"
			"strcpy return = \"%s\"\n\n", buf, ptr);
	ptr = ft_strcpy(buf2, "Hello this has been copied into a buffer.");
	printf("ft_strcpy result = \"%s\"\n"
			"ft_strcpy return = \"%s\"\n\n", buf2, ptr);
	if (strcmp(buf, buf2) != 0)
		return (-1);
	return (0);
}

int			strcmp_tests(void)
{
	char		*s1 = NULL;
	char		*s2 = NULL;
	char		str1[] = "different!";
	char		str2[] = "Different!";
	char		str3[] = "";

	s1 = strdup("String2");
	if (!s1)
		return (-1);
	s2 = strdup("String2");
	if (!s2)
		return (-1);
	printf("strcmp result = %d\n", strcmp(s1, s2));
	printf("ft_strcmp result = %d\n", ft_strcmp(s1, s2));
	if (strcmp(s1, s2) != ft_strcmp(s1, s2))
	{
		free(s1);
		free(s2);
		return (-1);
	}
	free(s1);
	free(s2);
	s1 = strdup("S");
	if (!s1)
		return (-1);
	s2 = strdup("String2");
	if (!s2)
		return (-1);
	printf("strcmp result = %d\n", strcmp(s1, s2));
	printf("ft_strcmp result = %d\n", ft_strcmp(s1, s2));
	if (strcmp(s1, s2) != ft_strcmp(s1, s2))
	{
		free(s1);
		free(s2);
		return (-1);
	}
	free(s1);
	free(s2);
	printf("strcmp result = %d\n", strcmp(str1, str2));
	printf("ft_strcmp result = %d\n", ft_strcmp(str1, str2));
	printf("strcmp result = %d\n", strcmp(str3, str2));
	printf("ft_strcmp result = %d\n", ft_strcmp(str3, str2));
	if (strcmp(str1, str2) != ft_strcmp(str1, str2))
		return (-1);
	return (0);
}

int			strdup_tests(void)
{
	char	*s1 = NULL;
	char	*s2 = NULL;

	s1 = strdup("Test string!");
	s2 = ft_strdup("Test string!");
	if (!s2)
		printf("s2 not allocated\n");
	printf("strdup string: \"%s\"\n"
			"ft_strdup string: \"%s\"\n", s1, s2);
	if (strcmp(s1, s2) != 0)
	{
		free(s1);
		free(s2);
		return (-1);
	}
	free(s1);
	free(s2);
	return (0);
}

int			single_atoi(char *str2)
{
	char		str[40];

	ft_strcpy(str, str2);
	printf("atoi: %d\nft_atoi: %d\n\n", atoi(str), ft_atoi(str));
	if (atoi(str) != ft_atoi(str))
		return (-1);
	return (0);
}

int			atoi_tests(void)
{
	printf("Atoi tests\n-----------------------------\n\n");
	if (single_atoi("516"))
		return (-1);
	if (single_atoi("     x124897"))
		return (-1);
	if (single_atoi("-284987989"))
		return (-1);
	if (single_atoi("-284987989999999"))
		return (-1);
	if (single_atoi("284987989x999999999"))
		return (-1);
	if (single_atoi("2849879899999999999999999999"))
		return (-1);
	if (single_atoi("-2849879899999999999999999999"))
		return (-1);
	if (single_atoi("123-248927"))
		return (-1);
	if (single_atoi(" + "))
		return (-1);
	if (single_atoi(" - "))
		return (-1);
	if (single_atoi(" -284987989"))
		return (-1);
	if (single_atoi("			-24897234tabtest"))
		return (-1);
	if (single_atoi("123-"))
		return (-1);
	return (0);
}

int			strchr_tests(void)
{
	char		str[] = "hi there";

	printf("return = %s\n", ft_strchr(str, 'i'));
	printf("return = %s\n", ft_strchr(str, 'x'));
	if (strchr("ajglskdjbksjbksj", 'l') != ft_strchr("ajglskdjbksjbksj", 'l'))
		return (-1);
	if (strchr("Hello i don't have the char", 'x') != ft_strchr("Hello i don't "
				"have the char", 'x'))
		return (-1);
	return (0);
}

int			atoi_base_tests(void)
{
	printf("ft_atoi_base tests, bases 2-10\n---------------------------\n\n");
	printf("expected: 15, got: %d\n", ft_atoi_base("15", "10"));
	printf("expected: 102, got: %d\n", ft_atoi_base("123", "9"));
	printf("expected: 22661, got: %d\n", ft_atoi_base("34068", "9"));
	printf("expected: 1872, got: %d\n", ft_atoi_base("1872", "10"));
	printf("expected: 718293, got: %d\n", ft_atoi_base("718293", "10"));
	printf("expected: 350, got: %d\n", ft_atoi_base("0101011110", "2"));
	printf("\n\n");
	printf("ft_atoi_base tests, bases 11-36\n---------------------------\n\n");
	printf("expected: 10, got: %d\n", ft_atoi_base("A", "28"));
	printf("expected: 8160, got: %d\n", ft_atoi_base("ABC", "28"));
	printf("expected: 478908, got: %d\n", ft_atoi_base("LMNO", "28"));
	printf("expected: -478908, got: %d\n", ft_atoi_base("-LMNO", "28"));
	printf("expected: 45755, got: %d\n", ft_atoi_base("zaz", "36"));
	printf("expected: 0, got: %d\n", ft_atoi_base("-0", "36"));
	printf("\n\n");
	printf("Error return tests\n-------------------------\n\n");
	printf("expected: 0, got: %d\n", ft_atoi_base("468", "+3"));
	printf("expected: 0, got: %d\n", ft_atoi_base("1872", ""));
	printf("expected: 0, got: %d\n", ft_atoi_base("1872", "   "));
	printf("expected: 0, got: %d\n", ft_atoi_base("1872", "-15"));
	printf("expected: 0, got: %d\n", ft_atoi_base("010110112", "-2"));
	printf("expected: 0, got: %d\n", ft_atoi_base("010110112", "37"));
	printf("\n\n");
	return (0);
}

void		print_list(t_list **head)
{
	t_list		*current;
	int			x;

	x = 0;
	current = *head;
	while (current)
	{
		printf("List[%d]: %d\n", x, *(int *)current->data);
		current = current->next;
		x++;
	}
}

void		print_list_str(t_list **head)
{
	t_list		*current;
	int			x;

	x = 0;
	if (!head)
		return ;
	current = *head;
	while (current)
	{
		printf("List[%d]: %s\n", x, (char *)current->data);
		current = current->next;
		x++;
	}
}

int			list_front_tests(t_list **head, int *a)
{
	*a = 25;
	printf("ft_list_push_front tests\n-------------------------\n\n");
	printf("Prior to ft_list_push_front:\n");
	print_list(head);
	printf("\n\n");
	ft_list_push_front(head, a);
	printf("After ft_list_push_front:\n");
	print_list(head);
	printf("\n\n");
	return (0);
}

void		free_list(t_list **head)
{
	t_list		**current;
	t_list		*next;

	if (!head)
		return ;
	if (!(*head))
		return ;
	current = head;
	while ((*current)->next)
	{
		next = (*current)->next;
		free(*current);
		*current = NULL;
		*current = next;
	}
	free(*current);
	*current = NULL;
	head = NULL;
}

int			list_size_tests(t_list *head)
{
	static int	x = 0;

	x++;
	if (x == 1)
	{
		printf("ft_list_size tests 1\n-------------------------\n\n");
		printf("Expected: 3, Got: %d\n", ft_list_size(head));
		printf("Expected: 2, Got: %d\n", ft_list_size(head->next));
		printf("Expected: 0, Got: %d\n", ft_list_size(NULL));
		printf("\n\n");
		if (ft_list_size(head) != 3)
			return (-1);
	}
	if (x == 2)
	{
		printf("ft_list_size tests 2\n-------------------------\n\n");
		printf("Expected: 4, Got: %d\n", ft_list_size(head));
		printf("Expected: 3, Got: %d\n", ft_list_size(head->next));
		printf("Expected: 1, Got: %d\n", ft_list_size(head->next->next->next));
		printf("Expected: 0, Got: %d\n", ft_list_size(NULL));
		printf("\n\n");
		if (ft_list_size(head) != 4)
			return (-1);
	}
	return (0);
}

int		cmp_num(int *data1, int *data2)
{
	return (*data1 - *data2);
}

int			list_tests(void)
{
	t_list		*head;
	/* int			x; */
	/* int			y; */
	/* int			z; */
	/* int			a; */
    /*  */
	/* x = 40; */
	/* y = 3; */
	/* z = 15; */
	/* head = (t_list *)malloc(sizeof(t_list)); */
	/* if (!head) */
	/* 	return (-1); */
	/* head->data = &x; */
	/* head->next = (t_list *)malloc(sizeof(t_list)); */
	/* if (!head->next) */
	/* { */
	/* 	free(head); */
	/* 	return (-1); */
	/* } */
	/* head->next->data = &y; */
	/* head->next->next = (t_list *)malloc(sizeof(t_list)); */
	/* if (!head->next->next) */
	/* { */
	/* 	free_list(&head); */
	/* 	return (-1); */
	/* } */
	/* head->next->next->data = &z; */
	/* head->next->next->next = NULL; */
	/* if (list_size_tests(head) < 0) */
	/* { */
	/* 	free_list(&head); */
	/* 	return (-1); */
	/* } */
	/* if (list_front_tests(&head, &a) < 0) */
	/* { */
	/* 	free_list(&head); */
	/* 	return (-1); */
	/* } */
	/* printf("Before ft_list_sort: \n-----------------------------\n"); */
	/* print_list(&head); */
	/* printf("\n\n"); */
	/* printf("After ft_list_sort: \n-----------------------------\n"); */
	/* ft_list_sort(&head, &cmp_num); */
	/* print_list(&head); */
	/* if (list_size_tests(head) < 0) */
	/* { */
	/* 	free_list(&head); */
	/* 	return (-1); */
	/* } */
	/* free_list(&head); */

	/* char	str1[] = "Giraffe"; */
	/* char	str2[] = "Anteater"; */
	/* char	str3[] = "Porcupine"; */
	/* char	str4[] = "Binturong"; */
	/* char	str5[] = "Zebra"; */
	/* char	str6[] = "Lion"; */
	/* char	str7[] = "Thijs"; */
    /*  */
	/* head = (t_list *)malloc(sizeof(t_list)); */
	/* if (!head) */
	/* 	return (-1); */
	/* head->data = str1; */
	/* head->next = (t_list *)malloc(sizeof(t_list)); */
	/* if (!head->next) */
	/* { */
	/* 	free_list(&head); */
	/* 	return (-1); */
	/* } */
	/* head->next->data = str2; */
	/* head->next->next = (t_list *)malloc(sizeof(t_list)); */
	/* if (!head->next->next) */
	/* { */
	/* 	free_list(&head); */
	/* 	return (-1); */
	/* } */
	/* head->next->next->data = str3; */
	/* head->next->next->next = NULL; */
	/* ft_list_push_front(&head, str4); */
	/* ft_list_push_front(&head, str5); */
	/* ft_list_push_front(&head, str6); */
	/* ft_list_push_front(&head, str7); */
	/* printf("list_sort test 1\n------------------------\n\n"); */
	/* printf("Before:\n"); */
	/* print_list_str(&head); */
	/* printf("\n\n"); */
	/* ft_list_sort(&head, &ft_strcmp); */
	/* printf("After:\n"); */
	/* print_list_str(&head); */
	/* free_list(&head); */
	/* printf("\n\n"); */
    /*  */
	t_list		**ptr_to_head;

	ptr_to_head = &head;
	/* print_list_str(ptr_to_head); */
	/* ft_list_push_front(ptr_to_head, str6); */
	/* ft_list_push_front(ptr_to_head, str2); */
	/* ft_list_push_front(ptr_to_head, str2); */
	/* ft_list_push_front(ptr_to_head, str7); */
	/* ft_list_push_front(ptr_to_head, str4); */
	/* printf("list_sort test 2\n------------------------\n\n"); */
	/* printf("Before:\n"); */
	/* print_list_str(ptr_to_head); */
	/* printf("\n\n"); */
	/* ft_list_sort(ptr_to_head, &ft_strcmp); */
	/* printf("After:\n"); */
	/* print_list_str(ptr_to_head); */
	/* free_list(ptr_to_head); */
	/* printf("\n\n"); */
    /*  */
	char	str10[] = "Vim user";
	char	str20[] = "Vim user";
	char	str30[] = "Visual Studio Code user";
	char	str40[] = "Visual Studio Code user";
	char	str50[] = "Vim user";
	char	str60[] = "Visual Studio Code user";
	char	str70[] = "Vim user";
	char	str80[] = "Visual Studio Code user";
	char	str90[] = "Visual Studio Code user";
	char	str_ew[] = "Visual Studio Code user";

	ft_list_push_front(ptr_to_head, str30);
	ft_list_push_front(ptr_to_head, str10);
	ft_list_push_front(ptr_to_head, str20);
	ft_list_push_front(ptr_to_head, str40);
	ft_list_push_front(ptr_to_head, str50);
	ft_list_push_front(ptr_to_head, str60);
	ft_list_push_front(ptr_to_head, str70);
	ft_list_push_front(ptr_to_head, str80);
	ft_list_push_front(ptr_to_head, str90);
	printf("list_remove_if test 1\n------------------------\n\n");
	printf("Before:\n");
	print_list_str(ptr_to_head);
	printf("\n\n");
	ft_list_remove_if(ptr_to_head, str_ew, &strcmp);
	printf("After:\n");
	print_list_str(ptr_to_head);
	free_list(ptr_to_head);
	return (0);
}

int			main(void)
{
	/* if (write_tests() < 0) */
	/* { */
	/* 	printf("write test failure\n"); */
	/* 	return (-1); */
	/* } */
	/* if (read_tests() < 0) */
	/* { */
	/* 	printf("read test failure\n"); */
	/* 	return (-1); */
	/* } */
	/* if (strlen_tests() < 0) */
	/* { */
	/* 	printf("strlen test failure\n"); */
	/* 	return (-1); */
	/* } */
	/* if(strcpy_tests() < 0) */
	/* { */
	/* 	printf("strcpy test failure\n"); */
	/* 	return (-1); */
	/* } */
	/* if(strcmp_tests() < 0) */
	/* { */
	/* 	printf("strcmp test failure\n"); */
	/* 	return (-1); */
	/* } */
	/* if (strdup_tests() < 0) */
	/* { */
	/* 	printf("strdup test failure\n"); */
	/* 	return (-1); */
	/* } */
	/* if (atoi_tests() < 0) */
	/* { */
	/* 	printf("atoi test failure\n"); */
	/* 	return (-1); */
	/* } */
	/* if (strchr_tests() < 0) */
	/* { */
	/* 	printf("ft_strchr test failure\n"); */
	/* 	return (-1); */
	/* } */
	/* if (atoi_base_tests() < 0) */
	/* { */
	/* 	printf("ft_atoi_base test failure\n"); */
	/* 	return (-1); */
	/* } */
	if (list_tests() < 0)
		return (-1);
	return (0);
}
