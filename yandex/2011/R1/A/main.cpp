#include <cstdio>

int n;
char a[5][110];

void even()
{
	int i;
	char ch = 'a';
	for (i = 0; i < n; i += 2)
	{
		a[0][i] = a[0][i + 1] = ch;
		if (ch == 'z')
		{
			ch = 'a';
		}
		else
		{
			ch++;
		}
	}
	ch = 'c';
	a[1][0] = a[2][0] = 'b';
	for (i = 1; i < n - 1; i += 2)
	{
		if (a[0][i] == ch)
		{
			if (ch == 'z')
			{
				ch = 'a';
			}
			else
			{
				ch++;
			}
		}
		if (a[0][i + 1] == ch)
		{
			if (ch == 'z')
			{
				ch = 'a';
			}
			else
			{
				ch++;
			}
		}
		a[1][i] = a[1][i + 1] = ch;
		if (ch == 'z')
		{
			ch = 'a';
		}
		else
		{
			ch++;
		}
		a[2][i] = a[2][i + 1] = ch;
		if (ch == 'z')
		{
			ch = 'a';
		}
		else
		{
			ch++;
		}
	}
	if (a[0][n - 1] == ch)
	{
		if (ch == 'z')
		{
			ch = 'a';
		}
		else
		{
			ch++;
		}
	}
	a[1][n - 1] = a[2][n - 1] = ch;
	if (ch == 'z')
	{
		ch = 'a';
	}
	else
	{
		ch++;
	}
	for (i = 0; i < n; i += 2)
	{
		if (a[2][i] == ch)
		{
			if (ch == 'z')
			{
			    ch = 'a';
			}
		    else
			{
			    ch++;
			}
		}
		if (a[2][i + 1] == ch)
		{
			if (ch == 'z')
			{
			    ch = 'a';
			}
		    else
			{
			    ch++;
			}
		}
		a[3][i] = a[3][i + 1] = ch;
		if (ch == 'z')
		{
			ch = 'a';
		}
		else
		{
			ch++;
		}
	}
}

void odd()
{
	int i;
	char ch = 'b';
	a[0][0] = a[1][0] = 'a';
	for (i = 1; i < n; i += 2)
	{
		a[0][i] = a[0][i + 1] = ch;
		if (ch == 'z')
		{
			ch = 'a';
		}
		else
		{
			ch++;
		}
		a[1][i] = a[1][i + 1] = ch;
		if (ch == 'z')
		{
			ch = 'a';
		}
		else
		{
			ch++;
		}
	}
	for (i = 0; i < n - 1; i += 2)
	{
		if (a[1][i] == ch)
		{
			if (ch == 'z')
			{
				ch = 'a';
			}
			else
			{
				ch++;
			}
		}
		if (a[1][i + 1] == ch)
		{
			if (ch == 'z')
			{
				ch = 'a';
			}
			else
			{
				ch++;
			}
		}
		a[2][i] = a[2][i + 1] = ch;
		if (ch == 'z')
		{
			ch = 'a';
		}
		else
		{
			ch++;
		}
		a[3][i] = a[3][i + 1] = ch;
		if (ch == 'z')
		{
			ch = 'a';
		}
		else
		{
			ch++;
		}
	}
	if (a[1][n - 1] == ch)
	{
		if (ch == 'z')
		{
			ch = 'a';
		}
		else
		{
			ch++;
		}
	}
	a[2][n - 1] = a[3][n - 1] = ch;
}

void deal()
{
	if (n == 1)
	{
		printf("a\na\nb\nb\n");
		return;
	}
	if (n % 2 == 0)
	{
		even();
	}
	else
	{
		odd();
	}
	a[0][n] = a[1][n] = a[2][n] = a[3][n] = '\0';
	int i;
	for (i = 0; i < 4; i++)
	{
		printf("%s\n", a[i]);
	}
}

int main()
{
	while (scanf("%d", &n) == 1)
	{
		deal();
	}
	return 0;
}
