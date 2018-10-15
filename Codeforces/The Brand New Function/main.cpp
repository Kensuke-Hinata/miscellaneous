#include <cstdio>
#include <cstring>
#include <vector>
#include <algorithm>
#include <set>

using namespace std;

struct SegmentTree
{
    struct Node
    {
        int leftIndex;
        int rightIndex;
        int sum;
    };

    int bound;
    Node nodes[280000];

    SegmentTree(vector<int>& arr, int m)
    {
        this->initializeTree(0, arr, 0, (int)arr.size() - 1);
        this->bound = m;
    }

    void initializeTree(int index, vector<int>& arr, int leftIndex, int rightIndex)
    {
        if (leftIndex == rightIndex)
        {
            this->nodes[index].sum = arr[leftIndex];
            this->nodes[index].leftIndex = this->nodes[index].rightIndex = leftIndex;
            return;
        }
        auto mid = (leftIndex + rightIndex) >> 1;
        initializeTree((index << 1) + 1, arr, leftIndex, mid);
        initializeTree((index << 1) + 2, arr, mid + 1, rightIndex);
        this->nodes[index].sum = this->nodes[(index << 1) + 1].sum | this->nodes[(index << 1) + 2].sum;
        this->nodes[index].leftIndex = leftIndex;
        this->nodes[index].rightIndex = rightIndex;
    }

    int querySum(int left, int right, int mask, int flag)
    {
        return _querySum(0, left, right, mask, flag);
    }

    int _querySum(int index, int left, int right, int mask, int flag)
    {
        auto node = this->nodes[index];
        if (left <= node.leftIndex && right >= node.rightIndex)
        {
            return node.sum;
        }
        if (left > node.rightIndex || right < node.leftIndex)
        {
            return 0;
        }
        auto leftSum = _querySum((index << 1) + 1, left, right, mask, flag);
        if (flag == 1 && (mask | leftSum) > mask)
        {
            return leftSum;
        }
        if (leftSum == bound - 1)
        {
            return bound - 1;
        }
        auto rightSum = _querySum((index << 1) + 2, left, right, mask, flag);
        return leftSum | rightSum;
    }
};

void solve(vector<int>& a, int n)
{
    auto m = 0;
    for (int i = 0; i < n; ++ i)
    {
        m = max(m, a[i]);
    }
    for (int b = 0; b < 21; ++ b)
    {
        if (m < (1 << b))
        {
            m = 1 << b;
            break;
        }
    }
    vector<bool> f(m);
    fill(f.begin(), f.end(), false);
    auto cnt = 0;
    vector<int> arr;
    for (int i = 0; i < n; ++ i)
    {
        if (a[i] == 0)
        {
            if (!f[0])
            {
                f[0] = true;
                ++ cnt;
            }
        }
        else
        {
            arr.push_back(a[i]);
        }
    }
    if (arr.size() == 0)
    {
        printf("1\n");
        return;
    }
    vector<int> t;
    t.push_back(arr[0]);
    for (int i = 1; i < (int)arr.size(); ++ i)
    {
        if (arr[i] != arr[i - 1])
        {
            t.push_back(arr[i]);
        }
    }
    a = t;
    n = (int)a.size();
    vector<int> bs(n);
    bs[n - 1] = a[n - 1];
    for (int i = n - 2; i >= 0; -- i)
    {
        bs[i] = bs[i + 1] | a[i];
    }
    vector<int> fs(n);
    fs[0] = a[0];
    for (int i = 1; i < n; ++ i)
    {
        fs[i] = fs[i - 1] | a[i];
    }
    auto st = SegmentTree(a, m);
    vector<set<int> > h(n);
    auto cache_size = 0;
    for (int i = 0; i < n; ++ i)
    {
        int bound = i, mask = 0;
        while (bound < n)
        {
            if (h[bound].find(mask) != h[bound].end()) break;
            if (cache_size < 5000000)
            {
                ++ cache_size;
                h[bound].insert(mask);
            }
            int pos = -1, left = bound, right = n - 1;
            while (left <= right)
            {
                auto mid = (left + right) >> 1;
                auto v = mask;
                for (int j = mid; j >= 0 && j >= mid - 1; -- j)
                {
                    v |= a[mid];
                    if (v > mask) break;
                }
                if (v > mask)
                {
                    right = mid - 1;
                    pos = mid;
                    continue;
                }
                if ((mask | fs[mid]) == mask)
                {
                    left = mid + 1;
                    continue;
                }
                auto ret = st.querySum(bound, mid, mask, 1);
                if ((mask | ret) > mask)
                {
                    right = mid - 1;
                    pos = mid;
                }
                else
                {
                    left = mid + 1;
                }
            }
            if (pos == -1) break;
            auto ret = st.querySum(i, pos, mask, 0);
            mask |= ret;
            if (!f[mask])
            {
                f[mask] = true;
                ++ cnt;
                if (cnt == m)
                {
                    printf("%d\n", cnt);
                    return;
                }
            }
            if (mask + 1 == m) break;
            bound = pos + 1;
            if (bound < n && (mask | bs[bound]) == mask) break;
        }
    }
    printf("%d\n", cnt);
}

int main(int argc, char** argv)
{
    int n;
    while (scanf("%d", &n) == 1)
    {
        vector<int> a(n);
        for (int i = 0; i < n; ++ i)
        {
            scanf("%d", &a[i]);
        }
        solve(a, n);
    }
    return 0;
}
