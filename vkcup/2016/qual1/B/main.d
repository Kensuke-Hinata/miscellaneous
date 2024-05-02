import std.stdio, std.string;
import std.array, std.range;
import std.math, std.algorithm;
import std.typecons, std.conv;
import std.random;

int main(string[] args)
{
    auto n = readln.strip.to!int;
    int[string] h;
    auto idx = -1;
    foreach (_; 0 .. n)
    {
        auto s = readln.strip;
        h[s] = idx;
        -- idx;
    }
    Tuple!(int, string)[] t;
    foreach (s, i; h) t ~= tuple(i, s);
    t.sort;
    foreach (item; t) writeln(item[1]);
    return 0;
}
