#include <iostream>
#include <string>
#include <algorithm>

using namespace std;

pair<string, string> solve(string& s) {
    auto n = s.length();
    string first, second;
    int i;
    for (i = n - 1; i >= 0; -- i) {
        if (s[i] == '0') {
            first += '0';
            second += '0';
        } else if (s[i] == '5') {
            first += '2';
            second += '3';
        } else {
            first += '1';
            second += '0' + (s[i] - '0' - 1);
        } 
    }
    reverse(first.begin(), first.end());
    reverse(second.begin(), second.end());
    for (i = 0; i < first.length() && first[i] == '0'; ++ i) {}
    first = first.substr(i, first.length() - i);
    for (i = 0; i < second.length() && second[i] == '0'; ++ i) {}
    second = second.substr(i, second.length() - i);
    return make_pair(first, second);
}

int main(int argc, char** argv) {
    int T;
    cin >> T;
    for (int i = 1; i <= T; ++ i) {
        string s;
        cin >> s;
        auto ret = solve(s);
        cout << "Case #" << i << ": " << ret.first << " " << ret.second << endl;
    }
    return 0;
}
