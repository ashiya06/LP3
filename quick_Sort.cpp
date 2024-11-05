#include <iostream>
#include <vector>
#include <cstdlib> // for rand()
using namespace std;

void printArray(const vector<int>& arr)
{
    for (int num : arr)
    {
        cout << num << " ";
    }
    cout << endl;
}

int deterministic_partition(vector<int>& arr, int low, int high)
{
    int i = low;
    int j = high;
    int pivot = arr[low];

    while (i < j)
    {
        while (arr[i] <= pivot && i < high)
        {
            i++;
        }
        while (arr[j] > pivot && j > low)
        {
            j--;
        }

        if (i < j) swap(arr[i], arr[j]);
    }

    swap(arr[low], arr[j]);
    return j;
}

int randomized_partition(vector<int>& arr, int low, int high)
{
    int pivotIndex = rand() % (high - low + 1) + low; // Corrected range for pivot
    swap(arr[low], arr[pivotIndex]);
    int pivot = arr[low];

    int i = low;
    int j = high;

    while (i < j)
    {
        while (arr[i] <= pivot && i < high)
        {
            i++;
        }
        while (arr[j] > pivot && j > low)
        {
            j--;
        }

        if (i < j) swap(arr[i], arr[j]);
    }

    swap(arr[low], arr[j]);
    return j;
}

void deterministicQuickSort(vector<int>& arr, int low, int high)
{
    if (low < high)
    {
        int p = deterministic_partition(arr, low, high);
        deterministicQuickSort(arr, low, p - 1);
        deterministicQuickSort(arr, p + 1, high);
    }
}

void randomizedQuickSort(vector<int>& arr, int low, int high)
{
    if (low < high)
    {
        int p = randomized_partition(arr, low, high);
        randomizedQuickSort(arr, low, p - 1);
        randomizedQuickSort(arr, p + 1, high);
    }
}

int main()
{
    int n;
    cout << "Enter the number of elements in the array: ";
    cin >> n;

    vector<int> arr(n);
    cout << "Enter the elements of the array: ";
    for (int i = 0; i < n; ++i)
    {
        cin >> arr[i];
    }

    int choice;
    cout << "Choose sorting method:\n1. Deterministic Quick Sort\n2. Randomized Quick Sort\n";
    cin >> choice;

    cout << "Given Array: ";
    printArray(arr);

    switch (choice)
    {
        case 1:
            deterministicQuickSort(arr, 0, n - 1);
            cout << "Sorted Array (Deterministic Quick Sort): ";
            printArray(arr);
            break;

        case 2:
            randomizedQuickSort(arr, 0, n - 1);
            cout << "Sorted Array (Randomized Quick Sort): ";
            printArray(arr);
            break;

        default:
            cout << "Invalid choice!" << endl;
            break;
    }

    return 0;
}
