import java.util.*;
import java.math.*;

public class KingdomAndPassword {
    int[] getDigits(long n) {
        List<Integer> ds = new ArrayList<Integer>();
        while (n > 0) {
            ds.add((int)(n % 10));
            n /= 10;
        }
        Collections.reverse(ds);
        int[] res = new int[ds.size()];
        for (int i = 0; i < ds.size(); ++ i) res[i] = ds.get(i).intValue();
        return res;
    }

    long[][] calcPower() {
        long[][] res = new long[10][17];
        for (int i = 0; i < 10; ++ i) {
            res[i][1] = i;
            for (int j = 2; j <= 16; ++ j) res[i][j] = res[i][j - 1] * 10;
        }
        return res;
    }

    long recur(int mask, int flag, int idx, int[] ds, int[] rds, long[][] p, long[][] dp, int t) {
        if (dp[mask][flag] != -1) return dp[mask][flag];
        if (idx == ds.length) {
            dp[mask][flag] = 0;
            return 0;
        }
        long res = (t == 0 ? Long.MIN_VALUE : Long.MAX_VALUE);
        for (int i = 0; i < ds.length; ++ i) {
            if (t == 0 && flag == 0 && ds[i] > ds[idx]) continue;
            if (t == 1 && flag == 0 && ds[i] < ds[idx]) continue;
            if ((mask & (1 << i)) == 0 && rds[idx] != ds[i]) {
                int nflag = flag;
                if (t == 0 && ds[i] < ds[idx] || t == 1 && ds[i] > ds[idx]) nflag = 1;
                long ret = recur(mask | (1 << i), nflag, idx + 1, ds, rds, p, dp, t);
                if (ret != Long.MIN_VALUE && ret != Long.MAX_VALUE) {
                    long val = p[ds[i]][ds.length - idx] + ret;
                    if (t == 0) res = Math.max(res, val);
                    else res = Math.min(res, val);
                }
            }
        }
        dp[mask][flag] = res;
        return res;
    }

    public long newPassword(long op, int[] rds) {
        int[] ds = getDigits(op);
        long[][] p = calcPower();
        long[][] dp = new long[1 << ds.length][2];
        for (int i = 0; i < dp.length; ++ i) Arrays.fill(dp[i], -1);
        long lt = recur(0, 0, 0, ds, rds, p, dp, 0);
        for (int i = 0; i < dp.length; ++ i) Arrays.fill(dp[i], -1);
        long gt = recur(0, 0, 0, ds, rds, p, dp, 1);
        if (gt == Long.MAX_VALUE && lt == Long.MIN_VALUE) return -1;
        if (gt == Long.MAX_VALUE) return lt;
        if (lt == Long.MIN_VALUE) return gt;
        return (op - lt <= gt - op ? lt : gt);
    }
    
    public static void main(String[] args) {
        KingdomAndPassword obj = new KingdomAndPassword();

        long op = 548;
        int[] rds = new int[]{5, 1, 8};
        long ans = obj.newPassword(op, rds);
        assert ans == 485;

        op = 7777;
        rds = new int[]{4, 7, 4, 7};
        ans = obj.newPassword(op, rds);
        assert ans == -1;

        op = 58;
        rds = new int[]{4, 7};
        ans = obj.newPassword(op, rds);
        assert ans == 58;

        op = 172;
        rds = new int[]{4, 7, 4};
        ans = obj.newPassword(op, rds);
        assert ans == 127;

        op = 241529363573463L;
        rds = new int[]{1, 4, 5, 7, 3, 9, 8, 1, 7, 6, 3, 2, 6, 4, 5};
        ans = obj.newPassword(op, rds);
        assert ans == 239676554423331L;

        op = 123;
        rds = new int[]{3, 2, 1};
        ans = obj.newPassword(op, rds);
        assert ans == 132;

        op = 123;
        rds = new int[]{1, 2, 3};
        ans = obj.newPassword(op, rds);
        assert ans == 231;

        op = 1;
        rds = new int[]{1};
        ans = obj.newPassword(op, rds);
        assert ans == -1;
    }
}
