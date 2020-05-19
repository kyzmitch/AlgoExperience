//
//  main.swift
//  Permutation in String
//
//  Created by Andrei Ermoshin on 5/18/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    private static let shift = Character("a").asciiValue!
    
    func atoi(_ c: Character) -> Int {
        return Int(c.asciiValue! - Solution.shift)
    }
    
    func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        let windowSize = s1.distance(from: s1.startIndex, to: s1.endIndex)
        let s2size = s2.distance(from: s2.startIndex, to: s2.endIndex)
        guard s2size >= windowSize else {
            return false
        }
        
        // array should store amount of specific character in s1
        // like dictionary ["a"] = 2, s1 should contain 2 a's
        // 26 - characters in latic alphabet
        var cache = Array<Int>(repeating: 0, count: 26)
        
        // prepare memorization
        var i = s1.startIndex
        var cacheI: Int = 0
        // O(s1.n)
        while i < s1.endIndex {
            cacheI = atoi(s1[i])
            cache[cacheI] = cache[cacheI] + 1
            i = s1.index(after: i)
        }
        
        let etalon = cache
        
        i = s2.startIndex
        let end = s2.index(s2.endIndex, offsetBy: -windowSize + 1)
        
        // O(s2.n/s1.n)
        while i < end {
            var j = i
            let jEnd = s2.index(j, offsetBy: windowSize)
            var remainingCharacters = windowSize
            while j < jEnd {
                let cIndex = atoi(s2[j])
                let cAmount = cache[cIndex]
                if cAmount > 0 {
                    // found one of characters from s1 in s2
                    remainingCharacters -= 1
                    cache[cIndex] = cAmount - 1
                } else {
                    // window contains not right (unknown) character
                    // slide window forward
                    break
                }
                j = s2.index(after: j)
            }
            if remainingCharacters == 0 {
                return true
            }
            // memory consuming part!
            cache = etalon
            i = s2.index(after: i)
        }
        return false
    }
}

let s = Solution()

let out1 = s.checkInclusion("abb", "eidbbboaoo")
print("debug \(out1)")
