//Double Cola

#include <cstdio>

char t[6][20] = {"Sheldon", "Leonard", "Penny", "Rajesh", "Howard"};

int main()
{
	int n, i, d;
	while (scanf("%d", &n) == 1)
	{
		i = 1;
		while (5 * ((1 << i) - 1) < n)
		{
			i++;
		}
		n -= 5 * ((1 << (i - 1)) - 1);
		d = (1 << (i - 1));
		i = 1;
		while (n > d)
		{
			n -= d;
			i++;
		}
		printf("%s\n", t[i - 1]);
	}
	return 0;
}
