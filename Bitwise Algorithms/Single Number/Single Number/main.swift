//
//  main.swift
//  Single Number
//
//  Created by Andrey Ermoshin on 16/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// Given an array of integers, every element appears twice except for one. Find that single one.

// Note:
// Your algorithm should have a linear runtime complexity. Could you implement it without using extra memory?

class Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        var prev = 0
        for i in (0..<nums.count) {
            prev ^= nums[i]
        }
        
        return prev
    }
}

let solver = Solution()
let input3 = [1,3,2,1,3,1]
print("Single number is \(solver.singleNumber(input3))") // should be 2, but input is not correct, because according to initial conditions: "every element appears twice"
let input2 = [2,1,4,5,2,4,1]
print("Single number is \(solver.singleNumber(input2))") // 5
