import std.stdio, std.string;

void solve(int[] arr)
{
    bool[] flag = new bool[arr.length + 10];
    foreach (i, ref val; arr)
    {
        flag[val] = true;
    }
    foreach (i, ref val; flag)
    {
        if (i > 0 && val == false)
        {
            writeln(i);
            return;
        }
    }
}

void main(string[] args)
{
    int n;
    while (scanf("%d", &n) == 1)
    {
        int[] arr = new int[n - 1];
        foreach (int i; 0 .. n - 1)
        {
            scanf("%d", &arr[i]);
        }
        solve(arr);
    }
}
