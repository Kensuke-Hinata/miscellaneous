#include <bits/stdc++.h>

using namespace std;

#define LEN(s) ((int)(s).length())
#define SZ(v) ((int)(v).size())
#define INF32 (1 << 30)
#define INF64 (1LL << 60)
#define PB push_back
#define MP make_pair
#define CLR(v) ((v).clear())
#define ALL(v) (v).begin(), (v).end()
#define ZERO(v) memset(v, 0, sizeof(v))
#define REP(i, n) for (int i = 0; i < n; ++ i)

typedef long long ll;
typedef pair<int, int> pii;
typedef vector<int> vi;
typedef vector<ll> vll;


//template <class T>
void transform_str(vector<string>& res, const string& s, const char split) {
    istringstream istr(s);
    string v;
    while (getline(istr, v, split)) {
        res.PB(v);
    }
}


#define MAIN
#ifdef MAIN
int main() {
    //string s = "1 234";
    string s = "1 234,456";
    //vi arr;
    vector<string> arr;
    //transform_str(arr, s, ' ');
    transform_str(arr, s, ',');
    for (int i = 0; i < SZ(arr); ++ i) {
        cout << arr[i] << endl;
    }
    return 0;
}
#endif  
