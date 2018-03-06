//
//  main.swift
//  Longest Common Prefix
//
//  Created by Andrey Ermoshin on 06/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        let strsCount = strs.count
        if strsCount == 0 {
            return ""
        }
        else if strsCount == 1 {
            return strs[0]
        }
        
        // find minimum length of string from array
        var minimumLength = Int.max
        for s in strs {
            let length = s.count
            if length < minimumLength {
                minimumLength = length
            }
        }
        
        if minimumLength == Int.max {
            return ""
        }
        else if minimumLength == 0 {
            return ""
        }
        
        let firstString = strs[0]
        var sIndex = firstString.startIndex
        var iIndex = 0
        minimumPrefixLoop: while iIndex < minimumLength {
            
            let ic = firstString[sIndex]
            for j in 1..<strsCount {
                let string = strs[j]
                let jc = string[string.index(string.startIndex, offsetBy: iIndex)]
                if ic != jc {
                    break minimumPrefixLoop
                }
            }
            sIndex = firstString.index(after: sIndex)
            iIndex += 1
        }
        
        let commonPrefix = firstString.prefix(upTo: sIndex)
        return String(commonPrefix)
    }
}

let solver = Solution()
let sample3 = ["c", "c"]
print("Longest common prefix is '\(solver.longestCommonPrefix(sample3))'")
let sample2 = ["a", "b"]
print("Longest common prefix is '\(solver.longestCommonPrefix(sample2))'")
let sample1 = ["abcde", "abklm", "agmn"]
print("Longest common prefix is '\(solver.longestCommonPrefix(sample1))'")


