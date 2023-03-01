#include <bits/stdc++.h>

using namespace std;

int main(){
    vector<vector<int>> grid = {{0,0,1,0,0,0,0,1,0,0,0,0,0},{0,0,0,0,0,0,0,1,1,1,0,0,0},{0,1,1,0,1,0,0,0,0,0,0,0,0},{0,1,0,0,1,1,0,0,1,0,1,0,0},{0,1,0,0,1,1,0,0,1,1,1,0,0},{0,0,0,0,0,0,0,0,0,0,1,0,0},{0,0,0,0,0,0,0,1,1,1,0,0,0},{0,0,0,0,0,0,0,1,1,0,0,0,0}};
    int i, j, n, m, maxAici;
    n = grid.size();
    m = grid[0].size();
    int maxAll = 0;

    queue <pair<int, int>> coada;
    vector <vector <int>> viz(n, vector<int>(m, 0));
    pair <int, int> aici;
    for (i = 0; i < n; ++i){
       // cout << "Am ajuns la i = " << i << '\n';
        for (j = 0; j <m; ++j){
            //cout << "Am ajuns la j = " << j << '\n';
            if (viz[i][j] == 0 && grid[i][j]){
                viz[i][j] = 1;
                maxAici = 1;
                coada.push(make_pair(i, j));

                while (!coada.empty()){

                    aici = coada.front();
                    coada.pop();
                //cout << "aj1\n" << ;
                    if (aici.first != 0 && (viz[aici.first-1][aici.second] == 0) && grid[aici.first-1][aici.second]){ ///sus
                        coada.push(make_pair(aici.first-1, aici.second));
                        viz[aici.first-1][aici.second] = 1;
                        ++maxAici;
                    }
                   //cout << "aj2\n";
                    if (aici.first != n-1 && viz[aici.first+1][aici.second] == 0 && grid[aici.first+1][aici.second]){ ///jos
                        coada.push(make_pair(aici.first+1, aici.second));
                        viz[aici.first+1][aici.second] = 1;
                        ++maxAici;
                    }
                    //cout << "aj3\n";
                    if (aici.second != 0 && viz[aici.first][aici.second-1] == 0 && grid[aici.first][aici.second-1]){///stanga
                        coada.push(make_pair(aici.first, aici.second-1));
                        viz[aici.first][aici.second-1] = 1;
                        ++maxAici;
                    }
                    //cout << "aj4\n";
                    if (aici.second != m-1 && viz[aici.first][aici.second+1] == 0 && grid[aici.first][aici.second+1]){///dreapt
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
    cout << maxAll;
    return 0;
}
