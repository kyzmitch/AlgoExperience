//
//  main.swift
//  Climbing Stairs
//
//  Created by Andrey Ermoshin on 14/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// You are climbing a stair case. It takes n steps to reach to the top.

// Each time you can either climb 1 or 2 steps.
// In how many distinct ways can you climb to the top?

// Note: Given n will be a positive integer.

/*
 Input: 2
 Output:  2
 Explanation:  There are two ways to climb to the top.
 
 1. 1 step + 1 step
 2. 2 steps
 
 Input: 3
 Output:  3
 Explanation:  There are three ways to climb to the top.
 
 1. 1 step + 1 step + 1 step
 2. 1 step + 2 steps
 3. 2 steps + 1 step
 */

class Solution {
    func climbStairs(_ n: Int) -> Int {
        if n == 0 {
            return 0
        }
        if n == 1 {
            return 1
        }
        if n == 2 {
            return 2
        }
        var i = 2
        var stepsCount = 0
        var cache = Array<Int>(repeatElement(0, count: n))
        cache[0] = 1
        cache[1] = 2
        // bottom - up
        while i < n {
            stepsCount = cache[i - 1] + cache[i - 2]
            cache[i] = stepsCount
            i += 1
        }
        return stepsCount
    }
    
    func dictionaryClimbStairs(_ n: Int) -> Int {
        if n == 0 {
            return 0
        }
        if n == 1 {
            return 1
        }
        if n == 2 {
            return 2
        }
        var i = 3
        var stepsCount = 0
        var cache = [Int: Int]()
        cache[2] = 2
        cache[1] = 1
        // bottom - up
        while i <= n {
            if let previous = cache[i - 1],
                let preprevious = cache[i - 2] {
                stepsCount = previous + preprevious
                cache[i] = stepsCount
            }
            i += 1
        }
        return stepsCount
    }
    
    func recursiveClimbStairs(_ n: Int) -> Int {
        // This solution will take exponential time
        // so for n = 44 it will fail defenetly on leetcode
        // so, it must be solved with using DP
        if n == 0 {
            return 0
        }
        if n == 1 {
            return 1
        }
        if n == 2 {
            return 2
        }
        if n > 2 {
            // one or two steps
            return recursiveClimbStairs(n - 1) + recursiveClimbStairs(n - 2)
        }
        else {
            // < 0
            // Note: Given n will be a positive integer.
            // so, this case is impossible for leetcode
            // but parameter could be negative
            return 0
        }
    }
}

let solver = Solution()

print("How many ways to climb stairs with \(2) stair: \(solver.climbStairs(2))") // expected: 2
print("How many ways to climb stairs with \(3) stair: \(solver.climbStairs(3))") // expected: 3
print("How many ways to climb stairs with \(4) stair: \(solver.climbStairs(4))") // expected: 5
print("How many ways to climb stairs with \(5) stair: \(solver.climbStairs(5))\n") // expected: 8

print("How many ways to climb stairs with \(2) stair: \(solver.dictionaryClimbStairs(2))") // expected: 2
print("How many ways to climb stairs with \(3) stair: \(solver.dictionaryClimbStairs(3))") // expected: 3
print("How many ways to climb stairs with \(4) stair: \(solver.dictionaryClimbStairs(4))") // expected: 5
print("How many ways to climb stairs with \(5) stair: \(solver.dictionaryClimbStairs(5))\n") // expected: 8

print("How many ways to climb stairs with \(2) stair: \(solver.recursiveClimbStairs(2))") // expected: 2
print("How many ways to climb stairs with \(3) stair: \(solver.recursiveClimbStairs(3))") // expected: 3
print("How many ways to climb stairs with \(4) stair: \(solver.recursiveClimbStairs(4))") // expected: 5
print("How many ways to climb stairs with \(5) stair: \(solver.recursiveClimbStairs(5))") // expected: 8
