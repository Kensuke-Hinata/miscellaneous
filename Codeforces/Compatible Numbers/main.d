import std.stdio, std.string;
import std.algorithm;

int countBits(T)(T num)
{
    auto left = 0, right = (cast(int)num.sizeof << 3) - 1;
    auto res = -1;
    while (left <= right)
    {
        auto mid = (left + right) >> 1;
        if (num >= (1 << mid))
        {
            res = mid;
            left = mid + 1;
        }
        else
        {
            right = mid - 1;
        }
    }
    return res + 1;
}

int flip(int num, int cnt)
{
    return num ^ ((1 << cnt) - 1);
}

void store(int mask, int val, int[] cand)
{
    if (cand[mask] != -1) return;
    cand[mask] = val;
    foreach (i; 0 .. 32)
    {
        if (mask < (1 << i)) return;
        if (mask & (1 << i))
        {
            store(mask ^ (1 << i), val, cand);
        }
    }
}

void solve(int[] a)
{
    auto m = reduce!(max)(a);
    auto cnt = countBits!int(m);
    auto cand = new int[1 << cnt];
    fill(cand, -1);
    foreach (v; a) store(flip(v, cnt), v, cand);
    foreach (v; a) writef("%d ", cand[v]);
    writeln();
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto a = new int[n];
        foreach (ref v; a) readf(" %d", &v);
        readln();
        solve(a);
    }
    return 0;
}
