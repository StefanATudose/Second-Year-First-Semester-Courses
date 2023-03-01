#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int n, m, i;
vector <int> perm, pozInPerm;

bool compFct(int a, int b){             ///aici trebuie sa sortez toate listele de adiacenta in functie de pozitia in permutare
    return pozInPerm[b] > pozInPerm[a];
}

void dfs(int n, vector<int> & viz, vector<vector<int>> & adjL, vector <int> &rez){
        viz[n] = 1;
        rez.push_back(n);
        for (auto &it : adjL[n]){
            if(viz[it] == 0)
                dfs(it, viz, adjL, rez);
                //--pozPerm;
        }
}

int main()
{
    cin >> n >> m;
    perm.assign(n, 0);
    pozInPerm.assign(n, 0);
    vector <int>  viz(n, 0);
    vector <vector <int>> adjL(n);
    for ( i = 0; i < n; ++i){
        cin >> perm[i];
        --perm[i];
        pozInPerm[perm[i]] = i;
    }
    int m1, m2;
    for (i = 0; i < m; ++i){
        cin >> m1 >> m2;
        adjL[m1-1].push_back(m2-1);
        adjL[m2-1].push_back(m1-1);
    }
    for (i = 0; i < n; ++i){
        if (!adjL[i].empty()){
                sort(adjL[i].begin(), adjL[i].end(), compFct);
        }
    }
    vector <int> rez;
    rez.reserve(n);
    dfs(perm[0], viz, adjL, rez);
    bool ok = 1;
    for (i = 0; i < n; ++i)
        if (rez[i] != perm[i])
            ok = 0;
    cout << ok;

    return 0;
}

