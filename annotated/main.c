/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   main.c                                             :+:    :+:            */
/*                                                     +:+                    */
/*   By: rlucas <marvin@codam.nl>                     +#+                     */
/*                                                   +#+                      */
/*   Created: 2020/02/20 09:50:55 by rlucas        #+#    #+#                 */
/*   Updated: 2020/02/24 09:16:32 by rlucas        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include <libasm.h>
#include <stdio.h>
#include <string.h>

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
	/* 	printf("strcpy test failure\n"); */
	/* 	return (-1); */
	/* } */
	if(strdup_tests() < 0)
	{
		printf("strdup test failure\n");
		return (-1);
	}
	return (0);
}
