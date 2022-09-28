#include <bits/stdc++.h>

using namespace std;

typedef vector<int> vi;

struct Node {
    Node* lnode;
    Node* rnode;
    int left;
    int right;
    vi v;
};

struct SegmentTree {
    Node* root;

    void init(vi& a) {
        root = build(a, 0, a.size() - 1);
    }

    Node* build(vi& a, int left, int right) {
        auto node = new Node;
        node->left = left;
        node->right = right;
        if (left == right) {
            node->lnode = node->rnode = NULL;
            node->v.push_back(a[left]);
            return node;
        }
        auto mid = (left + right) >> 1;
        node->lnode = build(a, left, mid);
        node->rnode = build(a, mid + 1, right);
        auto lidx = 0, ridx = 0;
        vi& lv = node->lnode->v;
        vi& rv = node->rnode->v;
        while (lidx < lv.size() && ridx < rv.size()) {
            if (lv[lidx] < rv[ridx]) {
                node->v.push_back(lv[lidx]);
                ++ lidx;
            } else {
                node->v.push_back(rv[ridx]);
                ++ ridx;
            }
        }
        while (lidx < lv.size()) {
            node->v.push_back(lv[lidx]);
            ++ lidx;
        }
        while (ridx < rv.size()) {
            node->v.push_back(rv[ridx]);
            ++ ridx;
        }
        return node;
    }

    void _query(Node* node, int left, int right, int k, vi& res) {
        if (node->left > right || node->right < left) return;
        if (node->left >= left && node->right <= right) {
            auto n = (int)node->v.size();
            for (int i = 0; i < k && i < n; ++ i) res.push_back(node->v[n - i - 1]);
            return;
        }
        _query(node->lnode, left, right, k, res);
        _query(node->rnode, left, right, k, res);
    }

    bool query(int left, int right, int k, int x) {
        vi res;
        _query(root, left, right, k, res);
        sort(res.begin(), res.end());
        auto n = (int)res.size();
        auto s = 0;
        for (int i = 0; i < k && i < n; ++ i) s += res[n - i - 1];
        return s >= x;
    }

    void _clear(Node* node) {
        if (!node) return;
        _clear(node->lnode);
        _clear(node->rnode);
        delete node;
    }

    void clear() {
        _clear(root);
    }
};

int main(int argc, char** argv) {
    int n, q, k, x;
    while (cin >> n >> q >> k >> x) {
        vi a(n);
        for (int i = 0; i < n; ++ i) scanf("%d", &a[i]);
        SegmentTree st;
        st.init(a);
        for (int i = 0; i < q; ++ i) {
            int left, right;
            scanf("%d %d", &left, &right);
            -- left, -- right;
            auto ret = st.query(left, right, k, x);
            if (ret) cout << "Y" << endl;
            else cout << "N" << endl;
        }
        st.clear();
    }
    return 0;
}
