//
//  main.cpp
//  Sort List on Cpp
//
//  Created by Andrey Ermoshin on 10/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

#include <iostream>
#include <vector>

struct ListNode {
     int val;
     ListNode *next;
     ListNode(int x) : val(x), next(NULL) {}
};

using namespace std;

class Solution {
public:
    int count_size(ListNode *node){
        int n = 0;
        while (node != NULL){
            node = node->next;
            ++n;
        }
        return n;
    }
    ListNode *sortList(ListNode *head) {
        int block_size = 1, n = count_size(head), iter = 0, i = 0, a = 0, b = 0;
        ListNode virtual_head(0);
        ListNode *last = NULL, *it = NULL, *A = NULL, *B = NULL, *tmp = NULL;
        virtual_head.next = head;
        while (block_size < n){
            iter = 0;
            last = &virtual_head;
            it = virtual_head.next;
            while (iter <  n){
                a = min(n - iter, block_size);
                b = min(n - iter - a, block_size);
                
                A = it;
                if (b != 0){
                    for (i = 0; i < a - 1; ++i) it = it->next;
                    B = it->next;
                    it->next = NULL;
                    it = B;
                    
                    for (i = 0; i < b - 1; ++i) it = it->next;
                    tmp = it->next;
                    it->next = NULL;
                    it = tmp;
                }
                
                while (A || B){
                    if (B == NULL || (A != NULL && A->val <= B->val)){
                        last->next = A;
                        last = last->next;
                        A = A->next;
                    } else {
                        last->next = B;
                        last = last->next;
                        B = B->next;
                    }
                }
                last->next = NULL;
                iter += a + b;
            }
            block_size <<= 1;
        }
        return virtual_head.next;
    }
};

int main(int argc, const char * argv[]) {
    
    ListNode *list = new ListNode(10);
    ListNode *iterator = list;
    vector<int> v = {652,6686,827,12361,3255,16237,12521,18119,-3734,16499,15868,10684,17520,5995,7791,5454,-2519,139,7650,17842,4898,7022,-7290,-8893,-1605,-1522,3352,4825,12509,922,4716,17811,15247,-680,2387,4844,-7911,623,3397,2932,-8086,3556,12464,7139,11727,4978,370,4633,5889,17123,3020,-294,-4909,5537,-5309,-7190,11247,2711,13295,-5719,-5152,10938,4060,11278,17722,-833,9783,17235,2167,19751,7056,9085,3664,1247,3943,8885,-8637,10813,7472,3877,-9668,2242,730,-9561,-6595,10001,10945,9377,-9871,-1332,1615,-4710,12800};
    for(auto &x: v) {
        ListNode *node = new ListNode(x);
        iterator->next = node;
        iterator = iterator->next;
    }
    
    Solution solver;
    ListNode *sortedList = solver.sortList(list);
    
    return 0;
}
