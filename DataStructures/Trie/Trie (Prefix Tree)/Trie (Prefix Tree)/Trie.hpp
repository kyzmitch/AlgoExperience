//
//  Trie.hpp
//  Trie (Prefix Tree)
//
//  Created by Andrei Ermoshin on 23/09/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

#ifndef Trie_hpp
#define Trie_hpp

#include <string>

using namespace std;

class Trie {
private:
    struct TrieNode {
        // You may assume that all inputs are consist of lowercase letters a-z.
        static const auto size = 26; // 'z' - 'a' = 25 ?
        TrieNode* children[size] = {nullptr};
        bool isWord;
    public:
        TrieNode(): isWord(false) {
        }
    };
    TrieNode *root;
public:
    /** Initialize your data structure here. */
    Trie(): root(new Trie::TrieNode()) {
    }

    /** Inserts a word into the trie. */
    void insert(string word) {
        // All inputs are guaranteed to be non-empty strings.
        TrieNode *current = root;
        for ( std::string::iterator it=word.begin(); it!=word.end(); ++it) {
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

        current->isWord = true;
    }

    /** Returns if the word is in the trie. */
    bool search(string word) {
        // All inputs are guaranteed to be non-empty strings.
        TrieNode *current = root;
        for ( std::string::iterator it=word.begin(); it!=word.end(); ++it) {
            auto value = *it;
            auto index = value - 'a';
            TrieNode *next = current->children[index];
            if (next == nullptr) {
                return false;
            } else {
                current = next;
            }
        }

        return current->isWord;
    }

    /** Returns if there is any word in the trie that starts with the given prefix. */
    bool startsWith(string prefix) {
        // All inputs are guaranteed to be non-empty strings.
        TrieNode *current = root;
        for ( std::string::iterator it=prefix.begin(); it!=prefix.end(); ++it) {
            auto value = *it;
            auto index = value - 'a';
            TrieNode *next = current->children[index];
            if (next == nullptr) {
                return false;
            } else {
                current = next;
            }
        }
        return true;
    }
};

#endif /* Trie_hpp */
