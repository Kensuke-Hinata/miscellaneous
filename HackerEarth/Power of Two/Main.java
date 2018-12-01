import java.util.*;

public class Solver {
    void solve(int[] a) {
        int n = a.length;
        int[][] b = new int[31][n];
        for (int i = 0; i < 31; ++ i) {
            for (int j = 0; j < n; ++ j) {
                if ((a[j] & (1 << i)) != 0) {
                    b[i][j] = 1;
                } else {
                    b[i][j] = -1;
                }
            }
        }
        for (int i = 0; i < 31; ++ i) {
            int j;
            for (j = 0; j < n; ++ j) {
                if (b[i][j] == 1) break;
            }
            if (j == n) continue;
            for (j = 0; j < 31; ++ j) {
                if (i == j) continue;
                int k;
                for (k = 0; k < n; ++ k) {
                    if (b[i][k] == 1 && b[j][k] == -1) break;
                }
                if (k == n) break;
            }
            if (j == 31) {
                System.out.println("YES");
                return;
            }
        }
        System.out.println("NO");
    }
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        Solver solver = new Solver();
        int T = s.nextInt();
        for (int i = 0; i < T; ++ i) {
            int N = s.nextInt();
            int[] A = new int[N];
            for (int j = 0; j < N; ++ j) {
                A[j] = s.nextInt();
            }
            solver.solve(A);
        }
        s.close();
    }
}
