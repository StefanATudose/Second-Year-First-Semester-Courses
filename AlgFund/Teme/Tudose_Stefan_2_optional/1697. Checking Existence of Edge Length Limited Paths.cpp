class Solution {
public:
    static bool comp(vector <int> & v1, vector <int> & v2){
        return v1[2] < v2[2];
    }


    ///  *functii paduri start*
    int reprez(int i, vector <int> & tata){
        int ci = i, aux;
        while (i != tata[i])
            i = tata[i];
        while (ci != i){
           aux = ci;
            ci = tata[ci];
              tata[aux] = i;
          }
        return i;
}

    void unesc(int a, int b, vector <int> &tata, vector <int> & lvl){
      int tataa = reprez(a, tata), tatab = reprez(b, tata);
        if (lvl[tataa] > lvl[tatab])
           tata[tatab] = tataa;
        else
            tata[tataa] = tatab;
        if (lvl[tataa] == lvl[tatab])
            ++lvl[tatab];
    }


    /// *functii paduri end*


    vector<bool> distanceLimitedPathsExist(int n, vector<vector<int>>& edgeList, vector<vector<int>>& queries) {
        vector <vector <int>> queriess(queries.size(), vector <int>(4));
        int i, nr1, nr2, nr3;
        for (i = 0; i < queries.size(); ++i){
            queriess[i][0] = queries[i][0];
            queriess[i][1] = queries[i][1];
            queriess[i][2] = queries[i][2];
            queriess[i][3] = i;
        }
        sort(edgeList.begin(), edgeList.end(), comp);
        sort(queriess.begin(), queriess.end(), comp);
        vector <int> tata(n), lvl(n);
        vector <bool> rez;
        int sizeQuer = queries.size();
        rez.assign(sizeQuer, 0);
        for (i = 0; i < n; ++i){
            tata[i] = i;
        }
        int upperLimit = 0, cateMuch = 0, j = 0;
        for (i = 0; i < queriess.size(); ++i){
            if (queriess[i][2] > upperLimit){
                upperLimit = queriess[i][2];
                for (; j < edgeList.size() && cateMuch < n-1; ++j){
                    if (edgeList[j][2] >= upperLimit)
                        break;
                    nr1 = edgeList[j][0];
                    nr2 = edgeList[j][1];
                    if (reprez(nr1, tata) != reprez(nr2, tata)){
                        unesc(nr1, nr2, tata, lvl);
                        ++cateMuch;
                    }
                }
            }
            if (reprez(queriess[i][0], tata) == reprez(queriess[i][1], tata))
                rez[queriess[i][3]] = true;
            else
                rez[queriess[i][3]] = false;
        }
        return rez;



    }
};
