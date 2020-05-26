import std.stdio, std.string;
import std.math, std.algorithm;
import std.conv;

//long[long] dup;

int recur(int idx, int n, int pmask, int qmask, int flag, int[][][][] dp, int mod, long p, long q, ref long cnt)
{
    if (idx == n)
    {
        if (flag == 0 || pmask == 1 || (pmask & qmask) == 0) return 0;
        //if (p in dup && dup[p] == q) writeln("damn it");
        //if (p >= q || p >= pow(cast(long)10, n) || q >= pow(cast(long)10, n) || p == 0 || q == 0)
        //{
            //writeln(pow(cast(long)10, n));
            //writeln(p, " ", q);
        //}
        //if (pmask == 0 || qmask == 0) writeln("suck");
        //dup[p] = q;
        //writeln(p, " ", q);
        //writeln(pmask, " ", qmask);
        ++ cnt;
        return 1;
    }
    if (dp[idx][pmask][qmask][flag] != -1) return dp[idx][pmask][qmask][flag];
    if (flag == 1 && pmask > 1 && (pmask & qmask) != 0)
    {
        auto choices = pow(cast(long)10, n - idx) % mod;
        dp[idx][pmask][qmask][flag] = (choices * choices) % mod;
        return dp[idx][pmask][qmask][flag];
    }
    auto res = 0;
    foreach (i; 0 .. 10)
    {
        auto qlower = 0;
        if (flag == 0) qlower = i;
        auto pNextMask = pmask;
        if (pmask > 1 || i > 0) pNextMask |= 1 << i;
        foreach (j; qlower .. 10)
        {
            auto nextFlag = flag;
            if (i < j) nextFlag = 1;
            auto qNextMask = qmask;
            if (qmask > 1 || j > 0) qNextMask |= 1 << j;
            auto ret = recur(idx + 1, n, pNextMask, qNextMask, nextFlag, dp, mod, p * 10 + i, q * 10 + j, cnt);
            res += ret;
            if (res >= mod) res -= mod;
        }
    }
    dp[idx][pmask][qmask][flag] = res;
    return res;
}

void solve()
{
    auto n = 18;
    auto dp = new int[][][][](n, 1024, 1024, 2);
    foreach (i; 0 .. n) foreach (j; 0 .. 1024)
    {
        foreach (k; 0 .. 1024) fill(dp[i][j][k], -1);
    }
    long cnt = 0;
    auto res = recur(0, n, 0, 0, 0, dp, 1000267129, 0, 0, cnt);
    writeln(cnt);
    writeln(res);
}

void test()
{
    auto res = 0;
    foreach (i; 1 .. 100)
    {
        auto pmask = 0;
        auto s = to!string(i);
        foreach (c; s) pmask |= 1 << (c - '0');
        foreach (j; i + 1.. 100)
        {
            auto qmask = 0;
            s = to!string(j);
            foreach (c; s) qmask |= 1 << (c - '0');
            if (pmask & qmask) ++ res;
        }
    }
    writeln(res);
}

int main(string[] args)
{
    //test;
    solve;
    return 0;
}
