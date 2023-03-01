#include <iostream>
#include <fstream>
#include <vector>
#include <queue>

using namespace std;

ifstream fin("graf.in");
ofstream fout("graf.out");

int n, m, nr1, nr2;

int main()
{
    fin >> n >> m;
    vector <vector <int>> adjL(n);
    for (int i =0; i < m; ++i){
        fin >> nr1 >> nr2;
        adjL[nr1-1].push_back(nr2-1);
        adjL[nr2-1].push_back(nr1-1);
    }
    vector <int> dist(n, -1);
    queue <int> q;
    while (fin >> nr1){
        q.push(nr1-1);
        dist[nr1-1] = 0;
    }
    cout << "am ajuns1\n";
    while (!q.empty()){
        nr1 = q.front();
        //cout << "am ajuns2\n";
        for (auto & j : adjL[nr1]){
            if (dist[j] == -1){
                dist[j] = dist[nr1]+1;
                q.push(j);
            }
        }
        q.pop();
        //cout << "am ajuns2\n";
    }

    for (auto & j : dist){
        fout << j << ' ';
    }
    return 0;
}
