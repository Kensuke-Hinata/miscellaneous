#include <iostream>
#include <string>

using namespace std;

string solve(int n, string& s) {
    string res = "";
    for (int i = 0; i < ((n - 1) << 1); ++ i) {
        if (s[i] == 'E') res += 'S';
        else res += 'E';
    }
    return res;
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 1; i <= T; ++ i) {
        int N;
        cin >> N;
        string s;
        cin >> s;
        auto ret = solve(N, s);
        cout << "Case #" << i << ": " << ret << endl;
    }
    return 0;
}
