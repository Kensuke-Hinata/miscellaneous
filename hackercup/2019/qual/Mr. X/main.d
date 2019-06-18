import std.stdio, std.string;
import std.algorithm;

void or(int left, int right, int modify, int[] p, int[] pLeft, int[] pRight, ref string s)
{
    p[0] = min(p[0], pLeft[0] + pRight[0] + modify);
    p[1] = min(p[1], pLeft[1] + pRight.minElement + modify);
    p[1] = min(p[1], pLeft.minElement + pRight[1] + modify);
    p[1] = min(p[1], pLeft[2] + pRight[3] + modify);
    p[1] = min(p[1], pLeft[3] + pRight[2] + modify);
    p[2] = min(p[2], pLeft[0] + pRight[2] + modify);
    p[2] = min(p[2], pLeft[2] + pRight[0] + modify);
    p[2] = min(p[2], pLeft[2] + pRight[2] + modify);
    p[3] = min(p[3], pLeft[0] + pRight[3] + modify);
    p[3] = min(p[3], pLeft[3] + pRight[0] + modify);
    p[3] = min(p[3], pLeft[3] + pRight[3] + modify);
}

void and(int left, int right, int modify, int[] p, int[] pLeft, int[] pRight, ref string s)
{
    p[0] = min(p[0], pLeft[0] + pRight.minElement + modify);
    p[0] = min(p[0], pLeft.minElement + pRight[0] + modify);
    p[0] = min(p[0], pLeft[2] + pRight[3] + modify);
    p[0] = min(p[0], pLeft[3] + pRight[2] + modify);
    p[1] = min(p[1], pLeft[1] + pRight[1] + modify);
    p[2] = min(p[2], pLeft[2] + pRight[2] + modify);
    p[2] = min(p[2], pLeft[2] + pRight[1] + modify);
    p[2] = min(p[2], pLeft[1] + pRight[2] + modify);
    p[3] = min(p[3], pLeft[3] + pRight[1] + modify);
    p[3] = min(p[3], pLeft[1] + pRight[3] + modify);
    p[3] = min(p[3], pLeft[3] + pRight[3] + modify);
}

void xor(int left, int right, int modify, int[] p, int[] pLeft, int[] pRight, ref string s)
{
    foreach (i; 0 .. 4) p[0] = min(p[0], pLeft[i] + pRight[i] + modify);
    p[1] = min(p[1], pLeft[0] + pRight[1] + modify);
    p[1] = min(p[1], pLeft[1] + pRight[0] + modify);
    p[1] = min(p[1], pLeft[2] + pRight[3] + modify);
    p[1] = min(p[1], pLeft[3] + pRight[2] + modify);
    p[2] = min(p[2], pLeft[0] + pRight[2] + modify);
    p[2] = min(p[2], pLeft[2] + pRight[0] + modify);
    p[2] = min(p[2], pLeft[1] + pRight[3] + modify);
    p[2] = min(p[2], pLeft[3] + pRight[1] + modify);
    p[3] = min(p[3], pLeft[0] + pRight[3] + modify);
    p[3] = min(p[3], pLeft[3] + pRight[0] + modify);
    p[3] = min(p[3], pLeft[1] + pRight[2] + modify);
    p[3] = min(p[3], pLeft[2] + pRight[1] + modify);
}

void recur(int left, int right, int[][][] dp, ref string s)
{
    if (left > right) return;
    if (dp[left][right][0] != -1) return;
    foreach (i; 0 .. 4) dp[left][right][i] = 1 << 20;
    if ((right - left) % 4 != 0) return;
    if (left == right)
    {
        if (s[left] == 'x' || s[left] == 'X')
        {
            dp[left][right][0] = dp[left][right][1] = 1;
            dp[left][right][2] = 0;
            dp[left][right][3] = 1;
            if (s[left] == 'X')
            {
                dp[left][right][2] ^= 1;
                dp[left][right][3] ^= 1;
            }
        }
        else if (s[left] == '0' || s[left] == '1')
        {
            dp[left][right][0] = dp[left][right][1] = 0;
            if (s[left] == '0') dp[left][right][1] = 1;
            else dp[left][right][0] = 1;
            dp[left][right][2] = dp[left][right][3] = 1;
        }
        else
        {
            foreach (i; 0 .. 4) dp[left][right][i] = 1;
        }
        return;
    }
    auto add = 0;
    if (s[left] != '(') ++ add;
    if (s[right] != ')') ++ add;
    int[] p = dp[left][right];
    for (int i = left + 2; i < right - 1; i += 4)
    {
        recur(left + 1, i - 1, dp, s);
        recur(i + 1, right - 1, dp, s);
        int[] pLeft = dp[left + 1][i - 1];
        int[] pRight = dp[i + 1][right - 1];
        or(left, right, s[i] != '|' ? 1 : 0, p, pLeft, pRight, s);
        and(left, right, s[i] != '&' ? 1 : 0, p, pLeft, pRight, s);
        xor(left, right, s[i] != '^' ? 1 : 0, p, pLeft, pRight, s);
    }
    foreach (i; 0 .. 4) dp[left][right][i] += add;
}

int solve(ref string s)
{
    auto n = cast(int)s.length;
    auto dp = new int[][][](n, n, 4);
    foreach (i; 0 .. n) foreach (j; 0 .. n) fill(dp[i][j], -1);
    recur(0, n - 1, dp, s);
    return min(dp[0][n - 1][0], dp[0][n - 1][1]);
}

int main(string[] args)
{
    int T;
    readf("%d\n", &T);
    foreach (i; 1 .. T + 1)
    {
        auto s = readln.strip();
        auto ret = solve(s);
        writeln("Case #", i, ": ", ret);
    }
    return 0;
}
