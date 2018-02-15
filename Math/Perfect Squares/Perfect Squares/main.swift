//
//  main.swift
//  Perfect Squares
//
//  Created by Andrey Ermoshin on 15/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// Given a positive integer n, find the least number of perfect
// square numbers (for example, 1, 4, 9, 16, ...) which sum to n.

// For example, given n = 12, return 3 because 12 = 4 + 4 + 4;
// given n = 13, return 2 because 13 = 4 + 9.

class Solution {
    func numSquares(_ n: Int) -> Int {
        var cache = Dictionary<Int, Int>()
        cache[1] = 1
        cache[2] = 2
        cache[3] = 3
        cache[4] = 1
        return numSquaresHelper(n, &cache)
    }
    
    func numSquaresHelper(_ n: Int, _ cache: inout Dictionary<Int, Int>) -> Int {
        if let cachedValue = cache[n] {
            return cachedValue
        }
        
        var num = Int.max
        var currentNum = 0
        
        let root = sqrt(Double(n))
        var lowerBound = Int(floor(root))
        
        while lowerBound != 0 {
            let secondRemain = n - lowerBound * lowerBound
            currentNum += 1
            if secondRemain == 0 {
                cache[n] = 1
                return 1
            }
            
            currentNum += numSquaresHelper(secondRemain, &cache)
            num = min(num, currentNum)
            currentNum = 0
            lowerBound -= 1
        }
        cache[n] = num
        return num
    }
}

let solver =  Solution()

print("Minimum number of perfect square numbers for \(47) is \(solver.numSquares(47))") // ?
print("Minimum number of perfect square numbers for \(48) is \(solver.numSquares(48))") // 3  according to leetcode
print("Minimum number of perfect square numbers for \(12) is \(solver.numSquares(12))") // 3
print("Minimum number of perfect square numbers for \(13) is \(solver.numSquares(13))") // 2
