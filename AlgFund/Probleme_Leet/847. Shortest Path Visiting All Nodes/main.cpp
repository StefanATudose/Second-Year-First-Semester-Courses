#include <bits/stdc++.h>

using namespace std;

int dp[4096][13], n;
    vector <vector <int>> cost;
    int bkt(int conf, int last, vector<vector<int>>& adjL){
        if (dp[conf][last] == -1){
            dp[conf][last] = 100000000;
            for (int i = 0; i < n; ++i){
                if (conf & (1 << i)){
                    dp[conf][last] = min(dp[conf][last], bkt(conf ^ (1 << last), i, adjL) + cost[i][last]);
                }
            }
        }
        return dp[conf][last];
    }

    int main() {
        vector<vector<int>> graph = {{}};
        n = graph.size();
        int i, j, k, sol;
        memset(dp, -1, sizeof(dp));
       // cout << dp[14][1] << '\n';
        const int maxx = 100000000;
        cost.assign(n, vector <int>(n, maxx));
        for (i = 0; i < n; ++i){
            for (auto & x : graph[i]){
                cost[i][x] = 1;
                cost[x][i] = 1;
            }
        }
        for (k = 0; k < n; ++k)
            for (i = 0; i < n; ++i)
                for (j = 0; j < n; ++j)
                    if (cost[i][j] > cost[i][k] + cost[k][j])
                        cost[i][j] = cost[i][k] + cost[k][j];
                       // cout << dp[14][1] << '\n';
        for (i = 0; i < n; ++i)
            dp[1 << i][i] = 0;
        sol = 100000000;
        for (j = 0; j < n; ++j)
        for (i = 0; i < graph[j].size(); ++i)
            sol = min (sol, bkt(((1<<n)-1) ^ (1 << j), graph[j][i], graph) + cost[graph[j][i]][j]);
        cout << sol;
    }


/*
class Solution {
public:
    int dp[4096][13], n;
    vector <vector <int>> cost;
    int bkt(int conf, int last){
        if (dp[conf][last] == -1){
            dp[conf][last] = 100000000;
            for (int i = 0; i < n; ++i){
                if (conf & (1 << i)){
                    dp[conf][last] = min(dp[conf][last], bkt(conf ^ (1 << last), i) + cost[i][last]);
                }
            }
        }
        return dp[conf][last];
    }

    int shortestPathLength(vector<vector<int>>& graph) {
        n = graph.size();
        if (n == 1 && graph[0].size() == 0){
            return 0;
        }
            
        int i, j, k, sol;
        memset(dp, -1, sizeof(dp));
        const int maxx = 100000000;
        cost.assign(n, vector <int>(n, maxx));
        for (i = 0; i < n; ++i){
            for (auto & x : graph[i]){
                cost[i][x] = 1;
                cost[x][i] = 1;
            }
        }
        for (k = 0; k < n; ++k)
            for (i = 0; i < n; ++i)
                for (j = 0; j < n; ++j)
                    if (cost[i][j] > cost[i][k] + cost[k][j])
                        cost[i][j] = cost[i][k] + cost[k][j];
        for (i = 0; i < n; ++i)
            dp[1 << i][i] = 0;
        sol = 100000000;
        for (j = 0; j < n; ++j)
        for (i = 0; i < graph[j].size(); ++i)
            sol = min (sol, bkt(((1<<n)-1) ^ (1 << j), graph[j][i]) + cost[graph[j][i]][j]);
        return sol;
    }
};

*/