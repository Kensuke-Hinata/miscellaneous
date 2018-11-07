import std.stdio, std.string, std.algorithm;
import std.conv;

int find(int tar, int[] arr)
{
    int left = 0, right = to!int(arr.length) - 1, ret = -1;
    while (left <= right)
    {
        int mid = (left + right) >> 1;
        if (arr[mid] == tar)
        {
            ret = mid;
            left = mid + 1;
        }
        else if (arr[mid] < tar)
        {
            left = mid + 1;
        }
        else
        {
            right = mid - 1;
        }
    }
    if (ret == -1) ret = left;
    return ret;
}

void solve(int[] a, int[] b)
{
    sort(a);
    sort(b);
    long ansa = a.length << 1, ansb = b.length << 1;
    long dist = ansa - ansb;
    foreach (i; 0 .. a.length)
    {
        if (i > 0 && a[i] == a[i - 1]) continue;
        auto pos = find(a[i] - 1, b);
        long scorea = i * 2 + (a.length - i) * 3;
        long scoreb;
        if (pos < b.length && b[pos] == a[i] - 1)
        {
            scoreb = (pos + 1) * 2 + (b.length - pos - 1) * 3;
        }
        else
        {
            scoreb = pos * 2 + (b.length - pos) * 3;
        }
        if (scorea - scoreb > dist || scorea - scoreb == dist && scorea > ansa)
        {
            dist = scorea - scoreb;
            ansa = scorea;
            ansb = scoreb;
        }
    }
    writefln("%d:%d", ansa, ansb);
}

void main(string[] args)
{
    int n, m;
    while (scanf("%d", &n) == 1)
    {
        auto a = new int[n];
        foreach (i; 0 .. n) scanf("%d", &a[i]);
        scanf("%d", &m);
        auto b = new int[m];
        foreach (i; 0 .. m) scanf("%d", &b[i]);
        solve(a, b);
    }
}
