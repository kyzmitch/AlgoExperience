//
//  main.cpp
//  Min Abs Diff BST
//
//  Created by Andrey Ermoshin on 07/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

#include <iostream>
#include <vector>

 struct TreeNode {
     int val;
     TreeNode *left;
     TreeNode *right;
     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 };


class Solution {
public:
    int getMinimumDifference(TreeNode* root) {
        int result = INT_MAX;
        TreeNode *prev = nullptr;
        inOrderHelper(root, prev, &result);
        return result;
    }
    
    void inOrderHelper(TreeNode *root, TreeNode *&prev, int *diff) {
        if (!root) {
            return;
        }
        inOrderHelper(root->left, prev, diff);
        if (prev) {
            *diff = std::min(*diff, root->val - prev->val);
        }
        prev = root;
        inOrderHelper(root->right, prev, diff);
    }
};


int main(int argc, const char * argv[]) {
    TreeNode *root = new TreeNode(236);
    root->left = new TreeNode(104);
    root->right = new TreeNode(701);
    root->left->right = new TreeNode(227);
    root->right->right = new TreeNode(911);
    Solution solver;
    int min = solver.getMinimumDifference(root);
    std::cout << "min " << min << std::endl;
    return 0;
}


