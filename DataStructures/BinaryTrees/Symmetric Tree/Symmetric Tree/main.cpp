//
//  main.cpp
//  Symmetric Tree
//
//  Created by Andrey Ermoshin on 08/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

#include <iostream>

// Given a binary tree, check whether it is a mirror of
// itself (ie, symmetric around its center).
// For example, this binary tree [1,2,2,3,4,4,3] is symmetric:
//    1
//   / \
//  2   2
// / \ / \
//3  4 4  3
// But the following [1,2,2,null,3,null,3] is not:
//   1
//  / \
// 2   2
// \    \
//  3    3


struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

TreeNode* symmetricTree() {
    TreeNode *root = new TreeNode(1);
    root->left = new TreeNode(2);
    root->right = new TreeNode(2);
    root->left->left = new TreeNode(3);
    root->left->right = new TreeNode(4);
    root->right->left = new TreeNode(4);
    root->right->right = new TreeNode(3);
    return root;
}

TreeNode* notSymmetricTree() {
    TreeNode *root = new TreeNode(1);
    root->left = new TreeNode(2);
    root->right = new TreeNode(2);
    root->left->right = new TreeNode(3);
    root->right->right = new TreeNode(3);
    return root;
}
 
class Solution {
public:
    bool symmetricHelper(TreeNode* left, TreeNode *right) {
        if (left == nullptr) {
            return right == nullptr;
        }
        if (right == nullptr) {
            return left == nullptr;
        }
        if (left->val != right->val) {
            return false;
        }
        // 2nd part switches sides
        return symmetricHelper(left->left, right->right) && symmetricHelper(left->right, right->left);
    }
    bool isSymmetric(TreeNode* root) {
        return symmetricHelper(root, root);
    }
};

int main(int argc, const char * argv[]) {
    TreeNode *symmetricNode = symmetricTree();
    TreeNode *nonSymmetricNode = notSymmetricTree();
    Solution solver;
    std::cout << "1) is symmetric: " << (solver.isSymmetric(symmetricNode) ? "true" : "false") << std::endl;
    std::cout << "2) is symmetric: " << (solver.isSymmetric(nonSymmetricNode) ? "true" : "false") << std::endl;
    return 0;
}
