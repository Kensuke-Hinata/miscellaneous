using System;
using System.Diagnostics;
using System.Collections.Generic;

public class YetAnotherORProblem 
{
    List<int> GetBits(long num)
    {
        List<int> res = new List<int>();
        for (int i = 62; i >= 0; -- i)
        {
            res.Add((int)(num & 1));
            num >>= 1;
        }
        res.Reverse();
        return res;
    }

    int Recur(int idx, int mask, int n, int[,] dp, List<int>[] b, int[,] cmask)
    {
        if (dp[idx, mask] != -1) return dp[idx, mask];
        if (idx == 63)
        {
            dp[idx, mask] = 1;
            return 1;
        }
        const int mod = 1000000009;
        int res = 0;
        for (int i = 0; i < n; ++ i)
        {
            if (b[i][idx] == 1 || (mask & (1 << i)) != 0)
            {
                res += Recur(idx + 1, mask | cmask[idx, i], n, dp, b, cmask);
                res %= mod;
            }
        }
        res += Recur(idx + 1, mask | cmask[idx, n], n, dp, b, cmask);
        res %= mod;
        dp[idx, mask] = res;
        return res;
    }

    public int countSequences(long[] R)
    {
        int n = R.Length;
        List<int>[] b = new List<int>[n];
        for (int i = 0; i < n; ++ i) b[i] = GetBits(R[i]);
        int[,] cmask = new int[63, n + 1];
        for (int i = 0; i < 63; ++ i)
        {
            int mask;
            for (int j = 0; j < n; ++ j)
            {
                mask = 0;
                for (int k = 0; k < n; ++ k)
                {
                    if (j != k && b[k][i] == 1) mask |= 1 << k;
                }
                cmask[i, j] = mask;
            }
            mask = 0;
            for (int j = 0; j < n; ++ j) if (b[j][i] == 1) mask |= 1 << j;
            cmask[i, n] = mask;
        }
        int[,] dp = new int[64, 1 << n];
        for (int i = 0; i < 64; ++ i)
        {
            for (int j = 0; j < (1 << n); ++ j) dp[i, j] = -1;
        }
        return Recur(0, 0, n, dp, b, cmask);
    }

    static void Main()
    {
        YetAnotherORProblem obj = new YetAnotherORProblem();

        long[] R = new long[]{3, 5};
        int ans = obj.countSequences(R);
        Debug.Assert(ans == 15);

        R = new long[]{3, 3, 3};
        ans = obj.countSequences(R);
        Debug.Assert(ans == 16);

        R = new long[]{1, 128};
        ans = obj.countSequences(R);
        Debug.Assert(ans == 194);

        R = new long[]{26, 74, 25, 30};
        ans = obj.countSequences(R);
        Debug.Assert(ans == 8409);

        R = new long[]{1000000000,1000000000};
        ans = obj.countSequences(R);
        Debug.Assert(ans == 420352509);
    }
}
