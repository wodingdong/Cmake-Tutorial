#include <stdio.h>

int add(int a, int b)
{
	printf("\nit is my add function!\n");
	return a+b;
}

int main()
{
	int sum = add(1, 2);
	printf("my sum is :%d\n\n", sum);	
	return 0;
}
