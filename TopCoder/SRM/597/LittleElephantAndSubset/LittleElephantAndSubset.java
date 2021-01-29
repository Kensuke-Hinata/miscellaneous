import java.util.*;

public class LittleElephantAndSubset {
    static int mod = 1000000007;

    int[] itoa(int n) {
        int[] res = new int[0];
        while (n > 0) {
            res = Arrays.copyOf(res, res.length + 1);
            res[res.length - 1] = n % 10;
            n /= 10;
        }
        for (int i = 0; i < (res.length >> 1); ++ i) {
            res[i] ^= res[res.length - i - 1];
            res[res.length - i - 1] ^= res[i];
            res[i] ^= res[res.length - i - 1];
        }
        return res;
    }

    boolean ok(int nm, int pm, int pl, int cl, int len) {
        if ((cl < len || nm != 2) && (pl < cl || pl == cl && pm == 0)) return true;
        return false;
    }

    int recur(int bm, int pm, int nm, int d, int pl, int cl, int[] a, int[][][][][][] dp) {
        int res = dp[bm][pm][nm][d][pl][cl];
        if (res != -1) return res;
        boolean state = ok(nm, pm, pl, cl, a.length); 
        res = state ? 1 : 0;
        for (int i = 0; i < 10; ++ i) {
            if ((bm & (1 << i)) == 0) {
                if (cl < a.length) {
                    int nextNm = nm;
                    if (nm == 0 && i != a[cl]) nextNm = i < a[cl] ? 1 : 2;
                    int ret = recur(bm | (1 << i), pm, nextNm, d, pl, cl + 1, a, dp);
                    res = (res + ret) % mod;
                }
                if (i > 0 && state) {
                    int nextPm = d < i ? 0 : 1;
                    int nextNm = 0;
                    if (i < a[0]) nextNm = 1;
                    else if (i > a[0]) nextNm = 2;
                    int ret = recur(bm | (1 << i), nextPm, nextNm, i, cl, 1, a, dp);
                    res = (res + ret) % mod;
                }
            }
        }
        dp[bm][pm][nm][d][pl][cl] = res;
        return res;
    }
    
    public int getNumber(int N) {
        int[] a = itoa(N);
        int[][][][][][] dp = new int[1024][2][3][10][a.length + 1][a.length + 1];
        for (int bm = 0; bm < 1024; ++ bm) {
            for (int pm = 0; pm < 2; ++ pm) {
                for (int nm = 0; nm < 3; ++ nm) {
                    for (int d = 0; d < 10; ++ d) {
                        for (int i = 0; i < a.length + 1; ++ i) {
                            Arrays.fill(dp[bm][pm][nm][d][i], -1);
                        }
                    }
                }
            }
        }
        int res = 0;
        for (int i = 1; i < 10; ++ i) {
            int nm = 0;
            if (i < a[0]) nm = 1;
            else if (i > a[0]) nm = 2;
            int ret = recur(1 << i, 0, nm, i, 0, 1, a, dp);
            res = (res + ret) % mod;
        }
        return res;
    }

    public static void main(String[] args) {
        LittleElephantAndSubset obj = new LittleElephantAndSubset();

        int n = 3;
        int ans = obj.getNumber(n);
        assert ans == 7;

        n = 10;
        ans = obj.getNumber(n);
        assert ans == 767;

        n = 47;
        ans = obj.getNumber(n);
        assert ans == 25775;

        n = 4777447;
        ans = obj.getNumber(n);
        assert ans == 66437071;
    }
}
