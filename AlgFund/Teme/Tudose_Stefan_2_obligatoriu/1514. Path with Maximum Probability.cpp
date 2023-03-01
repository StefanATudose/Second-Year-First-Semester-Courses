class Solution {
public:
    double maxProbability(int n, vector<vector<int>>& edges, vector<double>& succProb, int start, int end) {
        int i;
        const int maxx = -1;
        vector <vector <pair<int, double>>> adjl(n);
        vector <bool> viz(n);
        for (i = 0; i < edges.size(); ++i){
            adjl[edges[i][0]].push_back(make_pair(edges[i][1], succProb[i]));
            adjl[edges[i][1]].push_back(make_pair(edges[i][0], succProb[i]));
        }
        vector <double> dist(n);
        for (i = 0; i < n; ++i)
            dist[i] = maxx;
        dist[start] = 1;
        pair <double, int> curent;
        priority_queue <pair <double, int>> hip;
        hip.push({1, start});
        while (!hip.empty()){
            curent = hip.top();
            hip.pop();
            if (viz[i] == 1)
                continue;
            for (auto &j : adjl[curent.second]){
                if (dist[j.first] <= 0 || log2(dist[j.first]) < log2(j.second) + log2(curent.first))
                {
                    if (j.second == 0)
                        dist[j.first] = curent.first;
                    else if (curent.first == 0)
                        dist[j.first] = j.second;
                    else
                        dist[j.first] = exp2(log2(j.second) + log2(curent.first));
                    hip.push(make_pair(dist[j.first], j.first));
                }
            }
            viz[curent.second] = 1;

        }
        if (dist[end] == maxx)
            return 0;
        else
            return dist[end];
    }
};
