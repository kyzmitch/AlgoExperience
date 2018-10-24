//
//  main.swift
//  Jump Game
//
//  Created by Andrei Ermoshin on 24/10/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

import Foundation

/*
 Given an array of non-negative integers, you are initially positioned at the first index of the array.

 Each element in the array represents your maximum jump length at that position.

 Determine if you are able to reach the last index.
 */

class Solution {
    func canJump(_ nums: [Int]) -> Bool {
        if nums.isEmpty {
            return true
        }
        let count = nums.count
        if count == 1 {
            return true
        }
        if count == 2 {
            return nums[0] > 0
        }
        // bottom-up with memorisation and should be without recursion

        var cache = Array<Bool>(repeating: false, count: count)
        let lastIndex = count - 1
        cache[lastIndex] = true
        for j in stride(from: count - 2, to: -1, by: -1) {
            let steps = nums[j]
            if steps == 0 && j != lastIndex {
                continue
            }
            let minRightIndex = min(lastIndex, j + steps)
            for i in (j+1)...minRightIndex {
                if cache[i] {
                    cache[j] = true
                    break
                }
            }
        }
        return cache[0]
    }
}

let s = Solution()

print("true \(s.canJump([2,0,0]))")
// print("true \(s.canJump([2,3,1,1,4]))")
// print("false \(s.canJump([3,2,1,0,4]))")
