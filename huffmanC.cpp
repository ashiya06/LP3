#include <iostream>
#include <queue>
#include <vector>
#include <unordered_map>

using namespace std;

// A node of the Huffman tree
struct HuffmanNode {
    char data;
    int freq;
    HuffmanNode *left, *right;

    HuffmanNode(char data, int freq) {
        left = right = nullptr;
        this->data = data;
        this->freq = freq;
    }
};

// Comparison object to order the heap (min-heap) based on frequency
struct compare {
    bool operator()(HuffmanNode* l, HuffmanNode* r) {
        return l->freq > r->freq;
    }
};

// Function to print the Huffman codes from the root of the tree
void printCodes(HuffmanNode* root, string str, unordered_map<char, string>& huffmanCode) {
    if (!root) return;

    // If it's a leaf node, assign the code
    if (!root->left && !root->right) {
        huffmanCode[root->data] = str;
    }

    printCodes(root->left, str + "0", huffmanCode);
    printCodes(root->right, str + "1", huffmanCode);
}

// Main function to build Huffman Tree and generate codes
unordered_map<char,string> huffmanEncoding(vector<char>& chars, vector<int>& freq) {
    // Step 1: Create a priority queue (min-heap) to store live nodes of Huffman tree
    priority_queue<HuffmanNode*, vector<HuffmanNode*>, compare> minHeap;

    // Step 2: Create a leaf node for each character and push it to the priority queue
    for (int i = 0; i < chars.size(); i++) {
        minHeap.push(new HuffmanNode(chars[i], freq[i]));
    }

    // Step 3: Iterate until the size of the heap becomes 1
    while (minHeap.size() != 1) {
        // Extract the two nodes with the lowest frequency
        HuffmanNode* left = minHeap.top();
        minHeap.pop();

        HuffmanNode* right = minHeap.top();
        minHeap.pop();

        // Create a new internal node with frequency equal to the sum of the two nodes' frequencies
        HuffmanNode* top = new HuffmanNode('$', left->freq + right->freq);
        top->left = left;
        top->right = right;

        // Push the new node back into the priority queue
        minHeap.push(top);
    }

    // Step 4: The remaining node is the root of the Huffman tree
    HuffmanNode* root = minHeap.top();

    // Step 5: Traverse the tree and print Huffman codes
    unordered_map<char, string> huffmanCode;
    printCodes(root, "", huffmanCode);

    // Step 6: Return the Huffman code map
    return huffmanCode;
}

int main() {
    string s;
    cout << "Enter the string to encode: ";
    cin >> s;

    unordered_map<char, int> mp;
    for (char ch : s)
        mp[ch]++;

    vector<char> chars;
    vector<int> freq;

    for (auto cf : mp) {
        chars.push_back(cf.first);
        freq.push_back(cf.second);
    }

    // Call Huffman Encoding function
    unordered_map<char, string> huffman = huffmanEncoding(chars, freq);

    // Print the Huffman codes for each character
    cout << "\nHuffman Codes for each character:\n";
    for (auto pair : huffman) {
        cout << pair.first << " : " << pair.second << endl;
    }

    // Print the encoded string
    cout << "\nEncoded String: ";
    for (int i = 0; i < s.length(); i++) {
        cout << huffman[s[i]];
    }
    cout << endl;

    return 0;
}
