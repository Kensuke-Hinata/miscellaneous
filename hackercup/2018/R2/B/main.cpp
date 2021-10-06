#include <bits/stdc++.h>

using namespace std;

typedef long long LL;

class Node {
    public:
        int val;
        int dist;
        Node* parent;
        Node* left;
        Node* right;
        int size;

        Node(int val) {
            this->val = val;
            this->dist = 1;
            this->parent = this->left = this->right = NULL;
            this->size = 1;
        }
};

class LeftistTree {
    public:
        const int bound = 1 << 30;
        Node* root;

        LeftistTree() {
            this->root = NULL;
        }

        Node* _merge(Node* n0, Node* n1) {
            if (!n0) return n1;
            if (!n1) return n0;
            if (n0->val < n1->val) swap(n0, n1);
            auto ret = _merge(n0->right, n1);
            ret->parent = n0;
            n0->right = ret;
            n0->size = 1;
            if (n0->left) n0->size += n0->left->size;
            n0->size += n0->right->size;
            if (n0->left && n0->left->dist < n0->right->dist) swap(n0->left, n0->right);
            n0->dist = n0->right->dist + 1;
            if (!n0->left) {
                swap(n0->left, n0->right);
                n0->dist = 1;
            }
            return n0;
        }

        void merge(LeftistTree* lt) {
            if (!lt || !lt->root) return;
            this->root = _merge(this->root, lt->root);
            if (this->root) this->root->parent = NULL;
        }

        void insert(int val) {
            auto node = new Node(val);
            this->root = _merge(this->root, node);
        }

        int peek() {
            if (!this->root) return bound;
            return this->root->val;
        }

        int pop() {
            if (!this->root) return bound;
            auto res = this->root->val;
            if (this->root->left) this->root->left->parent = NULL;
            if (this->root->right) this->root->right->parent = NULL;
            this->root = _merge(this->root->left, this->root->right);
            if (this->root) this->root->parent = NULL;
            return res;
        }

        void pushup(Node* node) {
            if (!node) return;
            if (node->left->dist < node->right->dist) swap(node->left, node->right);
            if (node->dist != node->right->dist + 1) {
                node->dist = node->right->dist + 1;
                pushup(node->parent);
            }
        }

        void remove(Node* node) {
            if (!node) return;
            auto ret = _merge(node->left, node->right);
            if (node == this->root) {
                this->root = ret;
            } else {
                if (node->parent->left == node) node->parent->left = ret;
                else node->parent->right = ret;
            }
            if (ret) {
                ret->parent = node->parent;
                pushup(ret->parent);
            }
        }

        bool empty() {
            return this->root == NULL;
        }

        int size() {
            return (this->root == NULL) ? 0 : this->root->size;
        }
};

LeftistTree* dfs(int node, vector<vector<int>>& t, vector<int>& cnt, LL& res, int d) {
    auto lt = new LeftistTree();
    lt->insert(node);
    for (int i = 0; i < t[node].size(); ++ i) {
        auto ret = dfs(t[node][i], t, cnt, res, d + 1);
        if (ret->size() > 0) lt->merge(ret);
    }
    for (int i = 0; i < cnt[node]; ++ i) {
        if (lt->empty()) break;
        auto ret = lt->pop();
        res += ret;
    }
    return lt;
}

LL solve(int n, int m, vector<int>& p, vector<int>& c) {
    vector<vector<int>> t(n);
    for (int i = 0; i < p.size(); ++ i) t[p[i]].push_back(i + 1);
    vector<int> cnt(n);
    for (int i = 0; i < c.size(); ++ i) ++ cnt[c[i]];
    LL res = 0;
    dfs(0, t, cnt, res, 0);
    return res;
}

int main(int argc, char** argv) {
    int T;
    scanf("%d", &T);
    for (int i = 1; i <= T; ++ i) {
        int N, M, A, B;
        scanf("%d %d %d %d", &N, &M, &A, &B);
        vector<int> P(N - 1);
        for (int j = 0; j < N - 1; ++ j) scanf("%d", &P[j]);
        vector<int> C(M);
        for (int j = 0; j < M; ++ j) C[j] = ((LL)A * j + B) % N;
        auto ret = solve(N, M, P, C);
        printf("Case #%d: %lld\n", i, ret);
    }
    return 0;
}
