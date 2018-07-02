//
//  Trie.swift
//  Trie
//
//  Created by Andrei Ermoshin on 02/07/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

import Foundation

// https://www.geeksforgeeks.org/trie-insert-and-search/

class Trie {
    
    private var root = TrieNode()
    
    private var latinSet: CharacterSet {
        var set = CharacterSet()
        set.insert(charactersIn: "a"..."z")
        return set
    }
    
    func insert(_ key: String) {
        var index = key.startIndex
        var current = root
        while index != key.endIndex {
            let ch = key[index]
            if let child = current.children[ch] {
                current = child
            } else {
                let node = TrieNode()
                current.children[ch] = node
                current = node
            }
            index = key.index(index, offsetBy: 1)
        }
        current.isEndOfWord = true
    }
    
    func search(_ key: String) -> Bool {
        var index = key.startIndex
        var current = root
        while index != key.endIndex {
            let ch = key[index]
            if let child = current.children[ch] {
                current = child
            } else {
                return false
            }
            index = key.index(index, offsetBy: 1)
        }
        return current.isEndOfWord
    }
    
    class TrieNode {
        /**
         Need to use Hashbased data structure for
         childrens or to use simple fixed size array
         but characters should be as indexes
         This is required to allow search of character with O(1)
         */

        var children = [Character: TrieNode]()
        var isEndOfWord = false
        
        init() {}
    }
}
