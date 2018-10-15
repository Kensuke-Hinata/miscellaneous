import std.stdio, std.string;
import std.algorithm;

void solve(string a, int n, string b, int m)
{
    const static int mod = 998244353;
    auto v = new int[n];
    v[n - 1] = 1;
    for (int i = n - 2; i >= 0; -- i)
    {
        v[i] = v[i + 1] << 1;
        v[i] %= mod;
    }
    auto c = new int[max(n, m)];
    fill(c, 0);
    auto start = n > m ? n - m : 0;
    foreach (i; start .. max(n, m))
    {
        c[i] = b[i - start] == '1' ? 1 : 0;
        if (i > start) c[i] += c[i - 1];
    }
    auto ans = 0;
    auto shift = n > m ? 0 : m - n; 
    start = n > m ? n - m : 0;
    foreach (i; start .. n)
    {
        if (a[i] == '1')
        {
            ans += (cast(long)c[i + shift] * v[i]) % mod;
            ans %= mod;
        }
    }
    writeln(ans);
}

int main(string[] args)
{
    int n, m;
    while (readf("%d %d\n", &n, &m) == 2)
    {
        auto a = readln.strip;
        auto b = readln.strip;
        solve(a, n, b, m);
    }
    return 0;
}
