//bottom up approach:- constant space
#include <iostream>
using namespace std;


int fibonacci(int n, int &stepCount) {
    if (n <= 1) {
        return n;
    }
    
    
    int fib0 = 0, fib1 = 1, fibN;
    stepCount = 0; 
    
    
    for (int i = 2; i <= n; i++) {
        fibN = fib0 + fib1; 
        fib0 = fib1;        
        fib1 = fibN;
        stepCount++;       
    }
    
    return fibN;
}

int main() {
    int n;
    cout << "Enter the Fibonacci number position: ";
    cin >> n;

    int stepCount = 0; 

    
    int result = fibonacci(n, stepCount);

    
    cout << "Fibonacci(" << n << ") = " << result << endl;
    cout << "Number of steps (iterations): " << stepCount << endl;

    return 0;
}




//using recursion
/*
#include <iostream>
using namespace std;

// Global variable to track the number of steps
int stepCount = 0;

// Function to calculate Fibonacci number using recursion
int fibonacci(int n) {
    stepCount++; // Increment step count for each recursive call
    if (n <= 1) {
        return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int main() {
    int n;
    cout << "Enter the Fibonacci number position: ";
    cin >> n;

    // Reset the step count before calling the Fibonacci function
    stepCount = 0;

    // Get the Fibonacci number
    int result = fibonacci(n);

    // Output the Fibonacci number and the number of steps taken
    cout << "Fibonacci(" << n << ") = " << result << endl;
    cout << "Number of steps (recursive calls): " << stepCount << endl;

    return 0;
}
*/




//using memoization
/*
#include <iostream>
using namespace std;

// Function to calculate Fibonacci number using a DP array
int fibonacci(int n, int &stepCount) {
    if (n <= 1) {
        return n;
    }

    // Create a DP array to store Fibonacci numbers up to n
    int dp[n + 1];
    
    // Base cases
    dp[0] = 0;
    dp[1] = 1;
    
    stepCount = 0; // Reset step count
    
    // Fill the DP array with Fibonacci values
    for (int i = 2; i <= n; i++) {
        dp[i] = dp[i - 1] + dp[i - 2]; // Fibonacci relation
        stepCount++; // Increment step count for each iteration
    }
    
    // Return the nth Fibonacci number
    return dp[n];
}

int main() {
    int n;
    cout << "Enter the Fibonacci number position: ";
    cin >> n;

    int stepCount = 0; // Variable to store the step count

    // Get the Fibonacci number
    int result = fibonacci(n, stepCount);

    // Output the Fibonacci number and the number of steps taken
    cout << "Fibonacci(" << n << ") = " << result << endl;
    cout << "Number of steps (iterations): " << stepCount << endl;

    return 0;
}
*/


