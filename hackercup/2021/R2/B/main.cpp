#include <bits/stdc++.h>

using namespace std;

#define SZ(v) ((int)(v).size())

typedef long long LL;
typedef vector<int> vi;

struct Node {
    Node* left;
    Node* right;
    int val;
    LL priority;
    int size;   // subtree size
    int distinct;   // subtree distinct size
    int count;  // count for the same value

    Node() {
        this->left = this->right = NULL;
        this->size = this->count = this->distinct = 1;
    }

    int cmp_priority(LL priority) {
        if (this->priority == priority) return 0;
        return this->priority < priority ? -1 : 1;
    }

    int cmp_val(int val) {
        if (this->val == val) return 0;
        return this->val < val ? -1 : 1;
    }
};

struct Treap {
    Node* root;
    int minimal;
    int maximal;
    int count;

    Treap() {
        this->root = NULL;
        this->minimal = INT32_MAX;
        this->maximal = INT32_MIN;
        this->count = 0;
    }

    void left_rotate(Node*& node) {
        if (!node) return;
        auto right_node = node->right;
        if (right_node) {
            node->size = node->count;
            node->distinct = 1;
            if (node->left) {
                node->size += node->left->size;
                node->distinct += node->left->distinct;
            }
            if (right_node->left) {
                node->size += right_node->left->size;
                node->distinct += right_node->left->distinct;
            }
            right_node->size = right_node->count + node->size;
            right_node->distinct = 1 + node->distinct;
            if (right_node->right) {
                right_node->size += right_node->right->size;
                right_node->distinct += right_node->right->distinct;
            }
            node->right = right_node->left;
            right_node->left = node;
            node = right_node;
        }
    }

    void right_rotate(Node*& node) {
        if (!node) return;
        auto left_node = node->left;
        if (left_node) {
            node->size = node->count;
            node->distinct = 1;
            if (node->right) {
                node->size += node->right->size;
                node->distinct += node->right->distinct;
            }
            if (left_node->right) {
                node->size += left_node->right->size;
                node->distinct += left_node->right->distinct;
            }
            left_node->size = left_node->count + node->size;
            left_node->distinct = 1 + node->distinct;
            if (left_node->left) {
                left_node->size += left_node->left->size;
                left_node->distinct += left_node->left->distinct;
            }
            node->left = left_node->right;
            left_node->right = node;
            node = left_node;
        }
    }

    Node* find(int val) {
        return _find(this->root, val);
    }

    Node* _find(Node* node, int val) {
        if (!node) return NULL;
        auto ret = node->cmp_val(val);
        if (ret == 0) return node;
        if (ret == -1) return _find(node->right, val);
        return _find(node->left, val);
    }

    void insert(int val, vi& c) {
        _insert(this->root, val, c);
    }

    int _insert(Node*& node, int val, vi& c) {
        if (!node) {
            node = new Node();
            node->val = val;
            node->priority = rand();
            if (c[val] > 1) ++ this->count;
            return 1;
        }
        auto ret = node->cmp_val(val);
        if (ret == 0) {
            ++ node->count;
            if (c[val] == node->count) -- this->count;
            ++ node->size;
            return 0;
        }
        int res;
        if (ret == 1) {
            res = _insert(node->left, val, c);
            if (node->left->priority > node->priority) {
                right_rotate(node);
            } else {
                ++ node->size;
                if (res == 1) ++ node->distinct;
            }
        } else {
            res = _insert(node->right, val, c);
            if (node->right->priority > node->priority) {
                left_rotate(node);
            } else {
                ++ node->size;
                if (res == 1) ++ node->distinct;
            }
        }
        return res;
    }

    int remove(int val) {
        return _remove(this->root, val);
    }

    int _remove(Node*& node, int val) {
        if (!node) return -1;
        auto ret = node->cmp_val(val);
        if (ret == -1) {
            auto res = _remove(node->right, val);
            if (res != -1) -- node->size;
            if (res == 1) -- node->distinct;
            return res;
        } else if (ret == 1) {
            auto res = _remove(node->left, val);
            if (res != -1) -- node->size;
            if (res == 1) -- node->distinct;
            return res;
        }
        if (node->count > 1) {
            -- node->count;
            -- node->size;
            return 0;
        }
        if (!node->left && !node->right) {
            delete node;
            node = NULL;
            return 1;
        }
        if (!node->left) {
            node = node->right;
            return 1;
        }
        if (!node->right) {
            node = node->left;
            return 1;
        }
        int res;
        if (node->left->cmp_priority(node->right->priority) == 1) {
            right_rotate(node);
            res = _remove(node->right, val);
        } else {
            left_rotate(node);
            res = _remove(node->left, val);
        }
        -- node->size;
        -- node->distinct;
        return 1;
    }

    int _query_rank(Node* node, int val) {
        if (!node) return 0;
        if (node->val >= val) return _query_rank(node->left, val);
        auto res = _query_rank(node->right, val);
        if (node->left) res += node->left->size;
        res += node->count;
        return res;
    }

    int query_rank(int val) {
        return _query_rank(this->root, val);
    }

    int _get_kth_element(Node* node, int k) {
        if (node->left && node->left->size >= k) return _get_kth_element(node->left, k);
        auto cnt = node->count;
        if (node->left) cnt += node->left->size;
        if (cnt >= k) return node->val;
        return _get_kth_element(node->right, k - cnt);
    }

    int get_kth_element(int k) {
        if (!this->root || k > this->root->size) return INT32_MAX;
        return _get_kth_element(this->root, k);
    }

    int _get_next(Node* node, int val) {
        if (!node) return INT32_MAX;
        if (node->val <= val) return _get_next(node->right, val);
        auto ret = _get_next(node->left, val);
        return min(ret, node->val);
    }

    int get_next(int val) {
        return _get_next(this->root, val);
    }

    int _get_prev(Node* node, int val) {
        if (!node) return INT32_MIN;
        if (node->val >= val) return _get_prev(node->left, val);
        auto ret = _get_prev(node->right, val);
        return max(ret, node->val);
    }

    int get_prev(int val) {
        return _get_prev(this->root, val);
    }

    int _count_less(Node* node, int val) {
        if (!node) return 0;
        if (node->val == val) {
            if (node->left) return node->left->size;
            return 0;
        }
        if (node->val < val) {
            auto res = _count_less(node->right, val);
            res += node->count;
            if (node->left) res += node->left->size;
            return res;
        }
        return _count_less(node->left, val);
    }

    int count_less(int val) {
        return _count_less(this->root, val);
    }

    int _count_greater(Node* node, int val) {
        if (!node) return 0;
        if (node->val == val) {
            if (node->right) return node->right->size;
            return 0;
        }
        if (node->val > val) {
            auto res = _count_greater(node->left, val);
            res += node->count;
            if (node->right) res += node->right->size;
            return res;
        }
        return _count_greater(node->right, val);
    }

    int count_greater(int val) {
        return _count_greater(this->root, val);
    }

    int _count_equal(Node* node, int val) {
        if (!node) return 0;
        if (node->val == val) return node->count;
        if (node->val > val) return _count_equal(node->left, val);
        return _count_equal(node->right, val);
    }

    int count_equal(int val) {
        return _count_equal(this->root, val);
    }

    int _get_minimal(Node* node) {
        if (!node) return this->minimal;
        if (!node->left) return node->val;
        return _get_minimal(node->left);
    }

    int get_minimal() {
        return _get_minimal(this->root);
    }

    int _get_maximal(Node* node) {
        if (!node) return this->maximal;
        if (!node->right) return node->val;
        return _get_maximal(node->right);
    }

    int get_maximal() {
        return _get_maximal(this->root);
    }

    void transfer(Treap& t, vi& c) {
        _transfer(this->root, t, c);
    }

    void _transfer(Node* node, Treap& t, vi& c) {
        if (!node) return;
        _transfer(node->left, t, c);
        _transfer(node->right, t, c);
        for (int i = 0; i < node->count; ++ i) t.insert(node->val, c);
        delete node;
    }

    void clear() {
        while (this->root) remove(this->root->val);
    }

    int size() {
        return (this->root == NULL) ? 0 : this->root->size;
    }

    int distinct() {
        return (this->root == NULL) ? 0 : this->root->distinct;
    }

    int count_invalid() {
        return this->count;
    }
};

Treap dfs(int node, int parent, vector<vi>& t, vi& f, vi& c, int& ans) {
    Treap res;
    res.insert(f[node], c);
    for (int i = 0; i < SZ(t[node]); ++ i) if (t[node][i] != parent) {
        auto ret = dfs(t[node][i], node, t, f, c, ans);
        if (ret.count_invalid() == 0) ++ ans;
        if (res.size() == 0) {
            res = ret;
        } else {
            if (res.size() > ret.size()) {
                ret.transfer(res, c);
            } else {
                res.transfer(ret, c);
                res = ret;
            }
        }
    }
    return res;
}

int solve(vector<vi>& t, vi& f) {
    auto n = SZ(f);
    vi c(n, 0);
    for (int i = 0; i < n; ++ i) ++ c[f[i]];
    auto ans = 0;
    auto ret = dfs(0, -1, t, f, c, ans);
    ret.clear();
    return ans;
}

int main(int argc, char** argv) {
    srand(0);
    int T;
    scanf("%d", &T);
    for (int i = 1; i <= T; ++ i) {
        int N, A, B;
        scanf("%d", &N);
        vector<vi> t(N);
        for (int j = 0; j < N - 1; ++ j) {
            scanf("%d %d", &A, &B);
            -- A, -- B;
            t[A].push_back(B);
            t[B].push_back(A);
        }
        vi f(N);
        for (int j = 0; j < N; ++ j) {
            scanf("%d", &f[j]);
            -- f[j];
        }
        auto ret = solve(t, f);
        printf("Case #%d: %d\n", i, ret);
    }
    return 0;
}
