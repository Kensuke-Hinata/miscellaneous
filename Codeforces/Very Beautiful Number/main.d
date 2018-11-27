import std.stdio;

int[1000010] ans, tmp;

void update(int[] tar, int[] data, int len)
{
    for (int idx = 0; idx < len; ++ idx)
    {
        tar[idx] = data[idx];
    }
}

void solve(int p, int x)
{
    bool succ = false;
    foreach (int last; 0 .. 10)
    {
        tmp[p - 1] = last;
        int carry = 0, val;
        for (int idx = p - 2; idx >= 0; -- idx)
        {
            val = x * tmp[idx + 1] + carry;
            tmp[idx] = val % 10;
            carry = val / 10;
        }
        if (tmp[0] == 0)
        {
            continue;
        }
        val = x * tmp[0] + carry;
        if (val % 10 == tmp[p - 1] && val / 10 == 0)
        {
            if (succ)
            {
                bool flag = false;
                for (int idx = 0; idx < p; ++ idx)
                {
                    if (tmp[idx] < ans[idx])
                    {
                        flag = true;
                    }
                    if (tmp[idx] != ans[idx])
                    {
                        break;
                    }
                }
                if (flag == true)
                {
                    update(ans, tmp, p);
                }
            }
            else
            {
                succ = true;
                update(ans, tmp, p);
            }
        }
    }
    if (succ)
    {
        for (int idx = 0; idx < p; ++ idx)
        {
            write(ans[idx]);
        }
        writeln();
    }
    else
    {
        writeln("Impossible");
    }
}

void main()
{
    int p, x;
    while (scanf("%d%d", &p, &x) == 2)
    {
        solve(p, x);
    }
}
