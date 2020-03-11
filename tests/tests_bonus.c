/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   tests_bonus.c                                      :+:    :+:            */
/*                                                     +:+                    */
/*   By: rlucas <marvin@codam.nl>                     +#+                     */
/*                                                   +#+                      */
/*   Created: 2020/02/29 13:42:31 by rlucas        #+#    #+#                 */
/*   Updated: 2020/03/11 19:22:12 by rlucas        ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include <criterion/criterion.h>
#include <libasm.h>
#include <libasm_bonus.h>
#include <stdlib.h>
#include <stdio.h>

#define INT 1
#define STRING 2

void	expect_eq(char *actual, const char *expected);

void	ft_atoi_test(const char *test)
{
	int		expected;
	int		actual;

	expected = atoi(test);
	actual = ft_atoi(test);
	cr_expect(actual == expected, "Number: %s Expected: %d Actual: %d",
			test, expected, actual);
}

void	ft_atoi_base_test(const char *test, const char *base,
		int expected, int print)
{
	int		actual;

	actual = ft_atoi_base((char *)test, (char *)base);
	cr_expect(actual == expected, "Number: %s Base: %s Expected: %d Actual %d",
			test, base, expected, actual);
	if (print)
	{
		printf("Number: %s Base: %s Expected: %d Actual: %d\n",
				test, base, expected, actual);
	}
}

void	ft_list_add_elem_end(t_list **head, void *data)
{
	t_list		*current;

	if (head == NULL)
		return ;
	if (*head == NULL)
	{
		*head = (t_list *)malloc(sizeof(t_list));
		(*head)->data = data;
		(*head)->next = NULL;
		return ;
	}
	current = *head;
	while (current->next)
		current = current->next;
	current->next = (t_list *)malloc(sizeof(t_list));
	current = current->next;
	current->data = data;
	current->next = NULL;
}

void	print_list(t_list *head, int type)
{
	t_list	*current;
	int		i;

	i = 0;
	current = head;
	while (current)
	{
		if (type == INT)
			printf("List member [%d]: %d\n", i, *(int *)current->data);
		if (type == STRING)
			printf("List member [%d]: %s\n", i, (char *)current->data);
		current = current->next;
		i++;
	}
}

void	free_list(t_list *head)
{
	t_list	*current;
	t_list	*next;

	current = head;
	while (current)
	{
		next = current->next;
		free(current);
		current = next;
	}
}

t_list	*create_list(int type, void *data, int len)
{
	t_list	*head;
	int		i;

	i = 0;
	head = NULL;
	while (i < len)
	{
		if (type == INT)
			ft_list_add_elem_end(&head, data + 4 * i);
		if (type == STRING)
			ft_list_add_elem_end(&head, *(void **)(data + 8 * i));
		i++;
	}
	return (head);
}

void	compare_lists(t_list *head1, t_list *head2, int (*cmp)(), int type)
{
	t_list		*current1;
	t_list		*current2;
	int			i;

	current1 = head1;
	current2 = head2;
	i = 0;
	while (current1 && current2)
	{
		if (type == INT)
			cr_expect(cmp(current1->data, current2->data) == 0, "At position "
					"[%d] of your list, %d was expected, and %d was found",
					i, *(int *)current2->data, *(int *)current1->data);
		if (type == STRING)
			cr_expect(cmp(current1->data, current2->data) == 0, "At position "
					"[%d] of your list, %s was expected, and %s was found",
					i, (char *)current2->data, (char *)current1->data);
		current1 = current1->next;
		current2 = current2->next;
		i++;
	}
	cr_expect(current1 == current2, "Your list is not the same length as"
			" was expected.");
}

int		cmp_num(int *data1, int *data2)
{
	return (*data1 - *data2);
}

void	ft_list_push_front_test(int type, void *data, int len)
{
	t_list		*head;
	t_list		*actual_list;
	int			new_ints[3] = {6, 61, 65};
	char		*new_strs[5] = {
		"Alien from the movie Alien",
		"Gazorpazorpfield",
		"Predator from the movie Alien vs Predator",
		"Mike Tyson",
		"Completely Normal Dog"
	};
	int			total_ints[7] = {65, 61, 6, 5, 20, 35, 70};
	char		*total_strs[13] = {
		"Completely Normal Dog",
		"Mike Tyson",
		"Predator from the movie Alien vs Predator",
		"Gazorpazorpfield",
		"Alien from the movie Alien",
		"Giraffe",
		"Monkey",
		"Anteater",
		"Lion",
		"Thijs",
		"Baboon",
		"Chimpanzee",
		"Rhinoceros"
	};

	head = create_list(type, data, len);
	if (type == INT)
	{
		actual_list = create_list(type, total_ints, 7);
		ft_list_push_front(&head, new_ints);
		ft_list_push_front(&head, new_ints + 1);
		ft_list_push_front(&head, new_ints + 2);
		compare_lists(head, actual_list, &cmp_num, type);
	}
	if (type == STRING)
	{
		actual_list = create_list(type, total_strs, 13);
		ft_list_push_front(&head, *new_strs);
		ft_list_push_front(&head, *(new_strs + 1));
		ft_list_push_front(&head, *(new_strs + 2));
		ft_list_push_front(&head, *(new_strs + 3));
		ft_list_push_front(&head, *(new_strs + 4));
		compare_lists(head, actual_list, &strcmp, type);
	}
	/* print_list(head, type); */
	free_list(head);
	free_list(actual_list);
}

void	ft_list_size_test(int type, void *data, int len)
{
	t_list		*head;

	head = create_list(type, data, len);
	/* print_list(head, type); */
	cr_expect(ft_list_size(head) == len, "Expected list size: |%d| Actual"
			" list size: %d", len, ft_list_size(head));
}

void	ft_list_sort_test(int type, void *data, int len)
{
	t_list		*head;
	t_list		*sortedhead;
	int			int_sort_array[8] = {-400, 5, 13, 20, 35, 70, 420, 999};
	char		*sorted_array[8] = {
		"Anteater",
		"Baboon",
		"Chimpanzee",
		"Giraffe",
		"Lion",
		"Monkey",
		"Rhinoceros",
		"Thijs"
	};

	head = create_list(type, data, len);
	if (type == INT)
		sortedhead = create_list(INT, int_sort_array, 8);
	if (type == STRING)
		sortedhead = create_list(STRING, sorted_array, 8);
	/* print_list(head, type); */
	if (type == INT)
	{
		ft_list_sort(&head, &cmp_num);
		compare_lists(head, sortedhead, &cmp_num, type);
	}
	if (type == STRING)
	{
		ft_list_sort(&head, &strcmp);
		compare_lists(head, sortedhead, &strcmp, type);
	}
	/* print_list(head, type); */
	free_list(head);
	free_list(sortedhead);
}

void	ft_list_remove_if_test(int type, void *data, int len)
{
	t_list		*head;
	t_list		*actual_list;
	char		removal_string[] = "Disgraceful Visual Studio Code User";
	char		removal_string2[] = "An emacs user???";
	char		removal_string3[] = "Glorious Vim User";
	char		*final_array[5] = {
		"Glorious Vim User",
		"Glorious Vim User",
		"Glorious Vim User",
		"An emacs user???",
		"Glorious Vim User"
	};

	head = create_list(type, data, len);
	actual_list = create_list(type, final_array, 5);
	ft_list_remove_if(&head, removal_string, &strcmp);
	cr_expect(ft_list_size(head) == 5, "Expected list length after element "
			"removal: 5 Actual: %d", ft_list_size(head));
	compare_lists(head, actual_list, &strcmp, type);
	ft_list_remove_if(&head, removal_string2, &strcmp);
	ft_list_remove_if(&head, removal_string3, &strcmp);
	cr_expect(ft_list_size(head) == 0, "Expected list length after element "
			"removal: 0 Actual: %d", ft_list_size(head));
	cr_expect(head == NULL, "head should be null after every element was"
			"removed by ft_list_remove_if.");
	free_list(head);
	free_list(actual_list);
}
