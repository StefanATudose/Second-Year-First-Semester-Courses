#include <bits/stdc++.h>
#define int long long
using namespace std;

ifstream fin("catun.in");
ofstream fout ("catun.out");

int n, m, k, i, nr1, nr2, nr3;

int32_t main()
{

    const int maxx = 2147483647;
    fin >> n >> m >> k;
    vector <int> apartCet (n+1, 0), cet(k+1);

    vector <vector <pair <int, int>>> adjl(n+1);             ///pair <vecin, cost>
    priority_queue <pair <int, int>, vector <pair<int, int>>, greater <pair<int, int>>> hip;
    vector <int> dist(n+1, maxx);
    for (i = 1; i <= k; ++i){
        fin>> cet[i];
        apartCet[cet[i]] = cet[i];
        hip.push({0, cet[i]});
        dist[cet[i]] = 0;
    }

    for (i = 1; i <= m; ++i){
        fin >> nr1 >> nr2 >> nr3;
        adjl[nr1].push_back(make_pair(nr2, nr3));       ///pair <vecin, cost>
        adjl[nr2].push_back(make_pair(nr1, nr3));
    }

    pair <int, int> aici;                           ///pair <dist, indexAlLui>
    vector <bool> viz(n+1);
    while (hip.size()){
        aici = hip.top();
        hip.pop();
        if (viz[aici.second])
            continue;
        for (auto & r : adjl[aici.second]){
            if (dist[r.first] > r.second + aici.first){
                dist[r.first] = r.second + aici.first;
                apartCet[r.first] = apartCet[aici.second];
                hip.push({dist[r.first], r.first});
            }
            else if (dist[r.first] == r.second + aici.first && apartCet[r.first] > apartCet[aici.second]){
                apartCet[r.first] = apartCet[aici.second];
            }

        }
        viz[aici.second] = 1;
        //cout << "aj " << i << " \n";
    }
    for (i = 1; i <= k; ++i){
        apartCet[cet[i]] = 0;
    }
    for (i = 1; i <= n; ++i)
        fout << apartCet[i] << ' ';
    return 0;
}
