import java.util.*;

public class Main {
    int recur(int mask, int idx, int N, int[][] dp, ArrayList<Integer>[] c) {
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
        ArrayList<Integer>[] c = new ArrayList[1 << b];
        ArrayList<Integer> pos = new ArrayList<Integer>();
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
        Scanner scanner = new Scanner(System.in);
        while (scanner.hasNext()) {
            int N = scanner.nextInt();
            int R = scanner.nextInt();
            System.out.println(new Main().countSequences(N, R));
        }
        scanner.close();
    }
}
