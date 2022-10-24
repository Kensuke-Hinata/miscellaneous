import java.util.*;
import java.math.*;

public class ImageTraders {
    int[][][] dp;
    String[] p;

    int recur(int idx, int v, int mask) {
        int res = dp[idx][v][mask];
        if (res != -1) {
            return res;
        }
        res = 0;
        int n = p.length;
        for (int i = 0; i < n; ++ i) {
            if ((mask & (1 << i)) == 0) {
                int nv = p[idx].charAt(i) - '0'; 
                if (nv >= v) {
                    int ret = recur(i, nv, mask | (1 << i));
                    res = Math.max(res, ret + 1);
                }
            }
        }
        dp[idx][v][mask] = res;
        return res;
    }

    public int maxOwners(String[] p) {
        int n = p.length;
        dp = new int[n][10][1 << n];
        for (int i = 0; i < n; ++ i) {
            for (int j = 0; j < 10; ++ j) {
                Arrays.fill(dp[i][j], -1);
            }
        }
        this.p = p;
        int ret = recur(0, 0, 0);
        return ret;
    }

    public static void main(String[] args) {
        ImageTraders obj = new ImageTraders();

        String[] p = new String[]{
            "01", "10"
        };
        System.out.println(obj.maxOwners(p));

        p = new String[]{"022", "101", "110"};
        System.out.println(obj.maxOwners(p));

        p = new String[]{
            "01231", "00231", "00031", "00002", "00000"
        };
        System.out.println(obj.maxOwners(p));

        p = new String[]{
            "15555", "11111", "15111", "11111", "11111"
        };
        System.out.println(obj.maxOwners(p));

        p = new String[]{
            "0100000000", "0020000000", "0003000000",
            "0000400000", "0000050000", "0000006000",
            "0000000700", "0000000080", "0000000009", "1111111111"
        };
        System.out.println(obj.maxOwners(p));
    }
}
