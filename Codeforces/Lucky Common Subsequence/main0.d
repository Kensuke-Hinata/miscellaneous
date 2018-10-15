import std.stdio, std.string, std.typecons;
import std.algorithm;

int saiki(int i, int j, int k, int la, int lb, int lv, int[][][] dp, Tuple!(int, int, int)[][][] result, int[][] nexta, int[][] nextb, int[][] jump)
{
    if (dp[i][j][k] != -1)
    {
        return dp[i][j][k];
    }
    if (k == lv)
    {
        dp[i][j][k] = int.max;
        return int.max;
    }
    if (i == la || j == lb)
    {
        dp[i][j][k] = 0;
        return 0;
    }
    auto res = 0;
    foreach (idx; 0 .. 26)
    {
        if (nexta[i][idx] != -1 && nextb[j][idx] != -1)
        {
            auto ret = saiki(nexta[i][idx] + 1, nextb[j][idx] + 1, jump[k][idx], la, lb, lv, dp, result, nexta, nextb, jump);
            if (ret != int.max)
            {
                if (ret + 1 > res)
                {
                    result[i][j][k] = Tuple!(int, int, int)(nexta[i][idx], nextb[j][idx], jump[k][idx]);
                    res = ret + 1;
                }
            }
        }
    }
    dp[i][j][k] = res;
    return res;
}

int[][] getNext(string s)
{
    auto n = cast(int)s.length;
    auto next = new int[][](n + 1, 26);
    foreach (i; 0 .. n)
    {
        foreach (j; 0 .. 26)
        {
            next[i][j] = -1;
            foreach (k; i .. n)
            {
                if (s[k] == 'A' + j)
                {
                    next[i][j] = k;
                    break;
                }
            }
        }
    }
    return next;
}

int[][] getJump(string s)
{
    auto n = cast(int)s.length;
    auto jump = new int[][](n + 1, 26);
    foreach (i; 0 .. n)
    {
        foreach (j; 0 .. 26)
        {
            if (s[i] == 'A' + j)
            {
                jump[i][j] = i + 1;
            }
            else
            {
                jump[i][j] = 0;
                for (int k = i - 1; k >= 0; -- k)
                {
                    if (s[k] == 'A' + j)
                    {
                        auto x = k - 1, y = i - 1;
                        while (x >= 0 && y >= 0)
                        {
                            if (s[x] != s[y])
                            {
                                break;
                            }
                            -- x;
                            -- y;
                        }
                        if (x < 0)
                        {
                            jump[i][j] = k + 1;
                            break;
                        }
                    }
                }
            }
        }
    }
    return jump;
}

string construct(string a, string b, string v, Tuple!(int, int, int)[][][] result, int[][] jump)
{
    auto la = cast(int)a.length;
    auto lb = cast(int)b.length;
    auto lv = cast(int)v.length;
    auto i = 0, j = 0, k = 0;
    string res;
    while (i < la && j < lb)
    {
        if (result[i][j][k] == tuple(-1, -1, -1))
        {
            break;
        }
        auto c = a[result[i][j][k][0]];
        res ~= c;
        auto ni = result[i][j][k][0] + 1;
        auto nj = result[i][j][k][1] + 1;
        auto nk = jump[k][c - 'A']; 
        i = ni;
        j = nj;
        k = nk;
    }
    return res;
}

void solve(string a, string b, string v)
{
    auto la = cast(int)a.length;
    auto lb = cast(int)b.length;
    auto lv = cast(int)v.length;
    auto nexta = getNext(a);
    auto nextb = getNext(b);
    auto jump = getJump(v);
    auto dp = new int[][][](la + 1, lb + 1, lv + 1);
    auto result = new Tuple!(int, int, int)[][][](la + 1, lb + 1, lv + 1);
    foreach (i; 0 .. la + 1)
    {
        foreach (j; 0 .. lb + 1)
        {
            fill(dp[i][j], -1);
            fill(result[i][j], tuple(-1, -1, -1));
        }
    }
    auto ans = saiki(0, 0, 0, la, lb, lv, dp, result, nexta, nextb, jump);
    if (ans == 0)
    {
        writeln(0);
    }
    else
    {
        auto res = construct(a, b, v, result, jump);
        writeln(res);
    }
}

int main(string[] args)
{
    string s0, s1, virus;
    s0 = readln().strip();
    s1 = readln().strip();
    virus = readln().strip();
    solve(s0, s1, virus);
    return 0;
}
