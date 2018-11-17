import std.stdio, std.string;
import std.random;

int getPosition(T)(T[] arr, int[] index, T tar)
{
    int l = 0, r = cast(int)index.length - 1, idx = -1;
    while (l <= r)
    {
        int m = (l + r) >> 1;
        if (arr[index[m]] < tar)
        {
            l = m + 1;
        }
        else
        {
            idx = m;
            r = m - 1;
        }
    }
    if (idx == -1)
    {
        idx = cast(int)index.length;
    }
    return idx;
}

void solve(int[] a)
{
    int[][40] one;
    int[][40] zero;
    foreach (int i; 0 .. 32)
    {
        foreach (int j; 0 .. cast(int)a.length)
        {
            if ((a[j] & (1 << i)) == 0)
            {
                zero[i] ~= j;
            }
            else
            {
                one[i] ~= j;
            }
        }
    }
    int tar = -1;
    for (int pos = 30; pos >= 0; -- pos)
    {
        if (one[pos].length > 0)
        {
            int i;
            for (i = 0; i < pos; ++ i)
            {
                if (zero[i].length == 0)
                {
                    break;
                }
                int j;
                int idx = getPosition(a, zero[i], 1 << pos);
                for (j = idx; j < zero[i].length; ++ j)
                {
                    if (a[zero[i][j]] & (1 << pos))
                    {
                        break;
                    }
                }
                if (j == zero[i].length)
                {
                    break;
                }
            }
            if (i == pos)
            {
                tar = pos;
                break;
            }
        }
    }
    if (tar == -1)
    {
        writefln("-1");
        return;
    }
    bool[] flag = new bool[a.length];
    int k = 0;
    foreach (int i; 0 .. cast(int)one[tar].length)
    {
        ++ k;
        flag[one[tar][i]] = true;
    }
    foreach (int i; 0 .. tar)
    {
        foreach (int j; 0 .. cast(int)zero[i].length)
        {
            if ((a[zero[i][j]] & (1 << tar)) && flag[zero[i][j]] == false)
            {
                ++ k;
                flag[zero[i][j]] = true;
            }
        }
    }
    /*foreach (int i; 0 .. a.length)
    {
        if (flag[i] == false && (a[i] & (1 << tar)) != 0)
        {
            ++ k;
            flag[i] = true;
        }
    }*/
    writefln("%d", k);
    foreach (int i; 0 .. cast(int)a.length)
    {
        if (flag[i] == true)
        {
            writef("%d ", a[i]);
        }
    }
    writefln("");
}

void main(string[] args)
{
    int n;
    while (scanf("%d", &n) == 1)
    {
        int[] a = new int[n];
        foreach (int i; 0 .. n)
        {
            //a[i] = uniform(0, 1000000000) + 1;
            //a[i] = 1000000000 - i;
            scanf("%d", &a[i]);
        }
        solve(a);
    }
}
