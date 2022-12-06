#include <bits/stdc++.h>

using namespace std;


int main(void) {

	vector<string> vs;

	string tmp;
	while(getline(cin, tmp)) {
		if(tmp[1] == '1')
			break;
		vs.push_back(tmp);
	}

	vector<stack<char>> s(((tmp.size() + 1) / 4));

	for(size_t si = 0; si < s.size(); si++) {
		for(size_t i = vs.size(); i-- > 0;) {
			if(vs[i][1 + 4 * si] == ' ')
				continue;
			s[si].push(vs[i][1 + 4 * si]);
		}
	}

	while(cin >> tmp) {
		int menge, from, to;
		cin >> menge >> tmp >> from >> tmp >> to;
		from--;
		to--;
		stack<char> what;
		for(size_t i = 0; i < menge; i++){
			what.push(s[from].top());
			s[from].pop();
		}
		for(size_t i = 0; i < menge; i++){
			s[to].push(what.top());
			what.pop();
		}
	}

	for(size_t si = 0; si < s.size(); si++) {
		if(s[si].size())
			cout << s[si].top();
		else
			cout << ' ';
	}
	cout << endl;

}
