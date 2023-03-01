#include <bits/stdc++.h>
using namespace std;

ifstream fin("retea2.in");
ofstream fout ("retea2.out");

int n, m, i, j, xi, yi;
double minu;

double calcDist(int x1, int y1, int x2, int y2){
    return sqrt(1.0 * (x1-x2)*(x1-x2) + 1.0*(y1-y2)*(y1-y2));

}

int main()
{

    const double maxx = 2147483647;
    fin >> n >> m;
    vector <pair<int, int>> centrl(n), bloc(m);
    vector <double> dist(m, maxx);
    for (i = 0; i < n; ++i){
        fin >> xi >> yi;
        centrl[i] = make_pair(xi, yi);
    }
    for (i = 0; i < m; ++i){
        fin >> xi >> yi;
        bloc[i] = make_pair(xi, yi);
    }
    double dis;
    vector <bool> viz(m);
    for (i = 0; i < n; ++i){
        for (j = 0; j < m; ++j){
            dis = calcDist(centrl[i].first, centrl[i].second, bloc[j].first, bloc[j].second);
            if (dis < dist[j])
                dist[j] = dis;
        }
    }
    int aici;
    for (j = 0; j < m; ++j){
        minu = maxx;
        for (i = 0; i < m; ++i){
            if (viz[i]==0 && dist[i] < minu){
                minu = dist[i];
                aici = i;
                xi = bloc[i].first;
                yi = bloc[i].second;
            }
        }
        viz[aici] = 1;
        for (i = 0; i < m; ++i){
            dis = calcDist(xi, yi, bloc[i].first, bloc[i].second);
            if (dis < dist[i] && viz[i] == 0)
                dist[i] =dis;
        }
    }
    double sum = 0;
    for (j = 0; j < m; ++j)
        sum = sum + dist[j];
    fout.precision(7);
    fout << fixed << sum <<'\n';
    return 0;
}
