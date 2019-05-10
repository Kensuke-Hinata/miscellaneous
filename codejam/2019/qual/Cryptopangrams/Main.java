import java.util.*;
import java.math.*;

public class Main {
    private static String solve(BigInteger n, BigInteger[] nums) {
        int L = nums.length;
        BigInteger[] primes = new BigInteger[L + 1];
        int i;
        for (i = 0; i < L - 1 && nums[i].equals(nums[i + 1]); ++ i) {}
        BigInteger g = nums[i].gcd(nums[i + 1]);
        primes[i] = nums[i].divide(g);
        for (int j = i + 1; j < L + 1; ++ j) {
            primes[j] = nums[j - 1].divide(primes[j - 1]);
        }
        for (int j = i - 1; j >= 0; -- j) {
            primes[j] = nums[j].divide(primes[j + 1]);
        }
        boolean[] flag = new boolean[L + 1];
        Arrays.fill(flag, false);
        for (i = 0; i < L + 1; ++ i) {
            if (!flag[i]) {
                for (int j = i + 1; j < L + 1; ++ j) {
                    if (primes[i].equals(primes[j])) {
                        flag[j] = true;
                    }
                }
            }
        }
        String res = "";
        for (i = 0; i < L + 1; ++ i) {
            int count = 0;
            for (int j = 0; j < L + 1; ++ j) {
                if (!flag[j] && primes[j].compareTo(primes[i]) < 0) {
                    ++ count;
                }
            }
            res += (char)((int)'A' + count);
        }
        return res;
    }

    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        int T = s.nextInt();
        for (int i = 1; i <= T; ++ i) {
            BigInteger N = new BigInteger(s.next());
            int L = s.nextInt();
            BigInteger[] nums = new BigInteger[L];
            for (int j = 0; j < L; ++ j) {
                String num = s.next();
                nums[j] = new BigInteger(num);
            }
            String ret = solve(N, nums);
            System.out.print("Case #");
            System.out.print(i);
            System.out.print(": ");
            System.out.println(ret);
        }
        s.close();
    }
}
