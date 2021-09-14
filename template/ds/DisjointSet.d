import std.stdio, std.string;
import std.conv, std.algorithm;

class DisjointSet
{
    protected int[] parent;
    protected int[] height;

    this(int n)
    {
        parent = new int[n];
        height = new int[n];
        foreach (i; 0 .. n)
        {
            parent[i] = i;
            height[i] = 1;
        }
    }

    int find(int n)
    {
        if (parent[n] == n) return n;
        parent[n] = find(parent[n]);
        return parent[n];
    }

    void join(int n, int m)
    {
        int pn = find(n), pm = find(m);
        if (height[pn] > height[pm]) swap(pn, pm);
        parent[pn] = pm;
        if (height[pn] == height[pm]) ++ height[pm];
    }
}

int main(string[] args)
{
    return 0;
}
