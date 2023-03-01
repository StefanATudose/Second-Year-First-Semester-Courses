/*class Solution {
public:
    double maxProbability(int n, vector<vector<int>>& edges, vector<double>& succProb, int start, int end) {
        int i;
        const int maxx = -2147483647;
        vector <vector <pair<int, double>>> adjl(n);
        for (i = 0; i < edges.size(); ++i){
            adjl[edges[i][0]].push_back(make_pair(edges[i][1], succProb[i]));
            adjl[edges[i][1]].push_back(make_pair(edges[i][0], succProb[i]));
        }
        vector <pair <double, int>> dist(n);
        for (i = 0; i < n; ++i)
            dist[i] = make_pair(maxx, i);
        dist[start] = make_pair(0, start);
        pair <double, int> curent;
        priority_queue <pair <double, int>> hip(dist.begin(), dist.end());
        for (i = 0; i < n-1; ++i){
            curent = hip.top();
            hip.pop();
            if (curent.first == maxx)
                break;
            dist[curent.second].first = curent.first;
            for (auto &j : adjl[curent.second]){
                if (log2(dist[j.first].first) > log2(j.second) + log2(curent.first)){
                    dist[j.first].first =  exp2(log2(j.second) + log2(curent.first));
                    hip.push(make_pair(dist[j.first].first, j.first));
                }
            }
        }
        return dist[end].first;
    }
};
*/
#include <bits/stdc++.h>

using namespace std;

double test1, test2;

int main(){/*
    int n = 3;
    vector<vector<int>> edges = {{0,1}, {1,2}, {0,2}};

    vector<double> succProb = {0.5, 0.5, 0.3};
    int start = 0;
    int end = 2;
    int i;
        const int maxx = -1;
        vector <vector <pair<int, double>>> adjl(n);
        for (i = 0; i < edges.size(); ++i){
            adjl[edges[i][0]].push_back(make_pair(edges[i][1], succProb[i]));
            adjl[edges[i][1]].push_back(make_pair(edges[i][0], succProb[i]));
        }
        vector <pair <double, int>> dist(n);
        for (i = 0; i < n; ++i)
            dist[i] = make_pair(maxx, i);
        dist[start] = make_pair(0, start);
        pair <double, int> curent;
        priority_queue <pair <double, int>> hip(dist.begin(), dist.end());
        for (i = 0; i < n-1; ++i){
            curent = hip.top();
            hip.pop();
            if (curent.first == maxx)
                break;
            dist[curent.second].first = curent.first;
            for (auto &j : adjl[curent.second]){
                if (dist[j.first].first <= 0 || log2(dist[j.first].first) < log2(j.second) + log2(curent.first)){
                    if (j.second == 0)
                        dist[j.first].first = curent.first;
                    else if (curent.first == 0)
                        dist[j.first].first =j.second;
                    else
                        dist[j.first].first = exp2(log2(j.second) + log2(curent.first));
                    hip.push(make_pair(dist[j.first].first, j.first));
                }
            }
        }
        if (dist[end].first == maxx)
            cout << 0 << '\n';
        else
            cout << dist[end].first << '\n';
            */
        cout << log2(0) + log2(0.5);
        return 0;
}

