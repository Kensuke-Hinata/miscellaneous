#include <cstdio>
#include <cstring>
#include <vector>
#include <algorithm>

using namespace std;

struct SegmentTree
{
    struct Node
    {
        int leftIndex;
        int rightIndex;
        int optimal;
        int maximum;
        int minimum;
    };

    Node nodes[300000];

    SegmentTree(vector<int>& arr)
    {
        initializeTree(0, arr, 0, (int)arr.size() - 1);
    }

    void initializeTree(int index, vector<int>& arr, int leftIndex, int rightIndex)
    {
        if (leftIndex == rightIndex)
        {
            this->nodes[index].leftIndex = this->nodes[index].rightIndex = leftIndex;
            this->nodes[index].maximum = this->nodes[index].minimum = arr[leftIndex];
            this->nodes[index].optimal = -1;
            return;
        }
        auto mid = (leftIndex + rightIndex) >> 1;
        initializeTree((index << 1) + 1, arr, leftIndex, mid);
        initializeTree((index << 1) + 2, arr, mid + 1, rightIndex);
        this->nodes[index].leftIndex = leftIndex;
        this->nodes[index].rightIndex = rightIndex;
        this->nodes[index].maximum = max(this->nodes[(index << 1) + 1].maximum, this->nodes[(index << 1) + 2].maximum);
        this->nodes[index].minimum = min(this->nodes[(index << 1) + 1].minimum, this->nodes[(index << 1) + 2].minimum);
        this->nodes[index].optimal = -1;
    }

    pair<int, int> queryM(int left, int right)
    {
        return _queryM(0, left, right);
    }

    pair<int, int> _queryM(int index, int left, int right)
    {
        auto node = this->nodes[index];
        if (left <= node.leftIndex && right >= node.rightIndex)
        {
            return make_pair(node.maximum, node.minimum);
        }
        if (left > node.rightIndex || right < node.leftIndex)
        {
            return make_pair(-(1 << 30), 1 << 30);
        }
        auto leftM = _queryM((index << 1) + 1, left, right);
        auto rightM = _queryM((index << 1) + 2, left, right);
        return make_pair(max(leftM.first, rightM.first), min(leftM.second, rightM.second));
    }

    void _updateOpt(int index, int pos, int opt)
    {
        auto node = this->nodes[index];
        if (node.leftIndex > pos || node.rightIndex < pos)
        {
            return;
        }
        if (node.leftIndex == node.rightIndex)
        {
            this->nodes[index].optimal = opt;
            return;
        }
        _updateOpt((index << 1) + 1, pos, opt);
        _updateOpt((index << 1) + 2, pos, opt);
        if (this->nodes[index].optimal == -1)
        {
            this->nodes[index].optimal = opt;
        }
        else
        {
            this->nodes[index].optimal = min(this->nodes[index].optimal, opt);
        }
    }

    void updateOpt(int pos, int opt)
    {
        _updateOpt(0, pos, opt);
    }

    int _queryOpt(int index, int left, int right)
    {
        auto node = this->nodes[index];
        if (left <= node.leftIndex && right >= node.rightIndex)
        {
            return this->nodes[index].optimal;
        }
        if (left > node.rightIndex || right < node.leftIndex)
        {
            return -1;
        }
        auto leftOpt = _queryOpt((index << 1) + 1, left, right);
        auto rightOpt = _queryOpt((index << 1) + 2, left, right);
        auto res = 1 << 30;
        if (leftOpt != -1) res = min(res, leftOpt);
        if (rightOpt != -1) res = min(res, rightOpt);
        if (res == (1 << 30)) return -1;
        return res;
    }

    int queryOpt(int left, int right)
    {
        return _queryOpt(0, left, right);
    }
};

void solve(vector<int>& a, int n, int s, int l)
{
    auto st = SegmentTree(a);
    for (int i = n - 1; i >= 0; -- i)
    {
        auto left = i + l - 1, right = n - 1, pos = -1;
        auto minimum = -1, maximum = -1;
        if (left - 1 <= n - 1)
        {
            auto ret = st.queryM(i, left - 1);
            maximum = ret.first;
            minimum = ret.second;
        }
        while (left <= right)
        {
            auto mid = (left + right) >> 1;
            auto ret = st.queryM(left, mid);
            auto rmaximum = ret.first;
            auto rminimum = ret.second;
            rminimum = min(rminimum, minimum);
            rmaximum = max(rmaximum, maximum);
            if (rmaximum - rminimum > s)
            {
                right = mid - 1;
            }
            else
            {
                pos = mid;
                left = mid + 1;
                maximum = rmaximum;
                minimum = rminimum;
            }
        }
        auto opt = -1;
        if (pos != -1)
        {
            if (pos + 1 == n)
            {
                opt = 1;
            }
            else
            {
                auto ret = st.queryOpt(i + l, pos + 1);
                if (ret != -1)
                {
                    opt = ret + 1; 
                }
            }
            if (opt != -1)
            {
                st.updateOpt(i, opt);
            }
        }
        if (i == 0)
        {
            printf("%d\n", opt);
        }
    }
}

int main(int argc, char** argv)
{
    int n, s, l;
    while (scanf("%d %d %d", &n, &s, &l) == 3)
    {
        vector<int> a(n);
        for (int i = 0; i < n; ++ i)
        {
            scanf("%d", &a[i]);
        }
        solve(a, n, s, l);
    }
    return 0;
}
