//
//  main.swift
//  Find All Anagrams in a String
//
//  Created by Andrei Ermoshin on 5/19/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    private static let shift = Character("a").asciiValue!
    
    func atoi(_ c: Character) -> Int {
        return Int(c.asciiValue! - Solution.shift)
    }
    
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
        let arrs = Array(s)
        let arrp = Array(p)
        let windowSize = arrp.count
        let sSize = arrs.count
        guard windowSize < sSize else {
            return [Int]()
        }
        
        // 26 characters in latic alphabet
        var standard = Array<Int>(repeating: 0, count: 26)
        var cache = standard
        for c in arrp {
            standard[atoi(c)] += 1
        }
        // first iteration, first index
        for i in 0..<windowSize {
            cache[atoi(arrs[i])] += 1
        }
        
        var result = [Int]()
        if standard == cache {
            // anagram is present on 0 index
            result.append(0)
        }
        
        var i = 1
        while i < sSize - windowSize + 1 {
            cache[atoi(arrs[i - 1])] -= 1
            cache[atoi(arrs[i + windowSize - 1])] += 1
            if standard == cache {
                result.append(i)
            }
            i += 1
        }
        
        return result
    }
}

