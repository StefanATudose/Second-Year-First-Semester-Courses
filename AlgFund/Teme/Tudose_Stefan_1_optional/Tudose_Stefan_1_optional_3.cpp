#include <bits/stdc++.h>

using namespace std;

ifstream fin("graf.in");
ofstream fout("graf.out");

int n, m, x, y, i, nr1, nr2;

int main()
{
    fin >> n >> m >> x >> y;
    --x; --y;
    vector <vector <int>> adjl(n);
    for (i = 0; i < m; ++i){
        fin >> nr1 >> nr2;
        adjl[nr1-1].push_back(nr2-1);
        adjl[nr2-1].push_back(nr1-1);
    }
    queue <int> coad;
    vector <int> dist(n, -1), viz (n);
    dist[x] = 0;
    coad.push(x);
    int maxu = 0;
    while (!coad.empty()){
        nr1 = coad.front();
        coad.pop();
        for (auto & k : adjl[nr1]){
            if (dist[k] == -1){
                dist[k] = dist[nr1]+1;
                if (dist[k] > maxu)
                    maxu = dist[k];
                coad.push(k);
            }
        }
    }
    coad.push(y);
    vector <unordered_set<int>> apPerDist(maxu+1);
    apPerDist[dist[y]].insert(y);
    while (!coad.empty()){                                  ///aparent nu iese din loop aici la test 4
        nr1 = coad.front();                                 ///de ce?
        coad.pop();
        for (auto &k : adjl[nr1]){
            if (dist[k] == dist[nr1]-1){
                if (apPerDist[dist[k]].find(k) == apPerDist[dist[k]].end()){
                    apPerDist[dist[k]].insert(k);
                    coad.push(k);
                }

            }
        }
    }
    vector <int> rez;
    for (i = 0; i <= maxu; ++i)
        if (apPerDist[i].size() == 1){
            rez.push_back(*apPerDist[i].begin());
        }

    fout << rez.size() << '\n';
    sort(rez.begin(), rez.end());
    for (auto & k : rez)
        fout << k+1 << ' ';

    return 0;
}
