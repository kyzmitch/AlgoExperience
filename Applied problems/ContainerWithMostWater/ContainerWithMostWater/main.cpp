//
//  main.cpp
//  ContainerWithMostWater
//
//  Created by Andrey Ermoshin on 07/02/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

#include <vector>

using namespace std;

class Solution {
public:
    int maxArea(vector<int>& height) {
        unsigned long begin = 0;
        unsigned long end = height.size() - 1;
        int total = 0;
        
        while (begin < end) {
            int minHeight = min(height[begin], height[end]);
            int area = (int)(end - begin) * minHeight;
            total = max(total, area);
            if (height[begin] > height[end]) {
                end -= 1;
            } else {
                begin += 1;
            }
        }
        return total;
    }
};
