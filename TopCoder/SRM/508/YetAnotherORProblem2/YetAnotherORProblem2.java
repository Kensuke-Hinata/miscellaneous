import java.util.*;

public class YetAnotherORProblem2 {
    int recur(int mask, int idx, int N, int[][] dp, List<Integer>[] c) {
        if (dp[mask][idx] != -1) return dp[mask][idx];
        if (idx == N) {
            dp[mask][idx] = 1;
            return 1;
        }
        final int mod = 1000000009;
        int res = 0;
        for (Integer item : c[mask]) {
            res += recur(mask | item.intValue(), idx + 1, N, dp, c);
            res %= mod;
        }
        dp[mask][idx] = res;
        return res;
    }

    public int countSequences(int N, int R) {
        int b;
        for (b = 0; (1 << b) <= R; ++ b);
        List<Integer>[] c = new ArrayList[1 << b];
        List<Integer> pos = new ArrayList<Integer>();
        for (int i = 0; i < (1 << b); ++ i) {
            c[i] = new ArrayList<Integer>();
            for (int j = 0; j < b; ++ j) {
                if ((i & (1 << j)) == 0) pos.add(Integer.valueOf(j));
            }
            int L = pos.size();
            for (int j = 0; j < (1 << L); ++ j) {
                int m = 0;
                for (int k = 0; k < L; ++ k) {
                    if ((j & (1 << k)) != 0) {
                        m |= 1 << pos.get(k).intValue();
                        if (m > R) break;
                    }
                }
                if (m <= R) c[i].add(Integer.valueOf(m));
            }
            if (pos.size() > 0) pos.clear();
        }
        int[][] dp = new int[1 << b][N + 1];
        for (int i = 0; i < (1 << b); ++ i) Arrays.fill(dp[i], -1);
        return recur(0, 0, N, dp, c);
    }

    public static void main(String[] args) {
        YetAnotherORProblem2 obj = new YetAnotherORProblem2();

        int N = 2;
        int R = 2;
        int ans = obj.countSequences(N, R);
        assert ans == 7;

        N = 2;
        R = 3;
        ans = obj.countSequences(N, R);
        assert ans == 9;

        N = 3;
        R = 3;
        ans = obj.countSequences(N, R);
        assert ans == 16;

        N = 7;
        R = 1023;
        ans = obj.countSequences(N, R);
        assert ans == 73741815;
    }
}
