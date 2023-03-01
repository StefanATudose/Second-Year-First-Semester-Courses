#include <bits/stdc++.h>

using namespace std;

int main()
{
    vector <vector <int>> pairs = {{8,5},{8,7},{0,8},{0,5},{7,0},{5,0},{0,7},{8,0},{7,8}};
    unordered_map <int, int> hash;
        vector <list <int>> adjL;
        int m = pairs.size(), i, vecin;
        vector <int> revHash;
        adjL.reserve(m/2);
        revHash.reserve(m/2);
        hash.reserve(m/2);
        int k = 0;
        for (i = 0; i < m; ++i){
            if (hash.find(pairs[i][0]) == hash.end()){
                hash[pairs[i][0]] = k++;
                revHash.push_back(pairs[i][0]);
                adjL.push_back(list <int>());
            }

            if (hash.find(pairs[i][1]) == hash.end()){
                hash[pairs[i][1]] = k++;
                revHash.push_back(pairs[i][1]);
                adjL.push_back(list <int>());
            }

            adjL[hash[pairs[i][0]]].push_back(hash[pairs[i][1]]);
        }
        vector <int> dIn(k), dOut(k);
        for (i = 0; i < k; ++i){
            for (auto & j : adjL[i]){
                ++dOut[i];
                ++dIn[j];
            }
        }
        int okStart = -1, okEnd = -1, okk = 1;
        for (i = 0; i < k; ++i){
            if (dOut[i] > dIn[i])
                    okStart = i;
            if (dIn[i] > dOut[i])
                    okEnd = i;
        }
        vector <int> ciclu;
        ciclu.reserve(m+1);
        stack <int> recurs;
        if (okStart == -1){       ///ciclu
            recurs.push(0);
            int here;
            while (!recurs.empty()){
                here = recurs.top();
                if (!adjL[here].empty()){
                    vecin = adjL[here].front();
                    adjL[here].pop_front();
                    recurs.push(vecin);
                    continue;
                }
                ciclu.push_back(here);
                recurs.pop();
            }
            vector <vector <int>> rez;
            rez.reserve(ciclu.size()-1);
            for (auto i = ciclu.size()-1; i >= 1; --i)
                rez.push_back({revHash[ciclu[i]], revHash[ciclu[i+1]]});
            for (auto &k : rez)
                cout << k[0] << ' ' << k[1] << '\n';
        }
        else{
            adjL[okEnd].push_back(okStart);
            recurs.push(okStart);
            int here;
            int nrmuc = 0;
            int u, v;
            while (!recurs.empty()){
                here = recurs.top();
                u = revHash[here];
                if (!adjL[here].empty()){
                    ++nrmuc;
                    vecin = adjL[here].front();
                    v = revHash[vecin];
                    if (vecin == okEnd && adjL[vecin].size() == 1 && nrmuc < m){
                        adjL[here].push_back(vecin);
                        adjL[here].pop_back();
                        vecin = adjL[here].front();
                    }
                    adjL[here].pop_front();
                    recurs.push(vecin);
                    continue;
                }
                ciclu.push_back(here);
                recurs.pop();
            }

            vector <vector <int>> rez;
            rez.reserve(ciclu.size()-1);
            for (auto i = ciclu.size()-2; i >= 1; --i)
                rez.push_back({revHash[ciclu[i]], revHash[ciclu[i+1]]});

            for (auto &k : rez)
                cout << k[0] << ' ' << k[1] << '\n';
        }
    return 0;
}
