//
//  main.swift
//  Palindrome Pairs
//
//  Created by Andrei Ermoshin on 06/10/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Trie {

    var root = TrieNode()
    private var emptyKeyIndex: Int?

    func insert(_ key: String, _ i: Int) {
        if key.isEmpty {
            emptyKeyIndex = i
            return
        }

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
        current.wordIndex = i
    }

    func searchPalindromePart(_ word: ReversedCollection<String>, _ originalWord: String, _ index: Int) -> [Point] {
        var result = [Point]()

        var i = word.startIndex
        var current = root
        var prefix = ""
        while i != word.endIndex {
            let ch = word[i]
            guard let nextNode = current.children[ch] else {
                // 1. when first symbol or searched word is not found
                // and it means that result must be empty
                // 2. if something was found before
                if prefix.isEmpty {
                    return [Point]()
                } else {
                    break
                }
            }

            // for exaple input is "sll" (reverted "lls") and trie has "s" word
            // "s" + "lls" = "slls" - palindrome
            prefix = "\(prefix)\(ch)"
            if let wordIx = nextNode.wordIndex, index != wordIx {
                if "\(prefix)\(originalWord)".isPalindrom() {
                    result.append(Point(wordIx, index))
                }
            }

            current = nextNode
            i = word.index(i, offsetBy: 1)
        }

        // need to check all below nodes to find suffixes
        // which are palindroms
        // because at this moment we are sure that
        // prefixes are mirrored and they're good

        // 1. search all subwords
        // 2. check if subwords are palindroms or not
        guard !current.children.isEmpty else {
            if let emptyIx = emptyKeyIndex, prefix.isPalindrom() {
                result.append(Point(index, emptyIx))
            }
            return result
        }
        var subwords = [String: Int]()
        if let emptyIx = emptyKeyIndex, emptyIx != index {
            subwords[""] = emptyIx
        }
        parseSubwords(current, &subwords, buffer: prefix, currentIndex: index)
        for (key, v) in subwords where index != v {
            if "\(key)\(originalWord)".isPalindrom() {
                result.append(Point(v, index))
            }
            if "\(originalWord)\(key)".isPalindrom() {
                result.append(Point(index, v))
            }
        }

        return result
    }

    private func parseSubwords(_ node: TrieNode, _ result: inout [String: Int], buffer: String, currentIndex: Int) {
        if let i = node.wordIndex, i != currentIndex {
            result[buffer] = i
            if node.children.isEmpty {
                return
            }
        }

        for (ch, n) in node.children {
            parseSubwords(n, &result, buffer: "\(buffer)\(ch)", currentIndex: currentIndex)
        }
    }
}

final class TrieNode {
    var children = [Character: TrieNode]()
    var wordIndex: Int?
}

extension String {
    func isPalindrom() -> Bool {
        var left = self.startIndex
        let middle = index(left, offsetBy: self.count / 2)
        var right = index(self.endIndex, offsetBy: -1)
        while left != middle {
            guard self[left] == self[right] else {
                return false
            }
            left = index(left, offsetBy: 1)
            right = index(right, offsetBy: -1)
        }
        return true
    }
}

struct Point: Hashable {
    let x: Int
    let y: Int
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

class Solution {

    func palindromePairs(_ words: [String]) -> [[Int]] {

        let trie = Trie()
        let length = words.count
        for j in 0..<length {
            trie.insert(words[j], j)
        }

        // TODO: avoid using custom Point type
        // to not have overhead
        var result = Set<Point>()
        for i in 0..<length {
            let w = words[i]
            let indexes = trie.searchPalindromePart(w.reversed(), w, i)
            if !indexes.isEmpty {
                result = result.union(indexes)
            }
        }

        var array = [[Int]]()
        for p in result {
            array.append([p.x, p.y])
        }
        return array
    }
}

let solver = Solution()


func tests(_ solver: Solution) {
    let input5 = ["a","b","c","ab","ac","aa"]
    print("\(solver.palindromePairs(input5))")
    // [[3,0],[1,3],[4,0],[2,4],[5,0],[0,5]]
    
    let input3 = ["aba", ""]
    print("\(solver.palindromePairs(input3))")
    // [[0,1],[1,0]]

    let input1 = ["abcd","dcba","lls","s","sssll"]
    let output1 = solver.palindromePairs(input1)
    print("\(output1)")
    // Output: [[0,1],[1,0],[3,2],[2,4]]
    let input2 = ["bat","tab","cat"]
    let output2 = solver.palindromePairs(input2)
    print("\(output2)")
    // Output: [[0,1],[1,0]]

    let input4 = ["a","abc","aba",""]
    print("\(solver.palindromePairs(input4))")
    // [[0,3],[3,0],[2,3],[3,2]]
}

tests(solver)
