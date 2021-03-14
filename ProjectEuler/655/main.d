import std.stdio, std.string;
import std.algorithm;

void solve()
{
    immutable int n = 32;
    immutable int m = 10000019;
    auto rem = new int[][](10, n + 1);
    foreach (i; 0 .. 10)
    {
        rem[i][1] = i;
        foreach (j; 2 .. n + 1) rem[i][j] = (rem[i][j - 1] * 10) % m;
    }
    auto pdp = new long[m];
    auto ndp = new long[m];
    long ans = 0;
    foreach (len; 1 .. n + 1)
    {
        fill(pdp, 0);
        pdp[0] = 1;
        auto bound = (len >> 1) + (len & 1);
        foreach (i; 0 .. bound)
        {
            fill(ndp, 0);
            auto start = (i == 0 ? 1 : 0);
            foreach (j; start .. 10) foreach (k; 0 .. m)
            {
                auto shift = 0;
                if ((len & 1) && i == len >> 1) shift = rem[j][len - i];
                else shift = rem[j][len - i] + rem[j][i + 1]; 
                ndp[(k + shift) % m] += pdp[k];
            }
            ndp.copy(pdp);
        }
        ans += pdp[0];
    }
    writeln(ans);
}

int main(string[] args)
{
    solve;
    return 0;
}
