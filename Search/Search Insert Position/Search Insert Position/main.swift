//
//  main.swift
//  Search Insert Position
//
//  Created by Andrey Ermoshin on 07/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

class Solution {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1
        var middleIndex = right / 2
        
        while left <= right {
            let current = nums[middleIndex]
            if current < target {
                left = middleIndex + 1
            }
            else if target < current {
                right = middleIndex - 1
            }
            else {
                // found
                return middleIndex
            }
            middleIndex = left + (right - left) / 2
        }
        
        // found position for in order insert
        return left
    }
}

let solver = Solution()
let input = [1,3,5,6]
let input2 = [1,3]
print("position for insert: \(solver.searchInsert(input2, 2))") // 1

print("position for insert: \(solver.searchInsert(input, 5))") // 2
print("position for insert: \(solver.searchInsert(input, 2))") // 1
print("position for insert: \(solver.searchInsert(input, 7))") // 4
print("position for insert: \(solver.searchInsert(input, 0))") // 0
