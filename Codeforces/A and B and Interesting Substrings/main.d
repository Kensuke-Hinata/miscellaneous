import std.stdio, std.string;

void solve(int[] x, string s)
{
    auto n = cast(int)s.length;
    auto c = new int[long][26];
    long sum = 0, ans = 0;
    foreach (i; 0 .. n)
    {
        auto p = s[i] - 'a';
        if (sum in c[p])
        {
            ans += c[p][sum];
        }
        sum += x[p];
        if (sum !in c[p])
        {
            c[p][sum] = 0;
        }
        ++ c[p][sum];
    }
    writeln(ans);
}

int main(string[] args)
{
    auto x = new int[26];
    foreach (i; 0 .. 26)
    {
        readf(" %d", &x[i]);
    }
    readln;
    auto s = readln().strip();
    solve(x, s);
    return 0;
}
