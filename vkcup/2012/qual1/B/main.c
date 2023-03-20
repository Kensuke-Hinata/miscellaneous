//      Taxi.c
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
#include <string.h>

#define MIN(a, b) ((a) < (b) ? (a) : (b))

int c[5];

void func()
{
	int ans = c[4], t;
	t = MIN(c[1], c[3]);
	ans += t;
	c[3] -= t;
	c[1] -= t;
	t = MIN(c[1] >> 1, c[2]);
	ans += t;
	c[1] -= (t << 1);
	c[2] -= t;
	ans += (c[2] >> 1);
	c[2] &= 1;
	ans += (c[1] >> 2);
	c[1] %= 4;
	if (c[2] == 1 && c[1] == 1)
	{
		ans ++;
		c[2] = c[1] = 0;
	}
	if (c[1])
	{
		ans ++;
	}
	ans += c[2];
	ans += c[3];
	printf("%d\n", ans);
}

int main(int argc, char **argv)
{
	int n, s, i;
	while (scanf("%d", &n) == 1)
	{
		memset(c, 0, sizeof(c));
		for (i = 0; i < n; i ++)
		{
			scanf("%d", &s);
			c[s] ++;
		}
		func();
	}
	return 0;
}
