#include <bits/stdc++.h>

using namespace std;

int longestCommonSubsequence(string text1, string text2) {
        const int l1 = text1.length(), l2 = text2.length();
        int i, j;
        int dp[l1+1][l2+1];
        memset(dp, 0, sizeof(dp));
        for (i = 1; i <= l1; ++ i)
            for (j = 1; j <= l2; ++j)
                if (text1[i-1] == text2[j-1])
                    dp[i][j] = dp[i-1][j-1] + 1;
                else{
                    dp[i][j] = max(dp[i-1][j], dp[i][j-1]);
                }
        return dp[l1][l2];
    }

int main()
{
    cout << longestCommonSubsequence("abac", "cab");
    return 0;
}
