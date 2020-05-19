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
        let zeroes = Array<Int>(repeating: 0, count: 26)
        var cache = zeroes
        // prepare memorization
        var i = s1.startIndex
        var cacheI: Int = 0
        // O(s1.n)
        while i < s1.endIndex {
            cacheI = atoi(s1[i])
            cache[cacheI] += 1
            i = s1.index(after: i)
        }
        
        let standard = cache
        cache = zeroes
        // memorize 1st window
        i = s2.startIndex
        let firstWindowEnd = s2.index(i, offsetBy: windowSize)
        while i < firstWindowEnd {
            cacheI = atoi(s2[i])
            cache[cacheI] += 1
            i = s2.index(after: i)
        }
        
        // check if the very 1st window is the answer
        if standard == cache {
            return true
        }
        
        // start from 2nd index because 1st was handled and used
        // for window memorization above in 1st iteration
        i = s2.index(after: s2.startIndex)
        let end = s2.index(s2.endIndex, offsetBy: -windowSize + 1)
        
        // O(s2.n/s1.n)
        while i < end {
            // remove previous value and add next value from window
            let previous = atoi(s2[s2.index(before: i)])
            cache[previous] -= 1
            let nextI = s2.index(i, offsetBy: windowSize - 1)
            let next = atoi(s2[nextI])
            cache[next] += 1
            // and then compare with `standard`
            if standard == cache {
                return true
            }
            i = s2.index(after: i)
        }
        return false
    }
}

let s = Solution()

let out1 = s.checkInclusion("adc", "dcda")
print("debug \(out1)")
