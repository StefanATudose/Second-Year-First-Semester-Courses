#include <iostream>
#include <fstream>
#include <vector>
#include <stack>

using namespace std;

ifstream fin("ctc.in");
ofstream fout("ctc.out");

int rez;
vector <vector <int>> rezz;

void ctc(int aici, vector <vector <int>> & adjL, vector <pair <int, int>> & viz, stack <int> & stv, int & pozStiva, vector <int> & inStiva){

    for (auto &it : adjL[aici]){
        if (viz[it].first == -1){
            viz[it].first = pozStiva;
            viz[it].second = pozStiva;
            inStiva[it] = 1;
            stv.push(it);
            ++pozStiva;
            ctc(it, adjL, viz, stv, pozStiva, inStiva);
            viz[aici].second = min(viz[aici].second, viz[it].second);

        }
        else if (inStiva[it]){
            viz[aici].second = min(viz[aici].second, viz[it].second);
        }
    }
    if (viz[aici].second == viz[aici].first){
        rezz.push_back({});
        while (aici != stv.top()){
            rezz[rez].push_back(stv.top()+1);
            inStiva[stv.top()] = 0;
            stv.pop();
        }
        rezz[rez].push_back(aici+1);
        inStiva[aici] = 0;
        stv.pop();
        ++rez;
    }
}
int n, m, nr1, nr2, pozStiva;

int main()
{

    fin >> n >> m;
    vector <vector <int>> adjL(n);
    vector <int> inStiva(n);
    for (int i = 0; i < m; ++i)
    {
        fin >> nr1 >> nr2;
        adjL[nr1-1].push_back(nr2-1);
    }
    vector <pair <int, int>> viz(n, make_pair(-1, 0));
    stack <int> stv;
    for (int i = 0; i < n; ++i){
        if (viz[i].first == -1){
            viz[i].first = 0;
            viz[i].second = 0;
            pozStiva = 1;
            inStiva[i] = 1;
            stv.push(i);
            ctc(i, adjL, viz, stv, pozStiva, inStiva);
        }

    }
    fout << rez << '\n';
    for (int i = 0; i < rez; ++i){
        for (auto j : rezz[i])
            fout << j << ' ';
        fout << '\n';
    }

    return 0;
}
