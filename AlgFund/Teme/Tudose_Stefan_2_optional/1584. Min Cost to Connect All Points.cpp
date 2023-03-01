class Solution {
public:
    int manDist(int x1, int y1, int x2, int y2){
        return abs(x1-x2) + abs(y1-y2);
    }


    int minCostConnectPoints(vector<vector<int>>& points) {
        int n = points.size(), maxAcum, i, j, imax, distJ;
        const int maxx = 2147483647;
        vector <bool> viz(n);
        vector <int >dist(n, maxx);
        dist[0] = 0;
        for (i = 0; i < n-1; ++i){
            maxAcum = 2147483647;
            for (j = 0; j < n; ++j){
                if (viz[j] == 0 && dist[j] < maxAcum){
                    maxAcum = dist[j];
                    imax = j;
                }
            }
            viz[imax] = 1;
            for (j = 0; j < n; ++j){
                distJ = manDist(points[imax][0], points[imax][1], points[j][0], points[j][1]);
                if (viz[j] == 0 && dist[j] > distJ)
                    dist[j] = distJ;
            }
        }
        long long sum = 0;
        for (i = 0; i < n; ++i)
            sum += dist[i];
        return sum;
    }
};
