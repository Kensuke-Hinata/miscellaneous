import java.util.*;

public class Main {
    static int[] p = {2, 3, 5, 7};
    boolean check(long n, int prime) {
        while (n != 0) {
            if (n % 10 == prime) return true;
            n /= 10;
        }
        return false;
    }
    int countBits(int n) {
        int res = 0;
        while (n != 0) {
            if ((n & 1) != 0) {
                ++ res;
            }
            n >>= 1;
        }
        return res;
    }
    void solve(long[] a) {
        int n = a.length;
        long ans = 0;
        int[][] f = new int[n][4];
        for (int i = 0; i < n; ++ i) {
            for (int j = 0; j < 4; ++ j) {
                if (check(a[i], p[j])) {
                    f[i][j] = 1;
                } else {
                    f[i][j] = -1;
                }
            }
        }
        for (int i = 1; i < 16; ++ i) {
            long count = 0;
            for (int k = 0; k < n; ++ k) {
                int j;
                for (j = 0; j < 4; ++ j) {
                    if ((i & (1 << j)) != 0) {
                        if (f[k][j] == -1) {
                            break;
                        }
                    }
                }
                if (j == 4) {
                    ++ count;
                }
            }
            long tot = count * (count - 1) * (count - 2) / 6;
            if ((countBits(i) & 1) != 0) {
                ans += tot;  
            } else {
                ans -= tot;
            }
        }
        System.out.println(ans);
    }
    public static void main(String[] args) {
        int n;
        Scanner s = new Scanner(System.in);
        Main m = new Main();
        while (s.hasNext()) {
            n = s.nextInt();
            long[] a = new long[n];
            for (int i = 0; i < n; ++ i) {
                a[i] = s.nextLong();
            }
            m.solve(a);
        }
        s.close();
    }
}
