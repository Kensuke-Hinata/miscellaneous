import std.stdio, std.string;
import std.conv, std.algorithm;

class DisjointSet
{
    protected int[] parent;
    protected int[] height;

    this(int n)
    {
        this.parent = new int[n];
        this.height = new int[n];
        foreach (i; 0 .. n)
        {
            this.parent[i] = i;
            this.height[i] = 1;
        }
    }

    int find(int n)
    {
        if (this.parent[n] == n) return n;
        this.parent[n] = find(this.parent[n]);
        return this.parent[n];
    }

    int join(int n, int m)
    {
        int pn = find(n), pm = find(m);
        if (this.height[pn] > this.height[pm]) swap(pn, pm);
        this.parent[pn] = pm;
        if (this.height[pn] == this.height[pm]) ++ this.height[pm];
        return pm;
    }
}

int main(string[] args)
{
    return 0;
}
