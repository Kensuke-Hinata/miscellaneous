#include <iostream>
#include <string>

using namespace std;

typedef long long LL;

//int solve(int d, string p) {
    //auto n = (int)p.length();
    //auto pos = -1;
    //for (int i = 0; i < n; ++ i) {
        //if (p[i] == 'C') {
            //pos = i;
            //break;
        //}
    //}
    //if (pos == -1) {
        //if (n > d) {
            //return -1;
        //}
        //return 0;
    //}
    //for (int i = 0; i < n - pos; ++ i) {
        //if (pos + i + (n - pos - i - 1) * 2 <= d) {
            //return i;
        //} 
    //}
    //return -1;
//}

int solve(int d, string p) {
    LL sum = 0, m = 1;
    auto n = (int)p.length();
    auto res = 0;
    auto idx = n - 1;
    auto count = 0;
    auto cnt = new int[n];
    for (int i = 0; i < n; ++ i) {
        if (p[i] == 'S') {
            sum += m;
        } else {
            m <<= 1;
            cnt[i] = count;
            ++ count;
        }
    }
    while (sum > d && idx >= 0) {
        if (p[idx] == 'C') {
            -- idx;
            continue;
        }
        int pos;
        for (pos = idx - 1; pos >= 0 && p[pos] == 'S'; -- pos);
        if (pos == -1) {
            break;
        }
        for (int i = 0; i < idx - pos && sum > d; ++ i) {
            sum -= (1LL << cnt[pos]);
            ++ res;
        }
        p[pos] = 'S';
        -- idx;
    }
    delete[] cnt;
    if (sum > d) {
        return -1;
    }
    return res;
}

int main() {
    int T;
    cin >> T;
    for (int i = 1; i <= T; ++ i) {
        int D;
        string P;
        cin >> D >> P;
        auto res = solve(D, P);
        if (res != -1) {
            cout << "Case #" << i << ": " << res << endl; 
        } else {
            cout << "Case #" << i << ": IMPOSSIBLE" << endl; 
        }
    }
    return 0;
}
