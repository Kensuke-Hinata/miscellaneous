//      Next Round.c
//      
//      Copyright 2012 Administrator <cpy@ubuntu>
//      
//      This program is free software; you can redistribute it and/or modify
//      it under the terms of the GNU General Public License as published by
//      the Free Software Foundation; either version 2 of the License, or
//      (at your option) any later version.
//      
//      This program is distributed in the hope that it will be useful,
//      but WITHOUT ANY WARRANTY; without even the implied warranty of
//      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//      GNU General Public License for more details.
//      
//      You should have received a copy of the GNU General Public License
//      along with this program; if not, write to the Free Software
//      Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//      MA 02110-1301, USA.


#include <stdio.h>

int a[50];

void func(int n, int k)
{
	int i, ans = k;
	for (i = k - 1; i >= 0 && a[i] == 0; i --)
	{
		ans --;
	}
	for (i = k; i < n && a[i] == a[k - 1] && a[i] != 0; i ++)
	{
		ans ++;
	}
	printf("%d\n", ans);
}

int main(int argc, char **argv)
{
	int n, k, i;
	while (scanf("%d%d", &n, &k) == 2)
	{
		for (i = 0; i < n; i ++)
		{
			scanf("%d", &a[i]);
		}
		func(n, k);
	}
	return 0;
}
