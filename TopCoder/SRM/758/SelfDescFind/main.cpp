#include <bits/stdc++.h>

using namespace std;

#define SZ(v) ((int)v.size())

typedef long long LL;
typedef vector<int> vi;

class SelfDescFind {
    protected:
        bool zflag;

    public:
        LL recur(int mask, int n, vi& c, vi& cnt, vi& d, vector<LL>& dp) {
            LL& res = dp[mask];
            if (res != -1) return res;
            if (n < 0) {
                res = 0;
                return 0;
            }
            res = 1LL << 60;
            for (int i = 0; i < SZ(d); ++ i) {
                if (!(mask & (1 << i)) && cnt[d[i]] + 1 == c[n]) {
                    auto ret = recur(mask | (1 << i), n - 1, c, cnt, d, dp);
                    res = min(res, ret * 100 + c[n] * 10 + d[i]);
                }
            }
            return res;
        }

        void bf(int pidx, int bc, int bound, string& ans, vi& c, vi& cnt, vi& d, vector<LL>& dp) {
            if (SZ(c) == SZ(d)) {
                fill(cnt.begin(), cnt.end(), 0);
                for (int i = 0; i < SZ(c); ++ i) ++ cnt[c[i]];
                if (zflag) ++ cnt[1];
                fill(dp.begin(), dp.end(), -1);
                auto ret = recur(0, SZ(d) - 1, c, cnt, d, dp);
                if (ret == 1LL << 60) return;
                auto rs = ret == 0 ? "" : to_string(ret);
                if (zflag) rs = "10" + rs;
                if (ans == "" || (zflag && ans.substr(0, 2) == "10")) {
                    ans = rs;
                } else {
                    for (int i = 0; i < (SZ(d) << 1); ++ i) {
                        if (rs[i] < ans[i]) ans = rs;
                        if (rs[i] != ans[i]) break;
                    }
                }
                return;
            }
            for (int i = pidx; i < SZ(d) && bc + d[i] <= bound; ++ i) {
                c.push_back(d[i]);
                bf(i, bc + d[i], bound, ans, c, cnt, d, dp);
                c.pop_back();
            }
        }

        string construct(vi d) {
            if (d[0] == 0 && (SZ(d) == 1 || d[1] != 1)) return "";
            auto bc = 0, bound = SZ(d) << 1;
            string ans = "";
            zflag = d[0] == 0 ? true : false;
            if (d[0] == 0) {
                bc = 1;
                ans = "10";
                for (int i = 0; i < SZ(d) - 1; ++ i) d[i] = d[i + 1];
                d.pop_back();
            }
            vi c, cnt(10);
            vector<LL> dp(1 << SZ(d));
            bf(0, bc, bound, ans, c, cnt, d, dp);
            return zflag && ans == "10" ? "" : ans;
        }
};

int main(int argc, char** argv) {
    SelfDescFind obj;
    for (int i = 1; i < 1024; ++ i) {
        vi d;
        for (int j = 0; j < 10; ++ j) {
            if (i & (1 << j)) d.push_back(j);
        }
        auto ret = obj.construct(d);
        vi c(10);
        fill(c.begin(), c.end(), 0);
        for (int j = 0; j < ret.length(); ++ j) {
            ++ c[ret[j] - '0'];
        }
        for (int j = 0; j < ret.length(); j += 2) {
            assert(c[ret[j + 1] - '0'] == ret[j] - '0');
        }
    }
    return 0;
}
