//
//  main.cpp
//  Best Time to Buy and Sell Stock
//
//  Created by Andrey Ermoshin on 12/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int maxProfit(vector<int>& prices) {
        size_t size = prices.size();
        if (size < 2) {
            // you can't sell, only buy probably
            return 0;
        }
        
        int minimumPrice = prices[0];
        int maxProfit = max(prices[1] - minimumPrice, 0);
        
        for (unsigned int i = 1; i < size - 1; i++) {
            int currentDayPrice = prices[i];
            if (currentDayPrice < minimumPrice) {
                minimumPrice = currentDayPrice;
            }
            int tempProfit = prices[i+1] - minimumPrice;
            maxProfit = max(maxProfit, tempProfit);
        }
        
        return maxProfit;
    }
};

int main(int argc, const char * argv[]) {
    Solution solver;
    vector<int> r1 = {7, 1, 5, 3, 6, 4};
    // Output: 5
    std::cout << "Max profit " << solver.maxProfit(r1) << std::endl;
    vector<int> r2 = {7, 6, 4, 3, 1};
    // Output: 0
    std::cout << "Max profit " << solver.maxProfit(r2) << std::endl;
    return 0;
}
