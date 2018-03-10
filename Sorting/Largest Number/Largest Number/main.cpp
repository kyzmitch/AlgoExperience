//
//  main.cpp
//  Largest Number
//
//  Created by Andrey Ermoshin on 10/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

#include <iostream>
#include <vector>
#include <string>

// Given a list of non negative integers, arrange them such
// that they form the largest number.
//
// For example, given [3, 30, 34, 5, 9], the largest formed
// number is 9534330.
//
// Note: The result may be very large, so you need to
// return a string instead of an integer.

using namespace std;

class Solution {
public:
    string largestNumber(vector<int>& nums) {
        string ret;
        sort(nums.begin(),nums.end(),
             [](const int &m,const int&n){
                 return to_string(m)+to_string(n)>to_string(n)+to_string(m);});
        for(int i=0;i<nums.size();++i){
            ret+=to_string(nums[i]);
        }
        if(ret[0]=='0')
            return "0";
        return ret;
    }
};

int main(int argc, const char * argv[]) {
    Solution solver;
    vector<int> input = {3, 30, 34, 5, 9};
    for (auto it = input.begin() ; it != input.end(); ++it) {
        std::cout << *it << std::endl;
    }
    std::cout << "C++ 11 for loop" << std::endl;
    for(auto const& value: input) {
        std::cout << value << std::endl;
    }
    
    std::cout << std::endl << "Largest number is: " << solver.largestNumber(input) << std::endl;
    return 0;
}
