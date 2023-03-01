class Solution {
public:
    int maxAreaOfIsland(vector<vector<int>>& grid) {
        int i, j, n, m, maxAici;
    n = grid.size();
    m = grid[0].size();
    int maxAll = 0;

    queue <pair<int, int>> coada;
    vector <vector <int>> viz(n, vector<int>(m, 0));
    pair <int, int> aici;
    for (i = 0; i < n; ++i){
        for (j = 0; j <m; ++j){
            if (viz[i][j] == 0 && grid[i][j]){
                viz[i][j] = 1;
                maxAici = 1;
                coada.push(make_pair(i, j));

                while (!coada.empty()){

                    aici = coada.front();
                    coada.pop();
                    if (aici.first != 0 && (viz[aici.first-1][aici.second] == 0) && grid[aici.first-1][aici.second]){ ///sus
                        coada.push(make_pair(aici.first-1, aici.second));
                        viz[aici.first-1][aici.second] = 1;
                        ++maxAici;
                    }
                    if (aici.first != n-1 && viz[aici.first+1][aici.second] == 0 && grid[aici.first+1][aici.second]){ ///jos
                        coada.push(make_pair(aici.first+1, aici.second));
                        viz[aici.first+1][aici.second] = 1;
                        ++maxAici;
                    }
                    if (aici.second != 0 && viz[aici.first][aici.second-1] == 0 && grid[aici.first][aici.second-1]){///stanga
                        coada.push(make_pair(aici.first, aici.second-1));
                        viz[aici.first][aici.second-1] = 1;
                        ++maxAici;
                    }
                    if (aici.second != m-1 && viz[aici.first][aici.second+1] == 0 && grid[aici.first][aici.second+1]){///dreapta
                        coada.push(make_pair(aici.first, aici.second+1));
                        viz[aici.first][aici.second+1] = 1;
                        ++maxAici;
                    }
                    //cout << "aj5\n";
                }
                if (maxAici > maxAll)
                    maxAll = maxAici;
            }
        }

    }
    return maxAll;
    }
};