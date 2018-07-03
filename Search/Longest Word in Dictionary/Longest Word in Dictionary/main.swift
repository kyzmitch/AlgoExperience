//
//  main.swift
//  Longest Word in Dictionary
//
//  Created by Andrei Ermoshin on 28/06/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    
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
                    if !child.isEndOfWord {
                        // Need a word that can be
                        // built one character at a time by
                        // other words
                        return false
                    }
                    current = child
                } else {
                    return false
                }
                index = key.index(index, offsetBy: 1)
            }
            return current.isEndOfWord
        }
        
        class TrieNode {
            var children = [Character: TrieNode]()
            var isEndOfWord = false
        }
    }
    
    func longestWord(_ words: [String]) -> String {
        let trie = Trie()
        for word in words {
            trie.insert(word)
        }
        var longestWord = ""
        var longestLength = 0
        for word in words where trie.search(word) == true {
            let currentLength = word.count
            if currentLength > longestLength {
                longestWord = word
                longestLength = longestWord.count
            } else if currentLength == longestLength {
                if word < longestWord {
                    longestWord = word
                }
            }
        }
        return longestWord
    }
}

let solver = Solution()

let words1 = ["w","wo","wor","worl", "world"]
let words2 = ["a", "banana", "app", "appl", "ap", "apply", "apple"]
print("Result 1: \(solver.longestWord(words1))")
print("Result 2: \(solver.longestWord(words2))")
