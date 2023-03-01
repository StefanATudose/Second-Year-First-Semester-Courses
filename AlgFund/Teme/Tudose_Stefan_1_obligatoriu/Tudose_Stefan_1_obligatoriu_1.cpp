class Solution {
public:
    void dfs(int n, vector <vector<int>> &adjL, int viz[], int dist, int & ok, int tata){
        if (viz[n] == 0){
            if (dist % 2 == 0)
                viz[n] = 2;
            else
                viz[n] = 1;
            for (auto &it : adjL[n])
                if (it != tata)
                    dfs(it, adjL, viz, dist + 1, ok, n);
        }
        else{
            if (dist % 2 != viz[n] % 2)
                ok = 0;
            return;
        }
    }


    bool possibleBipartition(int n, vector<vector<int>>& dislikes) {
        vector<vector <int>> adjL;
    adjL.assign(n, {});
        for (int i = 0; i < dislikes.size(); ++i){
            adjL[dislikes[i][0]-1].push_back(dislikes[i][1]-1);
            adjL[dislikes[i][1]-1].push_back(dislikes[i][0]-1);
        }
        int viz[n], ok = 1;
        memset(viz, 0, n*sizeof(int));

        for (int i = 0; i < n; ++i){
            if (viz[i] == 0){
                dfs(i, adjL, viz, 0, ok, i);
            }
        }
        return ok;
    }
};

///b) Aceeasi functie dfs
   vector <vector <int>> possibleBipartition(int n, vector<vector<int>>& dislikes) {
        vector<vector <int>> adjL;
    	adjL.assign(n, {});
        for (int i = 0; i < dislikes.size(); ++i){
            adjL[dislikes[i][0]-1].push_back(dislikes[i][1]-1);
            adjL[dislikes[i][1]-1].push_back(dislikes[i][0]-1);
        }
        int viz[n], ok = 1;
        memset(viz, 0, n*sizeof(int));

        for (int i = 0; i < n; ++i){
            if (viz[i] == 0){
                dfs(i, adjL, viz, 0, ok, i);
            }
        }
	vector <vector<int>>rez(2);
        for (int i = 0; i< n; ++i){
		if (viz[i] == 1)
			rez[0].push_back(i+1);
		if (viz[i] == 2)
			rez[1].push_back(i+1);
}
return rez;
    }
};
