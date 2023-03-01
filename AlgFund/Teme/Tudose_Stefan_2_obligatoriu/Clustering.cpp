#include <bits/stdc++.h>

using namespace std;

int n, i;
string str;
int maxlen, j, lvl[10005], tata[10005], nr1, nr2, r1, r2, gradMax, r;

ifstream fin("cuvinte.in");
ofstream fout("cuvinte.out");


int reprez(int i){
    int ci = i, aux;
    while (i != tata[i])
        i = tata[i];
    while (ci != i){
        aux = ci;
        ci = tata[ci];
        tata[aux] = i;
    }
    return i;
}

void unesc(int a, int b){
    int tataa = reprez(a), tatab = reprez(b);
    if (lvl[tataa] > lvl[tatab])
        tata[tatab] = tataa;
    else
        tata[tataa] = tatab;
    if (lvl[tataa] == lvl[tatab])
        ++lvl[tatab];
}


int distLev(string c1, string c2, vector <vector <int>> &dp){
    int l1 = c1.length();
    int l2 = c2.length();
    for (int i = 0; i <= l1; ++i){
        dp[i][0] = i;
        dp[0][i] = i;
    }
    for (int i = 1; i <= l1; ++i){
        for (int j = 1; j <= l2; ++j){
            dp[i][j] = min(dp[i-1][j]+1, min(dp[i][j-1] + 1, dp[i-1][j-1] + ((c1[i-1] == c2[j-1]) ? 0 : 1)));
            //cout << i << ' '  << j << ' ' << dp[i][j]<< '\n';
        }
    }
    return dp[l1][l2];
}

int main()
{
    cout << "Dati un k va rog: ";
    cin >> r;                       /// eu am r in loc de k
    vector <string> cuv(1);         ///(1) sa pot indexa de la 1 :)
    maxlen = 0;
    while (fin >> str){
        cuv.push_back(str);
        if (maxlen < str.length())
            maxlen = str.length();
    }
    vector <vector <int>> dp(maxlen+1, vector <int>(maxlen+1));
    n = cuv.size();
     vector <vector <int>> dist(n+1, vector <int>(n+1));
    for (i = 1; i < n; ++i){
        for (j = 1; j < n; ++j){

            if (!dist[i][j]){
                dist[i][j] = distLev(cuv[i], cuv[j], dp);
                dist[j][i] = dist[i][j];
            }
        }
    }
    vector <pair<int, pair<int, int>>> lmuc;
    for (i = 1; i < n; ++i){
        for (j = i+1; j < n; ++j)
        lmuc.push_back({dist[i][j], {i, j}});
    }
    sort(lmuc.begin(), lmuc.end());
    int cateMuc = 0;
    int m = lmuc.size();
    for (i = 1; i < n; ++i){
        tata[i] = i;
        lvl[i] = 0;
    }
    for (int k = 0; k < m; ++k){
        nr1 = lmuc[k].second.first;
        nr2 = lmuc[k].second.second;
        r1 = reprez(nr1);
        r2 = reprez(nr2);
        if (r1 != r2){
            unesc(nr1, nr2);
            ++cateMuc;
        }
        if (cateMuc == n-r-1){
            gradMax = lmuc[k+1].first;
            break;
        }
    }
    unordered_map<int, vector<int>> clase;
    for (i = 1; i < n; ++i){
        clase[reprez(i)].push_back(i);
    }
    for (auto &i : clase){
        for (auto &j : i.second){
            fout << cuv[j] << ' ';
        }
        fout << '\n';
    }
    fout << gradMax;
    return 0;
}
