import java.util.*;
import java.math.*;

public class Main {
    protected int n;
    protected int bn;
    protected boolean[][] ok;
    protected int[][] dp;
    protected int[][] next;
    protected List[] c;
    protected List<Integer> allc;
    protected List<Integer> mbits;
    protected List[][] xorBits;

    protected static List<Integer> transform(int m) {
        List<Integer> res = new ArrayList<Integer>();
        while (m != 0) {
            res.add(m & 1);
            m >>= 1;
        }
        return res;
    }

    protected int recur(int idx, int mask) {
        if (dp[idx][mask] != -1) return dp[idx][mask];
        if (idx == bn) {
            dp[idx][mask] = 1;
            return 1;
        }
        List cand;
        if (mbits.get(idx) == 1) cand = allc;
        else cand = c[mask];
        final int mod = 1000000007;
        int res = 0;
        for (Object m : cand) {
            int val = ((Integer)m).intValue();
            if (ok[idx][val]) {
                int ret = recur(idx + 1, mask | next[idx][val]);
                res = (res + ret) % mod;
            }
        }
        dp[idx][mask] = res;
        return res;
    }

    int countLists(int[] s, int m) {
        n = (int)Math.sqrt(s.length);
        mbits = transform(m);
        Collections.reverse(mbits);
        bn = mbits.size();
        xorBits = new List[n][n];
        for (int i = 0; i < s.length; ++ i) {
            List<Integer> ret = transform(s[i]);
            if (ret.size() > bn) return 0;
            if (ret.size() < bn) {
                int rn = ret.size();
                for (int j = 0; j < bn - rn; ++ j) {
                    ret.add(0);
                }
            }
            Collections.reverse(ret);
            xorBits[i / n][i % n] = ret;
        }
        for (int i = 0; i < n; ++ i) {
            for (int j = 0; j < xorBits[i][i].size(); ++ j) {
                if (!xorBits[i][i].get(j).equals(0)) return 0;
            }
        }
        ok = new boolean[mbits.size()][1 << n];
        for (int i = 0; i < bn; ++ i) {
            for (int j = 0; j < (1 << n); ++ j) {
                ok[i][j] = true;
                for (int k = 0; k < n; ++ k) {
                    for (int t = k + 1; t < n; ++ t) {
                        int b0 = (j & (1 << k)) >> k;
                        int b1 = (j & (1 << t)) >> t;
                        if (!xorBits[k][t].get(i).equals(b0 ^ b1)) {
                            ok[i][j] = false;
                            break;
                        }
                    }
                    if (ok[i][j] == false) break;
                }
            }
        }
        next = new int[bn][1 << n];
        for (int i = 0; i < bn; ++ i) {
            for (int j = 0; j < (1 << n); ++ j) {
                next[i][j] = 0;
                for (int k = 0; k < n; ++ k) {
                    if (!mbits.get(i).equals(0) && (j & (1 << k)) == 0) {
                        next[i][j] |= 1 << k;
                    }
                }
            }
        }
        c = new List[1 << n];
        for (int i = 0; i < (1 << n); ++ i) {
            c[i] = new ArrayList<Integer>();
            for (int j = 0; j < (1 << n); ++ j) {
                int k;
                for (k = 0; k < n; ++ k) {
                    if ((i & (1 << k)) == 0 && (j & (1 << k)) != 0) {
                        break;
                    }
                }
                if (k == n) c[i].add(j);
            }
        }
        allc = new ArrayList<Integer>();
        for (int i = 0; i < (1 << n); ++ i) {
            allc.add(i);
        }
        dp = new int[bn + 1][1 << n];
        for (int i = 0; i < bn + 1; ++ i) Arrays.fill(dp[i], -1);
        return recur(0, 0);
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        while (scanner.hasNextInt()) {
            int n = scanner.nextInt();
            int[] s = new int[n];
            for (int i = 0; i < n; ++ i) {
                s[i] = scanner.nextInt();
            }
            int m = scanner.nextInt();
            int ans = new Main().countLists(s, m);
            System.out.println(ans);
        }
        scanner.close();
    }
}
