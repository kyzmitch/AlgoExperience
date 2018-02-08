//
//  main.swift
//  InPlaceDuplicatesRemoving
//
//  Created by Andrey Ermoshin on 08/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// Given a sorted array, remove the duplicates in-place such that
// each element appear only once and return the new length.

// Do not allocate extra space for another array, you must
// do this by modifying the input array in-place with O(1) extra memory.

class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        var resultCount = nums.count;
        if resultCount < 2 {
            return resultCount
        }
        var i = 1
        var prev = nums[0]
        
        while i != nums.count {
            let current = nums[i]
            if current == prev {
                nums.remove(at: i)
                resultCount -= 1
            }
            else {
                prev = current
                i += 1
            }
        }
        
        return resultCount;
    }
}

var nums = [1,1,2]

let solver = Solution()
print("Count after removing duplicates: \(solver.removeDuplicates(&nums)) \nand resylt array is \(nums)")
