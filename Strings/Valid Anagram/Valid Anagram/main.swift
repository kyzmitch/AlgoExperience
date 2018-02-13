//
//  main.swift
//  Valid Anagram
//
//  Created by Andrey Ermoshin on 13/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {
            return false
        }
        var sCache = [Character: UInt]()
        var sCount: UInt = 0
        for c in s {
            if let count = sCache[c] {
                sCache[c] = count + 1
            }
            else {
                sCache[c] = 1
            }
            sCount += 1
        }
        
        for v in t {
            if let found = sCache[v] {
                if found == 0 {
                    return false
                }
                sCache[v] = found - 1
            }
            else {
                return false
            }
        }
        
        return true
    }
}

let solver = Solution()
print("Anagram valid - \(solver.isAnagram("anagram", "nagaram"))")
print("Anagram valid - \(solver.isAnagram("rat", "car"))")

