//Sequence Formatting

#include <cctype>
#include <cstdio>
#include <cstring>

char s[300];
char ans[2000];

void deal()
{
	int len = strlen(s), i = 0, j = 0, k;
	bool flag = false;
	while (i < len)
	{
		if (s[i] == ',')
		{
			ans[j++] = ',';
			if (i < len - 1)
			{
			    ans[j++] = ' ';
			}
			i++;
			flag = false;
		}
		else if (s[i] == '.')
		{
			if (i > 0)
			{
				ans[j++] = ' ';
			}
			for (k = 0; k < 3; k++)
			{
				ans[j++] = '.';
			}
			i += 3;
			flag = false;
		}
		else if (isdigit(s[i]))
		{
			while (s[i] == '0' && i + 1 < len && isdigit(s[i + 1]) && s[i + 1] != '0')
			{
				i++;
			}
			k = i + 1;
			while (k < len && s[k] == ' ')
			{
				k++;
			}
			if (k > i + 1 && k < len && isdigit(s[k]))
			{
				if (flag == false)
				{
				    ans[j++] = s[i];
					flag = true;
				}
				ans[j++] = ' ';
				ans[j++] = s[k];
				i = k;
			}
			else
			{
				if (flag == false)
				{
				    ans[j++] = s[i];
				}
				i++;
				flag = false;
			}
		}
		else
		{
			i++;
			flag = false;
		}
	}
	ans[j] = '\0';
	i = 0;
	while (i < j)
	{
		printf("%c", ans[i]);
		while (ans[i] == ' ' && i + 1 < j && ans[i + 1] == ' ')
		{
			i++;
		}
		i++;
	}
	printf("\n");
}

int main()
{
	while (gets(s))
	{
		deal();
	}
	return 0;
}
