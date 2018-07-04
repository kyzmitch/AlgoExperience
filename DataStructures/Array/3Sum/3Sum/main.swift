//
//  main.swift
//  3Sum
//
//  Created by Andrey Ermoshin on 18/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// Given an array S of n integers, are there
// elements a, b, c in S such that a + b + c = 0?
// Find all unique triplets in the array which gives the sum of zero.
//
// Note: The solution set must not contain duplicate triplets.
//
// For example, given array S = [-1, 0, 1, 2, -1, -4],
//
// A solution set is:
// [
//  [-1, 0, 1],
//  [-1, -1, 2]
// ]

class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let n = nums.count
        if n < 3 {
            return [[Int]]()
        }
        let sorted = nums.sorted()
        var result = [[Int]]()
        var i = 0
        
        while i < n {
            let current = sorted[i]
            var low: Int
            var high: Int
            if i == 0 {
                low = 1
                high = n - 1
                if sorted[1] == current {
                    i += 1
                    continue
                }
            }
            else if i == n - 1 {
                low = 0
                high = n - 2
                if sorted[high] == current {
                    i += 1
                    continue
                }
            }
            else {
                low = 0
                high = n - 1
                if sorted[i - 1] == current {
                    i += 1
                    continue
                }
                if sorted[i + 1] == current {
                    i += 1
                    continue
                }
            }
            
            while low < high {
                let a = sorted[low]
                let c = sorted[high]
                let sum = a + current + c
                if sum > 0 {
                    high -= 1
                }
                else if sum < 0 {
                    low += 1
                }
                else {
                    result.append([a,current,c])
                    break
                }
            }
            i += 1
        }
        
        return result
    }
}

let solver = Solution()
let input1 = [-1, 0, 1, 2, -1, -4]
let output1 = solver.threeSum(input1)

// https://en.wikipedia.org/wiki/Permutation
// The number of permutations of n distinct objects is n factorial, usually written as n!
// n! = 3! = 3 * 2 = 6
// -1, 0, 1
// -1, 1, 0
// 0, -1, 1
// 0, 1, -1
// 1, -1, 0
// 1, 0, -1
print("solved")
