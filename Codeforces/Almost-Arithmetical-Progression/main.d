import std.stdio, std.string;
import std.algorithm;

void solve(int[] b)
{
    auto m = reduce!(max)(b);
    auto pos = new int[m + 1];
    fill(pos, -1);
    int[][] arr;
    auto cnt = 0;
    foreach (int i, v; b)
    {
        if (pos[v] == -1)
        {
            pos[v] = cnt;
            ++ cnt;
            int[] a;
            arr ~= a;
        }
        arr[pos[v]] ~= i;
    }
    auto ans = 0;
    for (int i = 0; i < cnt; ++ i)
    {
        ans = max(ans, cast(int)arr[i].length);
        for (int j = i + 1; j < cnt; ++ j)
        {
            if (arr[i].length + arr[j].length <= ans)
            {
                continue;
            }
            auto pi = 0, pj = 0;
            auto count = 2;
            auto prev = arr[i][pi] < arr[j][pj] ? 0 : 1;
            while (pi < arr[i].length && pj < arr[j].length)
            {
                if (count + arr[i].length - pi + 1 + arr[j].length - pj + 1 <= ans)
                {
                    break;
                }
                if (prev == 0)
                {
                    ++ pi;
                    if (pi < arr[i].length && arr[i][pi] > arr[j][pj])
                    {
                        prev = 1;
                        ++ count;
                    }
                }
                else
                {
                    ++ pj;
                    if (pj < arr[j].length && arr[j][pj] > arr[i][pi])
                    {
                        prev = 0;
                        ++ count;
                    }
                }
            }
            ans = max(ans, count);
        }
    }
    writeln(ans);
}

int main(string[] args)
{
    int n;
    while (readf("%d\n", &n) == 1)
    {
        auto b = new int[n];
        foreach (ref v; b)
        {
            readf(" %d", &v);
        }
        readln();
        solve(b);
    }
    return 0;
}
