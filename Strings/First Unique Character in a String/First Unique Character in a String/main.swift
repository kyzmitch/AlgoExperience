//
//  main.swift
//  First Unique Character in a String
//
//  Created by Andrei Ermoshin on 5/5/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    func firstUniqChar(_ s: String) -> Int {
        var uniqueList = [String.Index]()
        var d = Dictionary<Character, String.Index>()
        var i = s.startIndex
        
        while i != s.endIndex {
            let c = s[i]
            if let indexToRemove = d[c] {
                if let r = uniqueList.firstIndex(of: indexToRemove) {
                    uniqueList.remove(at: r)
                }
            } else {
                uniqueList.append(i)
                d[c] = i
            }
            i = s.index(after: i)
        }
        let index = uniqueList.first ?? s.endIndex
        return index == s.endIndex ? -1 : s.distance(from: s.startIndex, to: index)
    }
}

let solver = Solution()
//let i1 = solver.firstUniqChar("leetcode")
//assert(i1 == 0)
//let i2 = solver.firstUniqChar("loveleofcode")
//assert(i2 == 2)
let i3 = solver.firstUniqChar("loveleetcode")
assert(i3 == 2)
