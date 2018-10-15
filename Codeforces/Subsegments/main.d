import std.stdio, std.string;
import std.container.rbtree;
import std.random;

class Treap(T)
{
    class Node
    {
        Node left;
        Node right;
        T val;
        int priority;

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
    protected int size;
    protected T minimal;
    protected T maximal;

    this()
    {
        root = null;
        rnd = Xorshift(1234567891);
        size = 0;
        minimal = T.max;
        maximal = T.min;
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
            this.rnd.seed(unpredictableSeed);
            ++ size;
            return;
        }
        auto ret = node.cmpVal(val);
        if (ret == 0) return;
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
                -- size;
                return;
            }
            if (!node.left)
            {
                node = node.right;
                -- size;
                return;
            }
            if (!node.right)
            {
                node = node.left;
                -- size;
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

    protected T _getMinimal(Node node)
    {
        if (!node) return minimal; 
        if (!node.left) return node.val;
        return _getMinimal(node.left);
    }

    public T getMinimal()
    {
        return _getMinimal(root);
    }

    protected T _getMaximal(Node node)
    {
        if (!node) return maximal;
        if (!node.right) return node.val;
        return _getMaximal(node.right);
    }

    public T getMaximal()
    {
        return _getMaximal(root);
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
        writeln(node.priority);
        _travel(node.right);
    }

    public void clear()
    {
        while (root)
        {
            remove(root.val);
        }
    }
}

void solve(int[] a, int k)
{
    auto n = cast(int)a.length;
    auto treap = new Treap!int();
    int[int] cnt;
    foreach (i; 0 .. n)
    {
        if (i >= k && a[i - k] != a[i])
        {
            -- cnt[a[i - k]];
            if (cnt[a[i - k]] == 1)
            {
                treap.insert(a[i - k]);
            }
            else
            {
                treap.remove(a[i - k]);
            }
        }
        if (i < k || a[i - k] != a[i])
        {
            if (!(a[i] in cnt)) 
            {
                cnt[a[i]] = 0;
            }
            ++ cnt[a[i]];
            if (cnt[a[i]] == 1)
            {
                treap.insert(a[i]);
            }
            else
            {
                treap.remove(a[i]);
            }
        }
        if (i >= k - 1)
        {
            if (treap.size > 0)
            {
                writeln(treap.getMaximal());
            }
            else
            {
                writeln("Nothing");
            }
        }
    }
}

/*void solve(int[] a, int k)*/
//{
    //auto n = cast(int)a.length;
    //auto rbt = redBlackTree!int();
    //int[int] cnt;
    //foreach (i; 0 .. n)
    //{
        //if (i >= k && a[i - k] != a[i])
        //{
            //-- cnt[a[i - k]];
            //if (cnt[a[i - k]] == 1)
            //{
                //rbt.insert(a[i - k]);
            //}
            //else
            //{
                //rbt.removeKey(a[i - k]);
            //}
        //}
        //if (i < k || a[i - k] != a[i])
        //{
            //if (!(a[i] in cnt)) 
            //{
                //cnt[a[i]] = 0;
            //}
            //++ cnt[a[i]];
            //if (cnt[a[i]] == 1)
            //{
                //rbt.insert(a[i]);
            //}
            //else
            //{
                //rbt.removeKey(a[i]);
            //}
        //}
        //if (i >= k - 1)
        //{
            //if (rbt.length > 0)
            //{
                //writeln(rbt.back());
            //}
            //else
            //{
                //writeln("Nothing");
            //}
        //}
    //}
/*}*/

int main(string[] args)
{
    int n, k;
    while (readf("%d %d\n", &n, &k) == 2)
    {
        auto a = new int[n];
        foreach (i; 0 .. n)
        {
            readf("%d\n", &a[i]);
        }
        solve(a, k);
    }
    return 0;
}
