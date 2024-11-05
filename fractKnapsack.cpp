#include <bits/stdc++.h>
using namespace std;

struct Item {
    int value;
    int weight;
};

class Solution {
  public:
    static  bool cmp(struct Item a, struct Item b)
    {
      double a1=(double)a.value/(double) a.weight;
      double b1=(double)b.value/(double) b.weight;
      return a1>b1;
    }

    double fractionalKnapsack(int w, Item arr[], int n) {
  
      
        sort(arr,arr+n,cmp);
        double ans=0.0;
        
        for(int i=0;i<n;i++)
        {
            if(w>=arr[i].weight)
            {
                ans+=arr[i].value;
                w-=arr[i].weight;
            }
            else
            {
                double fraction=(double)w/(double)arr[i].weight;
                ans+= arr[i].value*fraction;
                break;
            }
        }
        
        return ans;
    }
};


int main() {
 
        int n, W;
        cout<<"Enter total no. of weights:- ";
        cin >> n;
        cout<<"Enter the max weight:-";
        cin>>W;

        Item arr[n];
       
        for (int i = 0; i < n; i++) {
            cout<<"Enter profit and its weight:-";
            cin >> arr[i].value >> arr[i].weight;
        }
        
        Solution ob;
        cout << ob.fractionalKnapsack(W, arr, n) << endl;
    
    return 0;
}