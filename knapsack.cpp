//0-1 knapsack using dynamic programming
//1) memoization
#include<bits/stdc++.h>
using namespace std;
    int dp[101][1001];

class Solution
{
    public:

    int knapsack(int W, int wt[], int val[], int n){
        if(n==0 ||  W==0)
            return 0;

        if(dp[n][W]!=-1)
            return dp[n][W];

        if(wt[n-1]<=W)
        {
            int choose=val[n-1]+knapsack(W-wt[n-1],wt,val,n-1);
            int skip=knapsack(W,wt,val,n-1);
            return dp[n][W]=max(choose,skip);
        }
        else{
            return dp[n][W]=knapsack(W,wt,val,n-1);
        }
    } 
};

int main()
{
    int n, W;
    memset(dp,-1,sizeof(dp));
    cout<<"Enter total no. of weights:- ";
    cin >> n;
    cout<<"Enter the max weight:-";
    cin>>W;
    int wt[n];
    int val[n];
    
    for (int i = 0; i < n; i++) {
        cout<<"Enter profit and its weight:-";
        cin >> val[i]>>wt[i];
    }
    
    Solution ob;
    cout << "Max profit:- "<<ob.knapsack(W,wt,val,n);
}