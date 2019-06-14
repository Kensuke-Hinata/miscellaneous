import std.stdio, std.string;
import std.typecons;
import std.algorithm;

struct XD
{
    int c;
    int d;
}

long saiki(int idx, int rem, long[][] dp, XD[][] b)
{
    auto res = dp[idx][rem];
    if (res != -1) return res;
    if (idx == cast(int)b.length)
    {
        dp[idx][rem] = 0;
        return 0;
    }
    auto one = new int[3];
    fill(one, -1);
    auto two = -1;
    auto three = -1;
    foreach (i; 0 .. b[idx].length)
    {
        auto d = b[idx][i].d;
        if (b[idx][i].c == 1)
        {
            foreach (j; 0 .. 3)
            {
                if (d >= one[j])
                {
                    for (int k = 2; k > j; -- k) one[k] = one[k - 1];
                    one[j] = d;
                    break;
                }
            }
        }
        else if (b[idx][i].c == 2)
        {
            if (d > two) two = d;
        }
        else
        {
            if (d > three) three = d;
        }
    }
    res = saiki(idx + 1, rem, dp, b);
    bool twice = (rem == 9);
    long ret = saiki(idx + 1, (rem + 1) % 10, dp, b);
    if (three != -1)
    {
        if (twice) res = max(res, ret + (three << 1));
        else res = max(res, ret + three);
    }
    if (two != -1)
    {
        if (twice) res = max(res, ret + (two << 1));
        else res = max(res, ret + two);
    }
    if (one[0] != -1)
    {
        if (twice) res = max(res, ret + (one[0] << 1));
        else res = max(res, ret + one[0]);
    }
    twice = (rem == 8 || rem == 9);
    ret = saiki(idx + 1, (rem + 2) % 10, dp, b);
    if (one[1] != -1)
    {
        if (twice) res = max(res, ret + (one[0] << 1) + one[1]);
        else res = max(res, ret + one[0] + one[1]);
    }
    if (one[0] != -1 && two != -1)
    {
        if (twice) res = max(res, ret + (max(one[0], two) << 1) + min(one[0], two));
        else res = max(res, ret + one[0] + two);
    }
    if (one[2] != -1)
    {
        twice = (rem >= 7 && rem < 10);
        ret = saiki(idx + 1, (rem + 3) % 10, dp, b);
        if (twice) res = max(res, ret + (one[0] << 1) + one[1] + one[2]);
        else res = max(res, ret + one[0] + one[1] + one[2]);
    }
    dp[idx][rem] = res;
    return res;
}

void solve(XD[][] b)
{
    auto n = cast(int)b.length;
    auto dp = new long[][](n + 1, 10);
    foreach (i; 0 .. n + 1) fill(dp[i], -1);
    auto ans = saiki(0, 0, dp, b);
    writeln(ans);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto b = new XD[][n];
        foreach (i; 0 .. n)
        {
            int k;
            readf("%d\n", &k);
            b[i] = new XD[k];
            foreach (j; 0 .. k) readf("%d %d\n", &b[i][j].c, &b[i][j].d);
        }
        solve(b);
    }
    return 0;
}
