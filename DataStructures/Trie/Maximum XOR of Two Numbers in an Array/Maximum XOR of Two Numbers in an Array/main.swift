//
//  main.swift
//  Maximum XOR of Two Numbers in an Array
//
//  Created by Andrei Ermoshin on 11/10/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

import Foundation

// Input: [3, 10, 5, 25, 2, 8]

// Output: 28

// Explanation: The maximum result is 5 ^ 25 = 28.

final class TrieNode {
    var yes: TrieNode?
    var no: TrieNode?
}

class Solution {
    func findMaximumXOR(_ nums: [Int]) -> Int {
        let root = TrieNode()
        let intSize = MemoryLayout<Int>.size * 8
        // fill-in Trie with bits
        for n in nums {
            var current = root
            // Need to iterate from the start bit
            // to allow search from higher bit
            // which will give us Maximum numbers
            // in case of different bits during comparisons
            for i in stride(from: intSize - 1, to: -1, by: -1) {
                let bit = (n >> i) & 1
                if bit == 0 {
                    if let next = current.no {
                        current = next
                    } else {
                        let newNode = TrieNode()
                        current.no = newNode
                        current = newNode
                    }
                } else {
                    if let next = current.yes {
                        current = next
                    } else {
                        let newNode = TrieNode()
                        current.yes = newNode
                        current = newNode
                    }
                }
            }
        }

        // search for max
        var max = Int.min
        for n in nums {
            var start = root
            var currentMax: Int = 0
            for i in stride(from: intSize - 1, to: -1, by: -1) {
                let bit = (n >> i) & 1

                if bit == 0 {
                    if let next = start.yes {
                        currentMax += (1 << i)
                        start = next
                    } else {
                        start = start.no!
                    }
                } else {
                    if let next = start.no {
                        currentMax += (1 << i)
                        start = next
                    } else {
                        start = start.yes!
                    }
                }
            }
            max = Swift.max(max, currentMax)
        }

        return max
    }
}

let s = Solution()
let i1: [Int] = [3, 10, 5, 25, 2, 8]
let o1 = s.findMaximumXOR(i1) // 28 = 2 ^ 25
print("\(o1)")
let i2: [Int] = [4,6,7]
print("\(s.findMaximumXOR(i2))") // 3
