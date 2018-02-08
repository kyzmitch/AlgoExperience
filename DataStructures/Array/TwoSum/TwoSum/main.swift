//
//  main.swift
//  TwoSum
//
//  Created by Andrey Ermoshin on 08/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// return indices of the two numbers such that
// they add up to a specific target

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        
        // diff - key and value is index
        var cache = Dictionary<Int, Int>()
        for (i, value) in nums.enumerated() {
            if let found = cache[value] {
                return [found, i]
            }
            else {
                cache[target - value] = i
            }
        }
        
        return []
    }
}

let input = [2,7,11,15]
let target = 9
let solver = Solution()

print("Answer: \(solver.twoSum(input, target))")
