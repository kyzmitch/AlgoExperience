//
//  main.swift
//  Replace Words
//
//  Created by Andrei Ermoshin on 30/09/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

import Foundation

final class Trie {

    private var root = TrieNode()

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

    func search(_ key: String) -> Int? {
        var index = key.startIndex
        var current = root
        var lastIndex: Int = 0
        while index != key.endIndex {
            let ch = key[index]
            if let child = current.children[ch] {
                lastIndex += 1
                current = child
            } else {
                return current.isEndOfWord ? lastIndex : nil
            }
            index = key.index(index, offsetBy: 1)
        }
        return current.isEndOfWord ? lastIndex : nil
    }

    final class TrieNode {
        var children = [Character: TrieNode]()
        var isEndOfWord = false
    }
}

/*
 The input will only have lower-case letters.
 1 <= dict words number <= 1000
 1 <= sentence words number <= 1000
 1 <= root length <= 100
 1 <= sentence words length <= 1000
 */

class Solution {
    func replaceWords(_ dict: [String], _ sentence: String) -> String {
        let trie = Trie()
        for root in dict {
            trie.insert(root)
        }

        // https://stackoverflow.com/a/26105807/483101
        let words = sentence.split(separator: " ")
        let length = words.count
        var updatedWords = [String]()
        for i in 0..<length {
            let element = words[i]
            let strElement = String(element)
            guard let rootLastIndex = trie.search(strElement) else {
                updatedWords.append(strElement)
                continue
            }
            let root = element.prefix(rootLastIndex)
            updatedWords.append(String(root))
        }

        var result = "\(updatedWords[0])"
        for x in 1..<length {
            result += " \(updatedWords[x])"
        }
        return result
    }
}

let solver = Solution()
let dict1 = ["cat", "bat", "rat"]
let sentence1 = "the cattle was rattled by the battery"
print("output: \(solver.replaceWords(dict1, sentence1))")
