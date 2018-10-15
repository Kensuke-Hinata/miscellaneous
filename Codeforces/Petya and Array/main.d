import std.stdio, std.string;
import std.algorithm;

int search(long[] arr, int n, long t)
{
    auto left = 0, right = n - 1;
    auto res = -1;
    while (left <= right)
    {
        auto mid = (left + right) >> 1;
        if (arr[mid] >= t)
        {
            right = mid - 1;
        }
        else
        {
            left = mid + 1;
            res = mid;
        }
    }
    return res + 1;
}

long count(int[] a, int left, int right, long t)
{
    if (left == right)
    {
        if (a[left] < t) return 1;
        return 0;
    }
    long res = 0;
    auto mid = (left + right) >> 1;
    res += count(a, left, mid, t);
    res += count(a, mid + 1, right, t);
    auto arr = new long[mid - left + 1];
    long sum = 0;
    for (int i = mid; i >= left; -- i)
    {
        sum += a[i];
        arr[mid - i] = sum;
    }
    arr.sort;
    sum = 0;
    for (int i = mid + 1; i <= right; ++ i)
    {
        sum += a[i];
        auto ret = search(arr, mid - left + 1, t - sum);
        res += ret;
    }
    return res;
}

void solve(int[] a, int n, long t)
{
    auto ans = count(a, 0, n - 1, t);
    writeln(ans);
}

int main(string[] args)
{
    int n;
    long t;
    while (readf("%d %d\n", &n, &t) == 2)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &a[i]);
        }
        readln;
        solve(a, n, t);
    }
    return 0;
}
