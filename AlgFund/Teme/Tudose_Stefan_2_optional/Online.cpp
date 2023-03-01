#include <bits/stdc++.h>

using namespace std;

ifstream fin("online.in");
ofstream fout("online.out");

///     *fct paduri start*

int lvl[201], tata[201], n, m, i, nr1, nr2, nr3, cateMuch, k, j;

void init (int i){
    lvl[i] = 0;
    tata[i] = i;
}

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

///     *fct paduri end*




int main()
{
    fin >> n >> m;
    vector <pair <int, pair<int, int>>> lMuc(m), apmM;
    for (i = 0; i < m; ++i){
        fin >> nr1 >> nr2 >> nr3;
        lMuc[i] = {nr3, {nr1, nr2}};
    }
    sort(lMuc.begin(), lMuc.end());
    for (i = 1; i <= n; ++i){
        init(i);
    }
    cateMuch = 0;
    for (i = 0; i < m; ++i){
        nr1 = lMuc[i].second.first;
        nr3 = lMuc[i].first;
        nr2 = lMuc[i].second.second;
        if (reprez(nr1) != reprez(nr2)){
            apmM.push_back({nr3, {nr1, nr2}});
            unesc(nr1, nr2);
            ++cateMuch;
        }
        if (cateMuch == n-1)
            break;
    }
    int sum = 0;
    for (auto & k : apmM){
        sum += k.first;
    }
    fout << sum << '\n';
    fin >> k;
    for (j = 0; j < k; ++j){
        fin >> nr1 >> nr2 >> nr3;
        vector <pair <int, pair<int, int>>> apmNou(apmM);
        apmM.clear();
        apmNou.push_back({nr3, {nr1, nr2}});
        sort (apmNou.begin(), apmNou.end());
        for (i = 1; i <= n; ++i){
            init(i);
        }
        cateMuch = 0;
        for (i = 0; i < n; ++i){
            nr1 = apmNou[i].second.first;
            nr3 = apmNou[i].first;
            nr2 = apmNou[i].second.second;
            if (reprez(nr1) != reprez(nr2)){
                apmM.push_back({nr3, {nr1, nr2}});
                unesc(nr1, nr2);
                ++cateMuch;
            }
            if (cateMuch == n-1)
                break;
        }
        int sum = 0;
        for (auto & k : apmM){
            sum += k.first;
        }
        fout << sum << '\n';
    }

    return 0;
}
