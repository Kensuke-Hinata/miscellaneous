//General Mobilization

#include <cstdio>
#include <cstring>
#include <vector>
#include <algorithm>

using namespace std;

struct railway
{
	int child, c, count;
	vector<pair<int, int> > select;
};

int n;
vector<railway> tree[5001];
int a[5001];
int p[5001];
int d[5001];
int nxt[5001];
int len[5001];
int t[5001];
bool v[5001];

void search (int root)
{
	v[root] = true;
	int i;
	for (i = 0; i < len[root]; i++)
	{
		if (v[tree[root][i].child] == false)
		{
			nxt[tree[root][i].child] = root;
			search(tree[root][i].child);
		}
	}
}

bool cmp (const pair<int, int> p, const pair<int, int> q)
{
	if (p.second < q.second)
	{
		return true;
	}
	return false;
}

void deal()
{
	memset(v, false, (n + 1) * sizeof(bool));
	int i, j = 1, k, f, time = 1, beg = 2;
	for (i = 1; i <= n; i++)
	{
		len[i] = tree[i].size();
	}
	search(1);
	for (i = 1; i <= n; i++)
	{
		d[i] = p[i] = i;
	}
	t[1] = 0;
//	memset(count, 0, (n + 1) * sizeof(int));
	while (j < n)
	{
/*		for (i = 1; i <= n; i++)
		{
			for (k = 0; k < len[i]; k++)
			{
				tree[i][k].count = 0;
//				tree[i][k].maxs = -1;
			}
		}*/
		for (i = beg; i <= n; i++)
		{
			if (p[i] == 1)
			{
				continue;
			}
			f = nxt[p[i]];
			for (k = 0; k < len[f]; k++)
			{
				if (tree[f][k].child == p[i])
				{
					break;
				}
			}
			tree[f][k].select.push_back(make_pair(i, a[i]));
//			tree[i][k].count++;
//			count[f]++;
		}
		for (i = 1; i <= n; i++)
		{
			for (k = 0; k < len[i]; k++)
			{
				if (tree[i][k].select.size() != 0)
				{
					sort(tree[i][k].select.begin(), tree[i][k].select.end(), cmp);
/*					for (f = 0; f < tree[i][k].select.size(); f++)
					{
						printf("%d\n", tree[i][k].select[f].first);
					}*/
					for (f = 0; f < tree[i][k].c && f < tree[i][k].select.size(); f++)
					{
						p[tree[i][k].select[f].first] = nxt[p[tree[i][k].select[f].first]];
						if (p[tree[i][k].select[f].first] == 1)
						{
							t[tree[i][k].select[f].first] = time;
							j++;
						}
					}
				}
			}
		}
		for (i = 1; i <= n; i++)
		{
			for (k = 0; k < len[i]; k++)
			{
				if (tree[i][k].select.size() != 0)
				{
					tree[i][k].select.clear();
				}
			}
		}
		while (beg <= n && p[beg] == 1)
		{
			beg++;
		}
		time++;
	}
	for (i = 1; i < n; i++)
	{
		printf("%d ", t[i]);
	}
	printf("%d\n", t[i]);
}

int main()
{
	int i, x, y, z;
	railway temp;
	while (scanf("%d", &n) == 1)
	{
		for (i = 1; i <= n; i++)
		{
			scanf("%d", &a[i]);
//			len[i] = 0;
		}
		for (i = 0; i < n - 1; i++)
		{
			scanf("%d%d%d", &x, &y, &z);
			temp.child = y;
			temp.c = z;
			tree[x].push_back(temp);
			temp.child = x;
			tree[y].push_back(temp);
		}
/*		for (i = 0; i < n - 1; i++)
		{
			scanf("%d%d%d", &x, &y, &z);
			tree[x][len[x]].child = y;
			tree[x][len[x]].c = z;
			len[x]++;
			tree[y][len[y]].child = x;
			tree[y][len[y]].c = z;
			len[y]++;
		}*/
		deal();
		for (i = 1; i <= n; i++)
		{
			tree[i].clear();
		}
	}
	return 0;
}
