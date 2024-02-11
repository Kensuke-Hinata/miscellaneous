import std.stdio, std.string;
import std.array, std.range;
import std.math, std.algorithm;
import std.typecons, std.conv;
import std.random;

string solve(string s, int k)
{
    auto n = s.length.to!int;
    foreach (i; 0 .. n - k + 1)
    {
        if (i > 0 && s[i - 1] == 'N') continue;
        if (i + k < n && s[i + k] == 'N') continue;
        int j;
        for (j = i; j < i + k; ++ j) if (s[j] == 'Y') break;
        if (j < i + k) continue;
        int c;
        for (j = 0; j < i && c <= k; ++ j)
        {
            if (s[j] == 'Y' || s[j] == '?') c = 0;
            else ++ c;
        }
        if (c > k) continue;
        c = 0;
        for (j = i + k; j < n && c <= k; ++ j)
        {
            if (s[j] == 'Y' || s[j] == '?') c = 0;
            else ++ c;
        }
        if (c <= k) return "YES";
    }
    return "NO";
}

int main(string[] args)
{
    auto r = map!(to!int)(readln.strip.split(" ")).array;
    auto k = r[1];
    auto s = readln.strip;
    auto ret = solve(s, k);
    writeln(ret);
    return 0;
}
