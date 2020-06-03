import java.util.*;
import java.math.*;

public class Main {
    BigInteger recur(int idx, int n, BigInteger[] dp) {
        if (idx == n) {
            return new BigInteger("1");
        }
        if (idx > n) {
            return new BigInteger("0");
        }
        if (!dp[idx].equals(new BigInteger("-1"))) {
            return dp[idx];
        }
        BigInteger res = new BigInteger("0");
        res = res.add(recur(idx + 1, n, dp));
        res = res.add(recur(idx + 2, n, dp));
        dp[idx] = res;
        return res;
    }

    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        Main b = new Main();
        while (s.hasNext()) {
            int N = s.nextInt();
            BigInteger[] dp = new BigInteger[N + 1];
            Arrays.fill(dp, new BigInteger("-1"));
            BigInteger res = b.recur(0, N, dp);
            System.out.println(res);
        }
    }
}
