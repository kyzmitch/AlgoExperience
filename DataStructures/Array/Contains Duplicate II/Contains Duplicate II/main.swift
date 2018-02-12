//
//  main.swift
//  Contains Duplicate II
//
//  Created by Andrey Ermoshin on 12/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// find out whether there are two distinct indices i and j in the
// array such that nums[i] = nums[j] and the absolute
// difference between i and j is at most k.

class Solution {
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        var cache = Dictionary<Int, Int>()
        
        for (i, x) in nums.enumerated() {
            if let indexOfDuplicate = cache[x] {
                if abs(indexOfDuplicate - i) <= k {
                    return true
                }
            }
            cache[x] = i
        }
        
        return false
    }
}

let solver = Solution()

let r2 = [1,0,1,1]
print("Contains \(solver.containsNearbyDuplicate(r2, 1))")
let r1 = [4,2,1,6,7,3,1,10]
print("Contains \(solver.containsNearbyDuplicate(r1, 4))")

