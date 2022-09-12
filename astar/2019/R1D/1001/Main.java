import java.util.*;
import java.math.*;

public class Main {
    final static BigInteger b7 = BigInteger.valueOf(7); 
    final static BigInteger b18 = BigInteger.valueOf(18); 

    BigInteger solve(long n, BigInteger a, BigInteger b) {
        if (n == 0) return BigInteger.ZERO;
        BigInteger bn = BigInteger.valueOf(n);
        BigInteger res = bn;
        for (int i = 0; i < 2; ++ i) res = res.multiply(bn);
        res = res.multiply(b);
        BigInteger v = BigInteger.valueOf(n - 1);
        for (int i = 0; i < 2; ++ i) v = v.multiply(bn);
        v = v.multiply(a);
        res = res.add(v);
        if ((n & 1) == 0) {
            BigInteger ret = solve(n >> 1, a, b);
            ret = ret.multiply(b7);
            v = BigInteger.valueOf(n >> 1);
            v = v.multiply(v).multiply(b18).multiply(a);
            ret = ret.add(v);
            res = res.min(ret);
        }
        return res;
    }

    public static void main(String[] args) {
        final BigInteger m = BigInteger.valueOf(1000000007);
        Main obj = new Main();
        Scanner s = new Scanner(System.in);
        int t = s.nextInt();
        for (int i = 0; i < t; ++ i) {
            long n = s.nextLong();
            int a = s.nextInt();
            int b = s.nextInt();
            BigInteger res = obj.solve(n, BigInteger.valueOf(a), BigInteger.valueOf(b));
            System.out.println(res.mod(m));
        }
        s.close();
    }
}
