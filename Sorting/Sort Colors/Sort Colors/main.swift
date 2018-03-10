//
//  main.swift
//  Sort Colors
//
//  Created by Andrey Ermoshin on 10/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// Given an array with n objects colored red, white or blue,
// sort them so that objects of the same color are adjacent,
// with the colors in the order red, white and blue.
//
// Here, we will use the integers 0, 1, and 2 to
// represent the color red, white, and blue respectively.
//
// Note:
// You are not suppose to use the library's sort function for this problem.

class Solution {
    func sortColors(_ nums: inout [Int]) {
        let n = nums.count
        if n < 2 {
            return
        }
        
        // possibly we could use counting sort for that
        var cache = Array<Int>(repeatElement(0, count: 3))
        
        for x in nums {
            cache[x] += 1
        }
        
        // Set each value to be the sum of the previous two values
        cache[1] += cache[0]
        cache[2] += cache[1]
        
        for x in nums {
            cache[x] -= 1
            nums[cache[x]] = x
        }
    }
}

let solver = Solution()
var input1 = [0,0,2,0,1,2,0,1,2,0]
print("Input: \(input1)")
solver.sortColors(&input1)
print("Output: \(input1)")
