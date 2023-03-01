#include <bits/stdc++.h>
#define int long long
using namespace std;

ifstream fin("easygraph.in");
ofstream fout("easygraph.out");

int minn, nrT, n, m, i, nr1, nr2;

void dfsDinamic(int aici, vector <bool> & viz, vector <vector<int>> & adjl, vector <int> &vnod, vector <int> & vbest){
    viz[aici] = 1;
    for (auto &vecin : adjl[aici]){
        if (viz[vecin] == 0){
            dfsDinamic(vecin, viz, adjl, vnod, vbest);
        }
        if (vbest[aici] < vbest[vecin] + vnod[aici])
            vbest[aici] = vbest[vecin] + vnod[aici];
    }
}


int32_t main()
{
    fin >> nrT;
    while (nrT--){
        fin >> n >> m;
        vector <int> vnod(n), vbest(n);
        for (i = 0; i < n; ++i){
            fin >> vnod[i];
            vbest[i] = vnod[i];
        }
        vector <vector <int>> adjl(n);
        for (i = 0; i < m; ++i){
            fin >> nr1 >> nr2;
            --nr1; --nr2;
            adjl[nr1].push_back(nr2);
        }

        vector <bool> viz(n);
        for (i = 0; i < n; ++i)
            if (viz[i] == 0)
                dfsDinamic(i, viz, adjl, vnod, vbest);
        minn = -2147483647;
        for (i = 0; i < n; ++i)
            if (vbest[i] > minn)
                minn = vbest[i];
        fout << minn << '\n';
    }
    return 0;
}
