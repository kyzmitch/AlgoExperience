//
//  main.swift
//  Longest Increasing Subsequence
//
//  Created by Andrey Ermoshin on 15/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// Given an unsorted array of integers, find the length of longest increasing subsequence.

// For example,
// Given [10, 9, 2, 5, 3, 7, 101, 18],
// The longest increasing subsequence is [2, 3, 7, 101],
// therefore the length is 4.

class Solution {
    func lengthOfLIS(_ nums: [Int]) -> Int {
        let size = nums.count
        if size == 0 {
            return 0
        }
        if size < 2 {
            return 1
        }
        
        var maxLength = 1
        for i in (0..<size) {
            let x = nums[i]
            var currentLength = 1
            var li = i - 1
            var lx = x
            while li >= 0 {
                let currentLeft = nums[li]
                if lx > currentLeft {
                    currentLength += 1
                    lx = currentLeft
                }
                li -= 1
            }
            
            var ri = i + 1
            var rx = x
            while ri < size {
                let currentRight = nums[ri]
                if rx < currentRight {
                    currentLength += 1
                    rx = currentRight
                }
                ri += 1
            }
            
            maxLength = max(maxLength, currentLength)
        }
        
        return maxLength
    }
}

let solver = Solution()
let input1 = [10, 9, 2, 5, 3, 7, 101, 18]
print("longest increasing subsequence length: \(solver.lengthOfLIS(input1))") // 4

