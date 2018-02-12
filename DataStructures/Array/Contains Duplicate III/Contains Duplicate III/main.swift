//
//  main.swift
//  Contains Duplicate III
//
//  Created by Andrey Ermoshin on 12/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// the absolute difference between nums[i] and nums[j] is at most t
// and the absolute difference between i and j is at most k.
// at most = not bigger than

class Solution {
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        let count = nums.count
        // it seems that t must be >= 0 because it is absolute value
        // and k must be not less than 1 to not get into case
        // when both indexes are point to the same value
        if t < 0 || count < 2 || k < 1 {
            return false
        }
        
        let cache = TreeSet(0, nums[0])
        
        for i in 1..<count {
            let x = nums[i]
            
            // |y-x| <= t
            // 1) y1 <= t + x
            // 1) y >= x
            // 2) y >= x - t
            // 2) y < x
            let y1 = t + x
            let y2 = x - t
            // This is task to solve two systems of linear
            // equations and answer will be range,
            // so Dictionary can't help for that task
            // and TreeSet can help
            
            if let forPositive = cache.floor(y1) {
                if y1 >= x {
                    for ii in forPositive.indexes {
                        if abs(ii - i) <= k {
                            return true
                        }
                    }
                }
            }
            if let forNegative = cache.ceiling(y2) {
                if y2 < x {
                    for ii in forNegative.indexes {
                        if abs(ii - i) <= k {
                            return true
                        }
                    }
                }
            }
            
            cache.insert(i, x)
        }
        return false
    }
}
 
let solver = Solution()
let r5 = [-3,3] // expected: false
print("Contains \(r5) - \(solver.containsNearbyAlmostDuplicate(r5, 2, 4))")
let r9 = [1,0,1,1] // expected: true
print("Contains \(r9) - \(solver.containsNearbyAlmostDuplicate(r9, 1, 0))")
let r8 = [3,6,0,4] // expected: true
print("Contains \(r8) - \(solver.containsNearbyAlmostDuplicate(r8, 2, 2))")
let r7 = [7,1,3] // expected: true
print("Contains \(r7) - \(solver.containsNearbyAlmostDuplicate(r7, 2, 3))")
let r3 = [2,2] // expected: true
print("Contains \(r3) - \(solver.containsNearbyAlmostDuplicate(r3, 3, 0))")
let r6 = [1,2] // expected: false
print("Contains \(r6) - \(solver.containsNearbyAlmostDuplicate(r6, 0, 1))")


//let r4 = [-1,-1] // expected: false ???
// t == -1 ? it should be absolute value
//print("Contains - \(solver.containsNearbyAlmostDuplicate(r4, 1, -1))")
//let r2 = [-1,-1] // expected: true
//print("Contains - \(solver.containsNearbyAlmostDuplicate(r2, 1, 0))")

