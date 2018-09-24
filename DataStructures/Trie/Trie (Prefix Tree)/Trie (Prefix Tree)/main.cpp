//
//  main.cpp
//  Trie (Prefix Tree)
//
//  Created by Andrei Ermoshin on 23/09/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

#include <iostream>
#include "Trie.hpp"

int main(int argc, const char * argv[]) {

    /**
     * Your Trie object will be instantiated and called as such:
     * Trie obj = new Trie();
     * obj.insert(word);
     * bool param_2 = obj.search(word);
     * bool param_3 = obj.startsWith(prefix);
     */

    Trie trie = Trie();

    trie.insert("apple");
    std::cout << (trie.search("apple") ? "true" : "false") << "\n"; // returns true
    std::cout << (trie.search("app") ? "true" : "false") << "\n";     // returns false
    std::cout << (trie.startsWith("app") ? "true" : "false") << "\n"; // returns true
    trie.insert("app");
    std::cout << (trie.search("app") ? "true" : "false") << "\n";     // returns true

    return 0;
}
