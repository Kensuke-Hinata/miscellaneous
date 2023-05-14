//Plug-in

#include <cstdio>
#include <cstring>

char s[200011];
int next[200011];
int prior[200011];

void deal()
{
	int i, beg = 0, len = strlen(s);
	for (i = 0; i < len; i++)
	{
		next[i] = i + 1;
		prior[i] = i - 1;
	}
	bool flag;
	while (true)
	{
		i = beg;
		flag = false;
		while (i < len)
		{
			while (i < len && next[i] < len && s[i] == s[next[i]])
			{
				prior[next[next[i]]] = prior[i];
				if (prior[i] >= beg)
				{
					next[prior[i]] = next[next[i]];
					i = prior[i];
				}
				else
				{
				    i = next[next[i]];
					beg = i;
				}
				flag = true;
			}
			i = next[i];
		}
		if (!flag)
		{
			break;
		}
	}
	for (i = beg; i < len; i = next[i])
	{
		printf("%c", s[i]);
	}
	printf("\n");
}

int main()
{
	while (scanf("%s", s) == 1)
	{
		deal();
	}
    return 0;
}
