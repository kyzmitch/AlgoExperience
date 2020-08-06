//
//  main.swift
//  StrStr search substring
//
//  Created by Andrei Ermoshin on 8/6/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        // can use Array to get characters of strings
        // because according to task conditions
        // alphabet for them is lowercased Eng characters - ascii encoding
        // which means that 256  bits are used
        guard !needle.isEmpty else {
            return 0
        }
        guard !haystack.isEmpty else {
            return -1
        }
        
        let input = Array(haystack)
        let s = Array(needle)
        let nLenght = s.count
        let f = s[0]
        // will try to use sliding window approach
        // to be able to search with linear complexity O(n)
        // j - is last index of haystack string for matching symbol from needle
        // e.g. `hello` and `ll`, for 1st iteration it is 2, 2nd iteration it is 3
        var j: Int?
        // count of found characters
        var c = 0
        var i = 0
        while i < input.count {
            let x = input[i]
            if let jj = j {
                // already found sequence, now need to check if rest of
                // the needle follows matching prefix
                let nC = s[c]
                if nC == x {
                    j = jj + 1
                    c += 1
                } else {
                    // only prefix of needle was good
                    // but it isn't matching from this symbol
                    // it means we're resetting search state
                    // but at the same time again checking if
                    // it matches beginning of needle
                    
                    // return back to try next beggining
                    i = jj - c + 2
                    j = nil
                    c = 0
                    continue // to skip increment of i
                }
            } else {
                // need to check if current symbol match with
                // first symbol of needle
                if x == f {
                    j = i
                    c = 1
                } else {
                    // symbol doesn't match with needle beginning
                    i += 1
                    continue
                }
            }
            // check every iteration if it was last needed symbol
            // for full match with needle
            if c == nLenght {
                // found whole needle
                return j! - c + 1
            }
            i += 1
        }
        
        // after loop
        if let jj = j, c == nLenght {
            // found whole needle
            return jj - c + 1
        } else {
            return -1
        }
    }
}


let sol = Solution()
print(sol.strStr("mississippi", "pi"))
