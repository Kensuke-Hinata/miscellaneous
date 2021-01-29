import java.util.*;
import java.math.*;

public class XorLists {
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

    public int countLists(int[] s, int m) {
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
                for (int j = 0; j < bn - rn; ++ j) ret.add(0);
            }
            Collections.reverse(ret);
            xorBits[i / n][i % n] = ret;
        }
        for (int i = 0; i < n; ++ i) {
            for (int j = 0; j < bn; ++ j) {
                if (!xorBits[i][i].get(j).equals(0)) return 0;
            }
            for (int j = i + 1; j < n; ++ j) {
                for (int k = 0; k < bn; ++ k) {
                    if (!xorBits[i][j].get(k).equals(xorBits[j][i].get(k))) return 0;
                }
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
                    if ((i & (1 << k)) == 0 && (j & (1 << k)) != 0) break;
                }
                if (k == n) c[i].add(j);
            }
        }
        allc = new ArrayList<Integer>();
        for (int i = 0; i < (1 << n); ++ i) allc.add(i);
        dp = new int[bn + 1][1 << n];
        for (int i = 0; i < bn + 1; ++ i) Arrays.fill(dp[i], -1);
        return recur(0, 0);
    }

    public static void main(String[] args) {
        XorLists obj = new XorLists();

        int[] s = new int[]{0};
        int m = 10000;
        int ans = obj.countLists(s, m);
        assert ans == 10001;

        s = new int[]{1};
        m = 10000;
        ans = obj.countLists(s, m);
        assert ans == 0;

        s = new int[]{0, 1, 2, 1, 0, 3, 2, 3, 0};
        m = 5;
        ans = obj.countLists(s, m);
        assert ans == 4;

        s = new int[]{0, 3, 3, 0};
        m = 2;
        ans = obj.countLists(s, m);
        assert ans == 2;

        s = new int[]{
            0,18955782,19774078,15197314,10559559,9167552,1059865,10395923,23165910,45583720,
                18955782,0,820344,29809284,25173569,27974854,19993119,29335317,4212176,60207982,
                19774078,820344,0,30039804,25991737,27678910,20813415,28515181,5030312,60438294,
                15197314,29809284,30039804,0,4637893,7079490,16238747,7947665,25599828,38824426,
                10559559,25173569,25991737,4637893,0,2802311,11603038,4161876,29383569,35040559,
                9167552,27974854,27678910,7079490,2802311,0,10211033,1393619,32151830,37515176,
                1059865,19993119,20813415,16238747,11603038,10211033,0,9342218,24205263,44540273,
                10395923,29335317,28515181,7947665,4161876,1393619,9342218,0,33544901,36252795,
                23165910,4212176,5030312,25599828,29383569,32151830,24205263,33544901,0,64419518,
                45583720,60207982,60438294,38824426,35040559,37515176,44540273,36252795,64419518,0
        };
        m = 1000000000;
        ans = obj.countLists(s, m);
        assert ans == 976248323;
    }
}
