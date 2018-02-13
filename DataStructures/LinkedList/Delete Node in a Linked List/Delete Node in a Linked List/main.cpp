//
//  main.cpp
//  Delete Node in a Linked List
//
//  Created by Andrey Ermoshin on 13/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

#include <iostream>


 struct ListNode {
     int val;
     ListNode *next;
     ListNode(int x) : val(x), next(NULL) {}
};

class Solution {
public:
    void deleteNode(ListNode* node) {
        if (node == nullptr) {
            return;
        }
        // NOTE: can't remove if node is the last node
        if (node->next == nullptr) {
            return;
        }
        ListNode *i = node->next;
        ListNode *previous = node;
        while (true) {
            previous->val = i->val;
            if (i->next != nullptr) {
                previous = i;
                i = i->next;
            }
            else {
                break;
            }
        }
        previous->next = nullptr;
    }
    
    void fastNodeDelete(ListNode* node) {
        if (node == nullptr) {
            return;
        }
        
        if (node->next == nullptr) {
            return;
        }
        ListNode *right = node->next->next;
        node->val = node->next->val;
        node->next = right;
    }
};

int main(int argc, const char * argv[]) {
    Solution solver;
    ListNode *r1 = new ListNode(1);
    r1->next = new ListNode(2);
    r1->next->next = new ListNode(3);
    r1->next->next->next = new ListNode(4);
    ListNode *nodeToRemove = r1->next->next;
    
    solver.fastNodeDelete(nodeToRemove);
    std::cout << "After removing\n";
    return 0;
}
