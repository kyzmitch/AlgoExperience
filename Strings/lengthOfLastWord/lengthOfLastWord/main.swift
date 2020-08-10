//
//  main.swift
//  lengthOfLastWord
//
//  Created by Andrei Ermoshin on 8/10/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    func lengthOfLastWord(_ s: String) -> Int {
        guard !s.isEmpty else {
            // empty input
            return 0
        }
        let a = Array(s)
        // need to determine beginning of current word
        // it is first character of input `s` string
        // if it's not a space
        // need to remember index of 1st character of the current word
        // index b
        // need to determine end index of the current word
        // it is an index before space symbol or last index of input `s` string
        // if it doesn't end with space symbol
        
        // 1st index of current word (will be last word as well)
        // if it is nil it means input contained only space symbols
        var bIx: Int?
        
        var i = a.count - 1
        // last index of current word
        var eIx: Int = i
        // 1st find last non space character
        while i >= 0 {
            if a[i] == " " {
                eIx -= 1
            } else {
                break
            }
            i -= 1
        }
        
        guard eIx >= 0 else {
            // all input is from spaces
            return 0
        }
        i -= 1 // to not check alrady checked end symbol
        guard i >= 0 else {
            return 1
        }
        // iterating from the end of input string
        // to find beginning of the last word
        while i >= 0 {
            if a[i] != " " {
                bIx = i
                i -= 1
                continue
            } else {
                bIx = i + 1
                break
            }
        }
        
        guard let first = bIx else {
            // only spaces in input
            return 0
        }
        guard eIx >= first else {
            // assert("impossible indexes, end > first, can't calculate length")
            return 0
        }
        return eIx - first + 1
    }
}

