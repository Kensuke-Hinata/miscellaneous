//Average Score

#include <cstdio>
#include <algorithm>

using namespace std;

struct grade
{
	int index;
	int t;
	bool operator < (const grade a) const
	{
		if (t < a.t)
		{
			return true;
		}
		return false;
	}
}g[100011];

int s[100011];

bool cmp1 (const grade a, const grade b)
{
	if (a.t < b.t)
	{
		return true;
	}
	else if (a.t == b.t && a.index < b.index)
	{
		return true;
	}
	return false;
}

bool cmp2 (const grade a, const grade b)
{
	if (a.t < b.t)
	{
		return true;
	}
	else if (a.t == b.t && a.index > b.index)
	{
		return true;
	}
	return false;
}

int main()
{
	int a, b, n, i;
	while (scanf("%d", &n) == 1)
	{
		scanf("%d%d", &a, &b);
		for (i = 0; i < n; i++)
		{
			scanf("%d", &g[i].t);
			g[i].index = i + 1;
		}
		if (a < b)
		{
			sort(g, g + n, cmp2);
			for (i = n - 1; n - i <= a; i--)
			{
				s[g[i].index] = 1;
			}
			while (i >= 0)
			{
				s[g[i].index] = 2;
				i--;
			}
		}
		else if (a > b)
		{
			sort(g, g + n, cmp1);
			for (i = n - 1; n - i <= b; i--)
			{
				s[g[i].index] = 2;
			}
			while (i >= 0)
			{
				s[g[i].index] = 1;
				i--;
			}
		}
		else
		{
			for (i = 1; i <= a; i++)
			{
				s[i] = 1;
			}
			while (i <= n)
			{
				s[i] = 2;
				i++;
			}
		}
		for (i = 1; i < n; i++)
		{
			printf("%d ", s[i]);
		}
		printf("%d\n", s[i]);
	}
	return 0;
}
