//
//  main.swift
//  Maximum Subarray
//
//  Created by Andrey Ermoshin on 11/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// Find the contiguous subarray within an array
// (containing at least one number) which has the largest sum.

class Solution {
    func maxSubArray(_ nums: [Int]) -> Int {
        // Kadane's algorithm
        // https://en.wikipedia.org/wiki/Maximum_subarray_problem
        // https://www.geeksforgeeks.org/largest-sum-contiguous-subarray/
        
        let length = nums.count
        if length == 0 {
            return 0
        }
        var sum = nums[0]
        var currentSum = sum
        
        for i in 1..<nums.count {
            let x = nums[i]
            currentSum = max(x, currentSum + x)
            if sum < currentSum {
                sum = currentSum
            }
        }
        
        return sum
    }
}

let solver = Solution()
let r2 = [-1]
print("That subarray: \(solver.maxSubArray(r2))")
let r1 = [-2,1,-3,4,-1,2,1,-5,4]
print("That subarray: \(solver.maxSubArray(r1))")
