#include <bits/stdc++.h>

using namespace std;

ifstream fin("apm2.in");
ofstream fout ("apm2.out");

int tata[10001], lvl[10001], i, n, m, q, nr1, nr2, nr3, r1, r2, ri1, ri2, cateMuch, j;

int repr(int i){
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
    int tataa = repr(a), tatab = repr(b);
    if (lvl[tataa] > lvl[tatab])
        tata[tatab] = tataa;
    else
        tata[tataa] = tatab;
    if (lvl[tataa] == lvl[tatab])
        ++lvl[tatab];
}


int main()
{
    fin >> n >> m >> q;
    vector <pair <int, pair <int, int>>> lMuch(m);
    for (i = 0; i < m ; ++i){
        fin >> nr1 >> nr2 >> nr3;
        lMuch[i] = {nr3, {nr1, nr2}};
    }
    vector <pair<int, int>> idei(q);
    for (i = 0; i < q; ++i){
        fin >> nr1 >> nr2;
        idei[i] = {nr1, nr2};
    }
    vector <int> viz(q, -1);
    sort(lMuch.begin(), lMuch.end());
    cateMuch = 0;
    for (i = 1; i <= n; ++i){
        tata[i] = i;
        lvl[i] = 0;
    }
    for (i = 0; i < m; ++i){
        nr1 = lMuch[i].second.first;
        nr2 = lMuch[i].second.second;
        nr3 = lMuch[i].first;
        r1 = repr(nr1);
        r2 = repr(nr2);
        if (r1 != r2){
            for (j = 0; j < q; ++j){
                if (viz[j] < 0){
                    ri1 = repr(idei[j].first);
                    ri2 = repr(idei[j].second);
                    if (ri1 == r1 && ri2 == r2 || ri1 == r2 && ri2 == r1){
                        viz[j] = nr3 - 1;
                    }
                }
            }
            unesc(nr1, nr2);
            ++cateMuch;
        }
        if (cateMuch == n-1)
            break;
    }
    for (auto &k : viz)
        fout << k << '\n';
    return 0;
}
