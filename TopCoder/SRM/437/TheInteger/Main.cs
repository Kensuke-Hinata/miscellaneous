using System;
using System.Diagnostics;
using System.Collections.Generic;

public class TheInteger
{
    static long Inf = 9223372036854775807;

    List<int> GetDigits(long num)
    {
        List<int> res = new List<int>();
        while (num > 0)
        {
            res.Add((int)(num % 10));
            num /= 10;
        }
        res.Reverse();
        return res;
    }

    long Recur(int idx, int mask, int flag, int k, long[,,] dp, List<int> ds, long[,] mul)
    {
        if (dp[idx, mask, flag] != -1) return dp[idx, mask, flag];
        if (idx == ds.Count)
        {
            dp[idx, mask, flag] = (k == 0) ? 0 : Inf;
            return dp[idx, mask, flag];
        }
        long res = Inf;
        int start = (flag == 0) ? ds[idx] : 0; 
        for (int i = start; i <= 9; ++ i)
        {
            int nflag = (i > ds[idx]) ? 1 : flag;
            int nk = ((mask & (1 << i)) != 0) ? k : (k - 1);
            long ret = Recur(idx + 1, mask | (1 << i), nflag, nk, dp, ds, mul);
            if (ret != Inf)
            {
                res = mul[i, ds.Count - idx] + ret;
                break;
            }
        }
        dp[idx, mask, flag] = res;
        return res;
    }

    public long find(long n, int k)
    {
        long[,] mul = new long[10, 20];
        for (int i = 0; i <= 9; ++ i)
        {
            mul[i, 1] = i;
            for (int j = 2; j <= 19; ++ j) mul[i, j] = mul[i, j - 1] * 10;
        }
        List<int> ds = GetDigits(n);
        long[,,] dp = new long[ds.Count + 1, 1024, 2];
        for (int i = 0; i < ds.Count + 1; ++ i)
        {
            for (int j = 0; j < 1024; ++ j) dp[i, j, 0] = dp[i, j, 1] = -1;
        }
        long ret = Recur(0, 0, 0, k, dp, ds, mul);
        if (ret != Inf) return ret;
        long res = 10;
        for (int i = 0; i < Math.Max(ds.Count + 1, k) - k; ++ i) res *= 10;
        for (int d = 2; d < k; ++ d) res = res * 10 + d;
        return res;
    }

    static void Main()
    {
        TheInteger obj = new TheInteger();

        long n = 47;
        int k = 1;
        long ans = obj.find(n, k);
        Debug.Assert(ans == 55);

        n = 7;
        k = 3;
        ans = obj.find(n, k);
        Debug.Assert(ans == 102);

        n = 69;
        k = 2;
        ans = obj.find(n, k);
        Debug.Assert(ans == 69);

        n = 12364;
        k = 3;
        ans = obj.find(n, k);
        Debug.Assert(ans == 12411);

        n = 111;
        k = 3;
        ans = obj.find(n, k);
        Debug.Assert(ans == 120);

        n = 103;
        k = 4;
        ans = obj.find(n, k);
        Debug.Assert(ans == 1023);

        n = 999;
        k = 1;
        ans = obj.find(n, k);
        Debug.Assert(ans == 999);

        n = 100;
        k = 10;
        ans = obj.find(n, k);
        Debug.Assert(ans == 1023456789);

        n = 100;
        k = 3;
        ans = obj.find(n, k);
        Debug.Assert(ans == 102);

        n = 9876543210;
        k = 9;
        ans = obj.find(n, k);
        Debug.Assert(ans == 9876543211);

        n = 8876543210123456789;
        k = 1;
        ans = obj.find(n, k);
        Debug.Assert(ans == 8888888888888888888);

        n = 8876543210123456789;
        k = 9;
        ans = obj.find(n, k);
        Debug.Assert(ans == 8876543210123456800);

        n = 8876543210123456789;
        k = 10;
        ans = obj.find(n, k);
        Debug.Assert(ans == 8876543210123456789);

        n = 1000000000000000000;
        k = 1;
        ans = obj.find(n, k);
        Debug.Assert(ans == 1111111111111111111);

        n = 1000000000000000000;
        k = 9;
        ans = obj.find(n, k);
        Debug.Assert(ans == 1000000000002345678);

        n = 1000000000000000000;
        k = 10;
        ans = obj.find(n, k);
        Debug.Assert(ans == 1000000000023456789);
    }
}
