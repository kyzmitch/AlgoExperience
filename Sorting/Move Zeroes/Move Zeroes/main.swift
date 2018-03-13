//
//  main.swift
//  Move Zeroes
//
//  Created by Andrey Ermoshin on 12/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// Given an array nums, write a function to move
// all 0's to the end of it while maintaining the relative
// order of the non-zero elements.
//
// For example, given nums = [0, 1, 0, 3, 12], after
// calling your function, nums should be [1, 3, 12, 0, 0].
//
// Note:
// You must do this in-place without making a copy of the array.
// Minimize the total number of operations.

class Solution {
    // 5% faster very slow
    func slowBubbleSortMoveZeroes(_ nums: inout [Int]) {
        // should be partly similar to bubble sort
        let n = nums.count
        var i = 0
        var mostLeftZeroIndex = n
        
        while i < n {
            let current = nums[i]
            if current == 0 {
                for j in i..<(n - 1) {
                    nums.swapAt(j, j + 1)
                }
                mostLeftZeroIndex -= 1
            }
            if nums[i] != 0 {
                if i + 1 == mostLeftZeroIndex {
                    return
                }
                i += 1
            }
            else if i == mostLeftZeroIndex {
                return
            }
            
        }
    }
    
    // 12.14 % faster (( still slow
    func slowWithLinearSearchMoveZeroes(_ nums: inout [Int]) {
        let n = nums.count
        var i = 0
        
        while i < n {
            // 1st search first 0
            let current = nums[i]
            if current != 0 {
                i += 1
                continue
            }
            
            if i >= n - 1 {
                return
            }
            
            // now 0 at i + 1
            // need to find first non zero element index
            // which is greater than i + 1
            // and swap them
            var foundNonZero = false
            for j in (i + 1)..<n {
                if nums[j] != 0 {
                    foundNonZero = true
                    nums.swapAt(i, j)
                    break
                }
            }
            
            if foundNonZero {
                i += 1
            }
            else {
                // all next elements are zeroes
                return
            }
        }
    }
    
    func moveZeroes(_ nums: inout [Int]) {
        let n = nums.count
        if n < 2 {
            return
        }
        var lastNonZeroIndex = 0
        
        for x in nums {
            if x != 0 {
                nums[lastNonZeroIndex] = x
                lastNonZeroIndex += 1
            }
        }
        
        while lastNonZeroIndex < n {
            nums[lastNonZeroIndex] = 0
            lastNonZeroIndex += 1
        }
    }
}

let solver = Solution()

var nums2 = [0, 0, 1]
solver.moveZeroes(&nums2)
print("Output: \(nums2)")

var nums = [0, 1, 0, 3, 12]
print("Input: \(nums)")
solver.moveZeroes(&nums)
print("Output: \(nums)")
