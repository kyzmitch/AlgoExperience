//
//  WordDictionary.hpp
//  Add and Search Word
//
//  Created by Andrei Ermoshin on 04/10/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

#ifndef WordDictionary_hpp
#define WordDictionary_hpp

#include <string>

using namespace std;

class WordDictionary {
public:
    /** Initialize your data structure here. */
    WordDictionary(): root(new TrieNode()) {

    }

    ~WordDictionary() {

    }

    /** Adds a word into the data structure. */
    void addWord(string word) {
        TrieNode *current = root;
        for (auto i = word.begin(); i != word.end(); ++i) {
            auto value = *i;
            auto index = value - 'a';
            TrieNode *next = current->childNodes[index];
            if (next == nullptr) {
                next = new TrieNode();
                current->childNodes[index] = next;
            }
            current = next;
        }

        current->isWord = true;
    }

    /** Returns if the word is in the data structure. A word could contain the dot character '.' to represent any one letter. */
    bool search(string word) {
        return coreSearch(root, word);
    }

private:
    // only static consts can be used to initialize an array
    static const size_t symbolsCount = 'z' - 'a' + 1; // 'z' - 'a' = 25
    class TrieNode {
    public:
        TrieNode* childNodes[symbolsCount] = {nullptr};
        bool isWord = false;
    };

    bool coreSearch(TrieNode *start, string remainingWordPart) {
        for (auto i = remainingWordPart.begin(); i != remainingWordPart.end(); ++i) {
            auto value = *i;
            if (value == '.') {
                // any symbol in childs
                bool foundAnyChild = false;
                // TODO: this could be parallelized
                for (size_t j = 0; j < symbolsCount; ++j) {
                    TrieNode *child = start->childNodes[j];
                    if (child == nullptr) {
                        continue;
                    } else {
                        // Looks like BFS - breadth first search
                        string word = string(i + 1, remainingWordPart.end());
                        if (coreSearch(child, word)) {
                            return true;
                        }
                        continue;
                    }
                }
                if (!foundAnyChild) {
                    return false;
                }
            } else {
                auto index = value - 'a';
                TrieNode *next = start->childNodes[index];
                if (next == nullptr) {
                    return false;
                } else {
                    start = next;
                }
            }
        }

        return start->isWord;
    }

    TrieNode *root;
};

#endif /* WordDictionary_hpp */
