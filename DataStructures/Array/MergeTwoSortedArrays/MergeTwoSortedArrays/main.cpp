//
//  main.cpp
//  MergeTwoSortedArrays
//
//  Created by Andrey Ermoshin on 07/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

#include <vector>
#include <iostream>

using namespace std;

class Solution {
public:
    /*
     Crayzy task, unbelivable how undenstand it
     
     I faced the same problem as yours .After I check some results of other input, I think we were used to misunderstand the mean of the m and n
     Let’s see some results:
     [1] 1,[0] 1 -> [0]
     [1] 1,[2] 1 -> [1]
     [1,3,4,5] 2,[2] 1 ->[1,2,3,5]
     [1,3,4] 4,[2] 1 -> [1,3,4]
     [1,3,4,5] 4,[2] 1 -> [1,2,3,4]
     We could see the m means the valid numbers of the nums1 array and it’s not more than the total number of the elements.Such as the No.4 result , the nums1 has 3 numbers but the m = 4, and return [1,3,4] not [1,2,3,4], it may means if the m(n) more than the number of elements of the array , the system will not recieve the input.
     Now let’s see the No.1\No.2\No.3\No.5 result, the length of the result is not more than the length of the nums1 whatever the m it is.
     In the No.3 result , only 1,3 of the nums1 were sorted with the 2 from nums2 and the 3 occupy the postion of the 4.
     So you should know the m means how many elements from the beginning of the nums1 should be sorted with the first n elements of the nums2.The new elements from the nums2 will occupy the postion of elements in nums1 which should not be sorted. However the length of the nums1 must be not less than m + n.
     */
    
    
    void merge(vector<int>& nums1, int m, vector<int>& nums2, int n) {
        int index = m + n - 1;
        int p1 = m - 1;
        int p2 = n - 1;
        
        while(p1 >= 0 && p2 >= 0)
        {
            nums1[index--] = (nums1[p1] > nums2[p2]) ? nums1[p1--] : nums2[p2--];
        }
        while(p2 >= 0)
            nums1[index--] = nums2[p2--];
        
    }
};

void logElement (int i) {
    std::cout << i << ", ";
}

int main(int argc, const char * argv[]) {
    // [1,3,4,5] 2,[2] 1 ->[1,2,3,5]
    vector<int> nums1;
    nums1.push_back(1);
    nums1.push_back(3);
    nums1.push_back(4);
    nums1.push_back(5);
    vector<int> nums2;
    nums2.push_back(2);
    Solution solver;
    solver.merge(nums1, (int)2, nums2, (int)1);
    
    for_each(nums1.begin(), nums1.end(), logElement);
    
    return 0;
}



