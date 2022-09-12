import java.util.*;
import java.math.*;

public class Main {
    public void calc(int[] a, int[] b, int[] k, int[] p) {
        int n = a.length, m = k.length;
        int ma = -1, mb = -1;
        for (int i = 0; i < n; ++ i) {
            ma = Math.max(ma, a[i]);
            mb = Math.max(mb, b[i]);
        }
        int[][] opt = new int[mb + 1][ma + 1];
        int[][] dp = new int[m][ma + 1];
        for (int i = 0; i <= mb; ++ i) {
            for (int j = 0; j < m; ++ j) {
                dp[j][0] = 0;
            }
            for (int j = 1; j <= ma; ++ j) {
                if (p[0] > i) {
                    dp[0][j] = j / (p[0] - i) * k[0];
                    if (j % (p[0] - i) != 0) {
                        dp[0][j] += k[0];
                    }
                } else {
                    dp[0][j] = Integer.MAX_VALUE;
                }
            }
            for (int j = 1; j < m; ++ j) {
                for (int t = 1; t <= ma; ++ t) {
                    dp[j][t] = dp[j - 1][t];
                    if (p[j] > i) {
                        if (t <= p[j] - i) {
                            dp[j][t] = Math.min(dp[j][t], k[j]);
                        } else {
                            dp[j][t] = Math.min(dp[j][t], dp[j][t - (p[j] - i)] + k[j]);
                            dp[j][t] = Math.min(dp[j][t], dp[j - 1][t - (p[j] - i)] + k[j]);
                        }
                    }
                }
            }
            for (int j = 0; j <= ma; ++ j) {
                opt[i][j] = dp[m - 1][j];
            }
        }
        long ans = 0;
        for (int i = 0; i < n; ++ i) {
            if (opt[b[i]][a[i]] == Integer.MAX_VALUE) {
                System.out.println(-1);
                return;
            }
            ans += opt[b[i]][a[i]];
        }
        System.out.println(ans);
    }

    public static void main(String[] args) {
        Main obj = new Main();
        Scanner s = new Scanner(System.in);
        while (s.hasNextInt()) {
            int n = s.nextInt();
            int m = s.nextInt();
            int[] a = new int[n];
            int[] b = new int[n];
            int[] k = new int[m];
            int[] p = new int[m];
            for (int i = 0; i < n; ++ i) {
                a[i] = s.nextInt();
                b[i] = s.nextInt();
            }
            for (int i = 0; i < m; ++ i) {
                k[i] = s.nextInt();
                p[i] = s.nextInt();
            }
            obj.calc(a, b, k, p);
        }
    }
}
