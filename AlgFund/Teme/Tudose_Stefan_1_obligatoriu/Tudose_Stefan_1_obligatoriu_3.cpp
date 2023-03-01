class Solution {

public:
    void dfs(vector <vector <int>> & lAdj, int start, vector <int> & viz, stack<int> & rez, bool & ciclu){
        if (ciclu == 1)
            return;
        viz[start] = 1;
        for (auto & i : lAdj[start]){
            if (viz[i] == 0)
                dfs(lAdj, i, viz, rez, ciclu);
            else if (viz[i] == 1){
                ciclu = 1;
                return;
            }

        }
        viz[start] = 2;
        rez.push(start);
    }

    vector<int> findOrder(int numCourses, vector<vector<int>> & prerequisites) {
        vector <vector <int>> lAdj(numCourses);
        for (int i = 0; i < prerequisites.size(); ++i){
            lAdj[prerequisites[i][1]].push_back(prerequisites[i][0]);
        }
        vector <int> viz(numCourses, 0);
        stack <int> rez;
        bool ciclu = false;
        for (int i = 0; i < numCourses; ++i){
            if (viz[i] == 0)
                dfs(lAdj, i, viz, rez, ciclu);
        }
        vector <int> rezz;
        if (ciclu)
            return rezz;
        //rezz.push_back(rez.size());
        while (!rez.empty()){
            rezz.push_back(rez.top());
            rez.pop();
        }
        return rezz;

    }
};

class Solution {

public:
    void dfs(vector <vector <int>> & lAdj, int start, vector <int> & viz, stack<int> & rez, bool & ciclu){
        if (ciclu == 1)
            return;
        viz[start] = 1;
        for (auto & i : lAdj[start]){
            if (viz[i] == 0)
                dfs(lAdj, i, viz, rez, ciclu);
            else if (viz[i] == 1){
                ciclu = 1;
	     rez.push(i);
                return;
            }

        }
        viz[start] = 2;
        rez.push(start);
    }

    vector<int> findOrder(int numCourses, vector<vector<int>> & prerequisites) {
        vector <vector <int>> lAdj(numCourses);
        for (int i = 0; i < prerequisites.size(); ++i){
            lAdj[prerequisites[i][1]].push_back(prerequisites[i][0]);
        }
        vector <int> viz(numCourses, 0);
        stack <int> rez;
        bool ciclu = false;
        for (int i = 0; i < numCourses; ++i){
            if (viz[i] == 0)
                dfs(lAdj, i, viz, rez, ciclu);
        }
        vector <int> rezz;
        if (!ciclu)
            return rezz;
        //rezz.push_back(rez.size());
        while (!rez.empty()){
            rezz.push_back(rez.top());
            rez.pop();
        }
        return rezz;

    }
};
