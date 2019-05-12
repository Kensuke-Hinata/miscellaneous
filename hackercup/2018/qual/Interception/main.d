import std.stdio, std.string;

int main(string[] args)
{
    int T;
    readf("%d\n", &T);
    foreach (i; 1 .. T + 1)
    {
        int N, P;
        readf("%d\n", &N);
        foreach (j; 0 .. N + 1)
        {
            readf("%d\n", &P);
        }
        writef("Case #%d: ", i);
        if (N & 1)
        {
            writeln(1);
            writeln("0.0");
        }
        else
        {
            writeln(0);
        }
    }
    return 0;
}
