class Solution {
public:
    void dfs(vector <vector <int>> & adjl, vector <int> & viz, int aici, vector <int> & lowlink, vector <int> & lvl, vector <vector <int>> & rez, vector <int> & tata){
        viz[aici] = 1;
        for (auto & k : adjl[aici]){
            if (viz[k] == 0){
                lvl[k] = lvl[aici]+1;
                lowlink[k] = lvl[k];
                tata[k] = aici;
                dfs(adjl, viz, k, lowlink, lvl, rez, tata);
                lowlink[aici] = min(lowlink[aici], lowlink[k]);
                if (lowlink[k] > lvl[aici])
                    rez.push_back({aici, k});
                    
            }
            else if (viz[k] == 1 && tata[aici] != k){
                lowlink[aici] = min(lowlink[aici], min(lvl[aici], lowlink[k]));
            }
        }
    }
    
    
    vector<vector<int>> criticalConnections(int n, vector<vector<int>>& connections) {
        vector <vector <int>> adjl(n), rez;
        vector <int> viz(n, 0), lvl(n), lowlink(n), tata(n);
        for (int i = 0; i < connections.size(); ++i){
            adjl[connections[i][0]].push_back(connections[i][1]);
            adjl[connections[i][1]].push_back(connections[i][0]);
        }
        for (int i = 0; i < n; ++i){
            if (viz[i] == 0){
                lvl[i] = 0;
                lowlink[i] = 0;
                tata[i] = i;
                dfs(adjl, viz, i, lowlink, lvl, rez, tata);
            }
        }
        return rez;
        
    }
};