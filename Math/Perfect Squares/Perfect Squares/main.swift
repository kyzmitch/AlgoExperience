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
    func numSquaresWithSlowDictionaryCache(_ n: Int) -> Int {
        var cache = Dictionary<Int, Int>()
        cache[1] = 1
        cache[2] = 2
        cache[3] = 3
        cache[4] = 1
        return numSquaresHelperForDictionary(n, &cache)
    }
    
    func numSquaresHelperForDictionary(_ n: Int, _ cache: inout Dictionary<Int, Int>) -> Int {
        
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
            if let cachedValue = cache[n] {
                 currentNum += cachedValue
            }
            else {
                currentNum += numSquaresHelperForDictionary(secondRemain, &cache)
            }
            num = min(num, currentNum)
            currentNum = 0
            lowerBound -= 1
        }
        cache[n] = num
        return num
    }
    
    func numSquaresWithArrayCache(_ n: Int) -> Int {
        var cache = Array<Int>(repeatElement(0, count: n + 1))
        return numSquaresHelperForArray(n, &cache)
    }
    
    func numSquaresHelperForArray(_ n: Int, _ cache: inout Array<Int>) -> Int {
        
        // Bottom-up DP solution
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
            let cachedValue = cache[n]
            if cachedValue > 0 {
                currentNum += cachedValue
            }
            else {
                currentNum += numSquaresHelperForArray(secondRemain, &cache)
            }
            num = min(num, currentNum)
            currentNum = 0
            lowerBound -= 1
        }
        cache[n] = num
        return num
    }
    
    func numSquaresWithDP(_ n: Int) -> Int {
        // DP solution from leetcode
        if n <= 0 {
            return 0
        }
        
        var cntPerfectSquares = Array(repeatElement(Int.max, count: n + 1))
        cntPerfectSquares[0] = 0
        for i in (1...n) {
            // For each i, it must be the sum of some number (i - j*j) and
            // a perfect square number (j*j).
            var j = 1
            var squredJ = 1
            while squredJ <= i {
                cntPerfectSquares[i] = min(cntPerfectSquares[i], cntPerfectSquares[i - squredJ] + 1)
                j += 1
                squredJ = j * j
            }
        }
        
        return cntPerfectSquares[n]
    }
    
    func numSquares(_ n: Int) -> Int {
        // Static Dynamic Programming from leetcode
        if n <= 0 {
            return 0
        }
        
        // cntPerfectSquares[i] = the least number of perfect square numbers
        // which sum to i. Since cntPerfectSquares is a static vector, if
        // cntPerfectSquares.size() > n, we have already calculated the result
        // during previous function calls and we can just return the result now.
        var cntPerfectSquares = Array<Int>()
        cntPerfectSquares.append(0)
        // While cntPerfectSquares.size() <= n, we need to incrementally
        // calculate the next result until we get the result for n.
        while cntPerfectSquares.count <= n {
            let m = cntPerfectSquares.count
            var cntSquares = Int.max;
            var i = 1
            var squaredI = 1
            
            while squaredI <= m {
                cntSquares = min(cntSquares, cntPerfectSquares[m - squaredI] + 1)
                i += 1
                squaredI = i * i
            }
            
            cntPerfectSquares.append(cntSquares)
        }
        
        return cntPerfectSquares[n]
    }
}

let solver =  Solution()

print("Minimum number of perfect square numbers for \(47) is \(solver.numSquares(47))") // 4
print("Minimum number of perfect square numbers for \(48) is \(solver.numSquares(48))") // 3
print("Minimum number of perfect square numbers for \(12) is \(solver.numSquares(12))") // 3
print("Minimum number of perfect square numbers for \(13) is \(solver.numSquares(13))") // 2
