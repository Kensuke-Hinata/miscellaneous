import std.stdio, std.string;
import std.conv, std.typecons;
import std.algorithm;

class Trie
{
    protected class Node
    {
        bool flag;
        Node[] children;
        int[int] position;
        this()
        {
            flag = false;
        }
    }

    protected Node root;
    protected Node prev;

    this()
    {
        root = new Node();
        prev = root;
    }

    protected Tuple!(bool, int[]) isValid(string str)
    {
        int[] pos;
        foreach (ch; str)
        {
            pos ~= ch - 'a';
        }
        return tuple(true, pos);
    }

    protected Tuple!(bool, Node) insert(char ch, Node node, bool flag)
    {
        auto p = ch - 'a';
        if (p !in node.position)
        {
            auto idx = cast(int)node.children.length;
            node.position[p] = idx;
            node.children ~= new Node();
            node = node.children[$ - 1];
        }
        else
        {
            node = node.children[node.position[p]];
        }
        node.flag = flag;
        return tuple(true, node);
    }

    bool normalInsert(char ch, bool flag)
    {
        auto ret = insert(ch, root, flag);
        return ret[0];
    }
    
    bool persistentInsert(char ch, bool flag)
    {
        auto ret = insert(ch, prev, flag);
        if (ret[0])
        {
            prev = ret[1];
        }
        return ret[0];
    }

    protected int _countFlag(Node node)
    {
        if (!node)
        {
            return 0;
        }
        auto res = 0;
        if (node.flag)
        {
            ++ res;
        }
        foreach (i; 0 .. node.children.length)
        {
            auto ret = _countFlag(node.children[i]);
            res += ret;
        }
        return res;
    }

    int countFlag()
    {
        return _countFlag(root);
    }

    void resetPrev()
    {
        prev = root;
    }
}

void solve(string t, string sb, string se)
{
    auto n = cast(int)t.length;
    auto bn = cast(int)sb.length;
    auto ff = new bool[n + 1];
    for (int i = 0; i < n && n - i >= bn; ++ i)
    {
        int j, k;
        for (j = i, k = 0; j < n && k < bn; ++ j, ++ k)
        {
            if (t[j] != sb[k])
            {
                break;
            }
        }
        ff[i] = k == bn ? true : false;
    }
    auto en = cast(int)se.length;
    auto bf = new bool[n + 1];
    for (int i = en - 1; i < n; ++ i)
    {
        int j, k;
        for (j = i, k = en - 1; j >= 0 && k >= 0; -- j, -- k)
        {
            if (t[j] != se[k])
            {
                break;
            }
        }
        bf[i] = k < 0 ? true : false;
    }
    auto trie = new Trie();
    foreach (i; 0 .. n)
    {
        trie.resetPrev();
        int bound;
        for (bound = n - 1; bound >= i; -- bound)
        {
            if (ff[i] && bf[bound] && bound - i + 1 >= bn && bound - i + 1 >= en)
            {
                break;
            }
        }
        foreach (j; i .. bound + 1)
        {
            if (ff[i] && bf[j] && j - i + 1 >= bn && j - i + 1 >= en)
            {
                trie.persistentInsert(t[j], true);
            }
            else
            {
                trie.persistentInsert(t[j], false);
            }
        }
    }
    auto ans = trie.countFlag();
    writeln(ans);
}

int main(string[] args)
{
    string t, sb, se;
    t = readln().strip();
    sb = readln().strip();
    se = readln().strip();
    solve(t, sb, se);
    return 0;
}
