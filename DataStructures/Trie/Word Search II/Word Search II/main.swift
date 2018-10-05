//
//  main.swift
//  Word Search II
//
//  Created by Andrei Ermoshin on 05/10/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Trie {

    var root = TrieNode()

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
}

final class TrieNode {
    // it's not possible to use array with exact size
    // to store only 25 possible characters from 'a' up to 'z'
    // there is no init for Array type with optional values instead of TrieNode
    var children = [Character: TrieNode]()
    var isEndOfWord = false
}

class Solution {
    private var width: Int = 0
    private var height: Int = 0

    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        width = board.count
        guard width != 0 else { return [] }
        height = board[0].count
        guard height != 0 else { return [] }
        // can't soleve with using only Trie, because
        // it is not possible to even create root node for it
        // every character from matrix can be first symbol.

        // Hm
        // actually, need create Trie
        let trie = Trie()
        for w in words {
            trie.insert(w)
        }

        var result = Set<String>()
        var inputBoard = board
        // now need recursively emulate DFS
        for i in 0..<width {
            for j in 0..<height {
                search(&inputBoard, result: &result, x: i, y: j, node: trie.root)
            }
        }
        return Array(result)
    }

    private func search(_ board: inout [[Character]], result: inout Set<String>, x: Int, y: Int, node: TrieNode, buffer: String = "") {
        guard x >= 0, x < width, y >= 0, y < height else {
            return
        }
        let ch = board[x][y]
        guard ch != visited else { return }
        guard let nextNode = node.children[ch] else { return }
        board[x][y] = visited
        let prefix = "\(buffer)\(ch)"
        if nextNode.isEndOfWord {
            nextNode.isEndOfWord = false // to avoid dublicates
            result.insert(prefix)
        }

        // Need to check anyway even if no any child nodes
//        if nextNode.children.isEmpty {
//            return
//        }

        search(&board, result: &result, x: x + 1, y: y, node: nextNode, buffer: prefix)
        search(&board, result: &result, x: x, y: y + 1, node: nextNode, buffer: prefix)
        search(&board, result: &result, x: x - 1, y: y, node: nextNode, buffer: prefix)
        search(&board, result: &result, x: x, y: y - 1, node: nextNode, buffer: prefix)
        // Need to return value back and mark board point as not visited
        // to prepare for next iteration
        board[x][y] = ch
    }

    private let visited: Character = "\0"

    struct Point: Hashable {
        let x: Int
        let y: Int
        init(_ x: Int, _ y: Int) {
            self.x = x
            self.y = y
        }
    }
}

let solver = Solution()

let words3 = ["aaa"]
let board3: [[Character]] = [["a", "a"]]
let output3 = solver.findWords(board3, words3)
print("\(output3)") // Output: []

let words = ["oath","pea","eat","rain"]
let board: [[Character]] = [["o","a","a","n"],
                            ["e","t","a","e"],
                            ["i","h","k","r"],
                            ["i","f","l","v"]]

let output = solver.findWords(board, words)
print("\(output)") // Output: ["eat","oath"]

let words2 = ["a"]
let board2: [[Character]] = [["a", "a"]]
let output2 = solver.findWords(board2, words2)
print("\(output2)") // Output: ["a"]

