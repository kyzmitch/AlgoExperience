//
//  TrieMap.hpp
//  Map Sum Pairs
//
//  Created by Andrei Ermoshin on 26/09/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

#ifndef TrieMap_hpp
#define TrieMap_hpp

#include <string>

using namespace std;

class MapSum {
    private:
    struct TrieNode {
        // You may assume that all inputs are consist of lowercase letters a-z.
        static const auto size = 26; // 'z' - 'a' = 25 ?
        TrieNode* children[size] = {nullptr};
        int value;
    public:
        TrieNode(): value(0) {
        }
    };
    TrieNode *root;
    int calculateSum(TrieNode *node) {
        if (node == nullptr) {
            return 0;
        }
        int sum = node->value;
        for (int i=0; i<TrieNode::size; ++i) {
            TrieNode *current = node->children[i];
            if (current) {
                sum += calculateSum(current);
            }
        }
        return sum;
    }
    void destructor(TrieNode *node) {
        for (int i=0; i < TrieNode::size; ++i) {
            TrieNode *n = node->children[i];
            if (n != nullptr) {
                destructor(n);
            }
        }
        delete node;
    }
    public:
    /** Initialize your data structure here. */
    MapSum(): root(new TrieNode()) {
    }

    ~MapSum() {
        destructor(root);
    }

    void insert(string key, int val) {
        TrieNode *current = root;
        for ( std::string::iterator it=key.begin(); it!=key.end(); ++it) {
            auto value = *it;
            auto index = value - 'a';
            TrieNode *next = current->children[index];
            if (next == nullptr) {
                TrieNode *created = new TrieNode();
                current->children[index] = created;
                current = created;
            } else {
                current = next;
            }
        }
        current->value = val;
    }

    int sum(string prefix) {
        int total = 0;
        TrieNode *current = root;
        for (std::string::iterator it=prefix.begin(); it!=prefix.end(); ++it) {
            auto v = *it;
            auto index = v - 'a';
            TrieNode *next = current->children[index];
            if (next == nullptr) {
                return total;
            }
            current = next;
        }

        total += calculateSum(current);

        return total;
    }
};

#endif /* TrieMap_hpp */
