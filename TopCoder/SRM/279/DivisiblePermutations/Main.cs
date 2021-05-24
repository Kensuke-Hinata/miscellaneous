using System;
using System.Collections.Generic;

public class DivisiblePermutations
{
    long Recur(int mask, int rem, int mod, int[] ds, int[] next, long[,] dp)
    {
        if (mask + 1 == (1 << ds.Length)) return (rem == 0 ? 1 : 0);
        if (dp[mask, rem] != -1) return dp[mask, rem];
        long res = 0;
        int i = 0;
        while (i < ds.Length)
        {
            if ((mask & (1 << i)) != 0)
            {
                ++ i;
            }
            else
            {
                long ret = Recur(mask | (1 << i), (rem * 10 + ds[i]) % mod, mod, ds, next, dp);
                res += ret;
                i = next[i];
            }
        }
        dp[mask, rem] = res;
        return res;
    }

    public long count(String N, int M)
    {
        int[] ds = new int[N.Length];
        for (int i = 0; i < N.Length; ++ i) ds[i] = N[i] - '0';
        Array.Sort(ds);
        int[] next = new int[ds.Length];
        next[ds.Length - 1] = ds.Length;
        for (int i = ds.Length - 2; i >= 0; -- i)
        {
            if (ds[i] == ds[i + 1]) next[i] = next[i + 1];
            else next[i] = i + 1;
        }
        long[,] dp = new long[1 << ds.Length, M];
        for (int i = 0; i < dp.GetLength(0); ++ i) for (int j = 0; j < M; ++ j) dp[i, j] = -1;
        return Recur(0, 0, M, ds, next, dp);
    }

    public static void Main()
    {
        DivisiblePermutations obj = new DivisiblePermutations();

        String N = "133";
        int M = 7;
        Console.WriteLine(obj.count(N, M));

        N = "2753";
        M = 5;
        Console.WriteLine(obj.count(N, M));

        N = "1112225";
        M = 5;
        Console.WriteLine(obj.count(N, M));

        N = "123456789";
        M = 17;
        Console.WriteLine(obj.count(N, M));

        N = "987654321999999";
        M = 39;
        Console.WriteLine(obj.count(N, M));
    }
}
