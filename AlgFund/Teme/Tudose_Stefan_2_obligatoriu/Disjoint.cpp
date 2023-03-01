#include <bits/stdc++.h>

using namespace std;

ifstream fin("disjoint.in");
ofstream fout ("disjoint.out");

int n, m, i, tip, x, y, grad[100000], tata[100000];

int gasesc (int x){
    int xinit = x;
    while (tata[x] != x)
        x = tata[x];
    while (xinit != x){
        tata[xinit] = x;
        xinit = tata[xinit];
    }
    return x;
}

void unesc(int x, int y){
    int tatx = gasesc(x), taty = gasesc(y);
    if (grad[tatx] > grad[taty])
        tata[taty] = tatx;
    else
        tata[tatx] = taty;
    if (grad[tatx] == grad[taty])
        ++grad[taty];
}

void afisRez(int x, int y){
    if (gasesc(x) == gasesc(y))
        fout << "DA\n";
    else
        fout << "NU\n";
}


int main()
{
    fin >> n >> m;
    for (i = 0; i < n; ++i){
        grad[i] = 1;
        tata[i] = i;
    }
    for (i = 0; i < m; ++i){
        fin >> tip >> x >> y;
        if (tip == 1){
            unesc(x, y);
        }
        else{
            afisRez(x, y);
        }
    }
    return 0;
}
