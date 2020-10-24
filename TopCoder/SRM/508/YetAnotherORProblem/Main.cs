using System;
using System.Collections.Generic;

public class YetAnotherORProblem 
{
    List<int> toBinary(long num)
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

    int recur(int idx, int mask, int n, int[,] dp, List<int>[] b, int[,] cmask)
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
                res += recur(idx + 1, mask | cmask[idx, i], n, dp, b, cmask);
                res %= mod;
            }
        }
        res += recur(idx + 1, mask | cmask[idx, n], n, dp, b, cmask);
        res %= mod;
        dp[idx, mask] = res;
        return res;
    }

    int countSequences(long[] R)
    {
        int n = R.Length;
        List<int>[] b = new List<int>[n];
        for (int i = 0; i < n; ++ i) b[i] = toBinary(R[i]);
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
        return recur(0, 0, n, dp, b, cmask);
    }

    static void Main()
    {
        YetAnotherORProblem obj = new YetAnotherORProblem();
        /*string str = string.Empty;*/
        //do
        //{
            //str = Console.ReadLine();
            //if (str == null) break;
            //string[] words = str.Split(' ');
            //int N, R;
            //int.TryParse(words[0], out N);
            //int.TryParse(words[1], out R);
            //long[] a = new long[N];
            //for (int i = 0; i < N; ++ i)
            //{
                //a[i] = R;
            //}
            //Console.WriteLine(obj.countSequences(a));
        /*} while (true);*/
        /*long[] R = new long[2];*/
        //R[0] = R[1] = 2;
        //Console.WriteLine(obj.countSequences(R));
        //R[0] = R[1] = 3;
        //Console.WriteLine(obj.countSequences(R));
        //R = new long[3];
        //R[0] = R[1] = R[2] = 3;
        //Console.WriteLine(obj.countSequences(R));
        //R = new long[7];
        //for (long i = 0; i < 7; ++ i)
        //{
            //R[i] = 1023;
        //}
        //Console.WriteLine(obj.countSequences(R));
        //R = new long[2];
        //R[0] = 3;
        //R[1] = 5;
        //Console.WriteLine(obj.countSequences(R));
        //R = new long[2];
        //R[0] = 1;
        //R[1] = 128;
        //Console.WriteLine(obj.countSequences(R));
        //R = new long[4];
        //R[0] = 26;
        //R[1] = 74;
        //R[2] = 25;
        //R[3] = 30;
        //Console.WriteLine(obj.countSequences(R));
        //R = new long[2];
        //R[0] = R[1] = 1000000000;
        //Console.WriteLine(obj.countSequences(R));
        //R = new long[10];
        //for (int i = 0; i < 10; ++ i)
        //{
            //R[i] = 15000;
        //}
        /*Console.WriteLine(obj.countSequences(R));*/
        long[] R = new long[10];
        for (int i = 0; i < 10; ++ i) R[i] = 1000000000000000000;
        Console.WriteLine(obj.countSequences(R));
    }
}
