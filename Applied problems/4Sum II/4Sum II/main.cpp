//
//  main.cpp
//  4Sum II
//
//  Created by Andrey Ermoshin on 08/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

#include <iostream>
#include <vector>
#include <unordered_map>
#include <tuple>

using namespace std;

class Solution {
public:
    typedef unordered_map<int, unsigned int> Dictionary;
    
    int fourSumCount(vector<int>& A, vector<int>& B, vector<int>& C, vector<int>& D) {
        
        // using of dictionary leads to problem
        // when you have a(-1,-1( b(-1,1)
        // which gives you dictionary from (-2, 0, -2, 0)
        // which gives you just two keys (-2, 0)
        // so, that skips two tuples by mistake
        // so, need to store not tuple with indices
        // but just counter
        // unordered_map<int, tuple<int, int>> cache;
        Dictionary cache;
        for (unsigned int i = 0; i < A.size(); i++) {
            for (unsigned int j = 0; j < B.size(); j++) {
                int firstSum = A[i] + B[j];
                Dictionary::iterator found = cache.find(firstSum);
                if (found != cache.end()) {
                    found->second = found->second + 1;
                }
                else {
                    cache[firstSum] = 1;
                }
            }
        }
        
        int count = 0;
        for (unsigned int i = 0; i < C.size(); i++) {
            for (unsigned int j = 0; j < D.size(); j++) {
                int secondSum = C[i] + D[j];
                Dictionary::const_iterator found = cache.find(-secondSum);
                if (found != cache.end()) {
                    count += found->second;
                }
            }
        }
        
        return count;
    }
};


int main(int argc, const char * argv[]) {
    vector<int> a({-1, -1});
    vector<int> b({-1, 1});
    vector<int> c({-1,1});
    vector<int> d({1, -1});
    
    Solution solver;
    
    std::cout << "How many tuples with 0 sum - " << solver.fourSumCount(a, b, c, d) << std::endl;
    return 0;
}
