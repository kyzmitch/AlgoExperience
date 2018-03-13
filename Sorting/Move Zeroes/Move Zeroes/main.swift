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
    func moveZeroes(_ nums: inout [Int]) {
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
}

let solver = Solution()

var nums2 = [0, 0, 1]
solver.moveZeroes(&nums2)
print("Output: \(nums2)")

var nums = [0, 1, 0, 3, 12]
print("Input: \(nums)")
solver.moveZeroes(&nums)
print("Output: \(nums)")
