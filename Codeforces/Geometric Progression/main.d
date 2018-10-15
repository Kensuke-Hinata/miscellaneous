import std.stdio, std.string;
import std.random;

class Treap(T)
{
    class Node
    {
        Node left;
        Node right;
        T val;
        int priority;
        int cnt;

        this()
        {
            left = right = null;
        }

        //int opCmp(Node node)
        //{
            //return this.priority - node.priority;
        //}

        int cmpPriority(int priority)
        {
            if (this.priority == priority) return 0;
            return this.priority < priority ? -1 : 1;
        }

        int cmpVal(T val)
        {
            if (this.val == val) return 0;
            return this.val < val ? -1 : 1;
        }
    }

    protected Node root;
    protected Xorshift rnd;

    public this()
    {
        root = null;
        rnd = Xorshift(1234567891);
    }

    protected void leftRotate(ref Node node)
    {
        if (!node.right) return;
        auto rightNode = node.right;
        if (rightNode)
        {
            node.right = rightNode.left;
            rightNode.left = node;
            node = rightNode;
        }
    }

    protected void rightRotate(ref Node node)
    {
        if (!node.left) return;
        auto leftNode = node.left;
        if (leftNode)
        {
            node.left = leftNode.right;
            leftNode.right = node;
            node = leftNode;
        }
    }

    protected Node find(T val)
    {
        return _find(root, val);
    }

    protected Node _find(Node node, T val)
    {
        if (!node) return null;
        auto ret = node.cmpVal(val);
        if (ret == 0) return node;
        if (ret == -1) return _find(node.right, val);
        return _find(node.left, val);
    }

    public void insert(T val)
    {
        _insert(root, val);
    }

    protected void _insert(ref Node node, T val)
    {
        if (!node)
        {
            node = new Node();
            node.val = val;
            node.priority = this.rnd.front;
            node.cnt = 1;
            this.rnd.seed(unpredictableSeed);
            return;
        }
        auto ret = node.cmpVal(val);
        if (ret == 0) 
        {
            ++ node.cnt;
            return;
        }
        if (ret == 1)
        {
            _insert(node.left, val);
            if (node.left.priority > node.priority)
            {
                rightRotate(node);
            }
        }
        else if (ret == -1)
        {
            _insert(node.right, val);
            if (node.right.priority > node.priority)
            {
                leftRotate(node);
            }
        }
    }

    public void remove(T val)
    {
        _remove(root, val);
    }

    protected void _remove(ref Node node, T val)
    {
        if (!node) return;
        auto ret = node.cmpVal(val);
        if (ret == 0)
        {
            if (!node.left && !node.right)
            {
                node = null;
                return;
            }
            if (!node.left)
            {
                node = node.right;
                return;
            }
            if (!node.right)
            {
                node = node.left;
                return;
            }
            if (node.left.cmpPriority(node.right.priority) == 1) 
            {
                rightRotate(node);
                _remove(node.right, val);
            }
            else
            {
                leftRotate(node);
                _remove(node.left, val);
            }
            return;
        }
        if (ret == -1)
        {
            _remove(node.right, val);
        }
        else
        {
            _remove(node.left, val);
        }
    }

    public void travel()
    {
        _travel(root);
    }

    protected void _travel(Node node)
    {
        if (!node) return;
        _travel(node.left);
        writeln(node.val);
        _travel(node.right);
    }

    public void clear()
    {
        while (root)
        {
            remove(root.val);
        }
    }

    public int getCount(T val)
    {
        auto node = find(val);
        if (!node) return 0;
        return node.cnt;
    }
}

void solve(int[] a, int n, int k)
{
    auto treap = new Treap!long();
    auto lcnt = new int[n];
    foreach (i; 0 .. n)
    {
        lcnt[i] = 0;
        if (a[i] % k == 0)
        {
            auto v = a[i] / k;
            lcnt[i] = treap.getCount(v);
        }
        treap.insert(cast(long)a[i]);
    }
    //treap.clear();
    treap = new Treap!long();
    auto rcnt = new int[n];
    for (int i = n - 1; i >= 0; -- i)
    {
        auto v = cast(long)a[i] * k;
        rcnt[i] = treap.getCount(v);
        treap.insert(a[i]);
    }
    long ans = 0;
    foreach (i; 0 .. n)
    {
        ans += cast(long)lcnt[i] * rcnt[i];
    }
    writeln(ans);
}

int main(string[] args)
{
    int n, k;
    while (readf("%d %d\n", &n, &k) == 2)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            readf(" %d", &a[i]);
        }
        readln();
        solve(a, n, k);
    }
    return 0;
}
