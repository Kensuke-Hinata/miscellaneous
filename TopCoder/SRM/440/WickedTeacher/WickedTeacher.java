import java.util.*;
import java.math.*;

public class WickedTeacher {
    static long gcd(long a, long b) {
        if (a == 0) return b;
        return gcd(b % a, a);
    }

    long recur(int mask, int r, int k, String[] nums, int[] rem, int[][] nrem, long[][] dp) {
        if (mask + 1 == (1 << nums.length)) return (r == 0 ? 1 : 0);
        long res = dp[mask][r];
        if (res != -1) return res;
        res = 0;
        for (int i = 0; i < nums.length; ++ i) if ((mask & (1 << i)) == 0) {
            int nr = (nrem[r][nums[i].length()] + rem[i]) % k;
            long ret = recur(mask | (1 << i), nr, k, nums, rem, nrem, dp);
            res += ret;
        }
        dp[mask][r] = res;
        return res;
    }

    public String cheatProbability(String[] nums, int k) {
        int n = nums.length;
        int[] rem = new int[n];
        for (int i = 0; i < n; ++ i) {
            rem[i] = 0;
            for (int j = 0; j < nums[i].length(); ++ j) {
                rem[i] = (rem[i] * 10 + (nums[i].charAt(j) - '0')) % k;
            }
        }
        int ml = 0;
        for (int i = 0; i < n; ++ i) ml = Math.max(ml, nums[i].length());
        int[][] nrem = new int[k][ml + 1];
        for (int i = 0; i < k; ++ i) {
            nrem[i][0] = i;
            for (int j = 1; j <= ml; ++ j) nrem[i][j] = (nrem[i][j - 1] * 10) % k;
        }
        long[][] dp = new long[1 << n][k];
        for (int i = 0; i < (1 << n); ++ i) Arrays.fill(dp[i], -1);
        long c = recur(0, 0, k, nums, rem, nrem, dp);
        long t = 1;
        for (int i = 2; i <= n; ++ i) t *= i;
        long g = gcd(c, t);
        c /= g; t /= g;
        return String.format("%d/%d", c, t);
    }

    public static void main(String[] args) {
        WickedTeacher obj = new WickedTeacher(); 

        String[] nums = new String[]{"3", "2", "1"};
        int k = 2;
        System.out.println(obj.cheatProbability(nums, k));

        nums = new String[]{"10", "100", "1000", "10000", "100000"};
        k = 10;
        System.out.println(obj.cheatProbability(nums, k));

        nums = new String[]{"11", "101", "1001", "10001", "100001"};
        k = 10;
        System.out.println(obj.cheatProbability(nums, k));

        nums = new String[]{"13", "10129414190271203", "102", "102666818896", "1216", "1217", "1218", "101278001", "1000021412678412681"};
        k = 21;
        System.out.println(obj.cheatProbability(nums, k));
    }
}
