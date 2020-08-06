//
//  main.swift
//  Remove Element
//
//  Created by Andrei Ermoshin on 8/6/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

// https://leetcode.com/problems/remove-element/

class Solution {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var vacantIndex: Int?
        var tmp: Int = 0
        var newLength = nums.count
        var vacantAmountInArow: Int = 0
        for (i, x) in nums.enumerated() {
            if x == val {
                newLength -= 1
                if let vacantIx = vacantIndex {
                    // already has one pending vacant place
                    vacantAmountInArow += 1
                } else {
                    vacantIndex = i
                }
                continue
            }
            guard let vacantIx = vacantIndex else {
                continue
            }
            tmp = nums[vacantIx]
            nums[vacantIx] = x
            nums[i] = tmp
            vacantIndex = vacantAmountInArow < 1 ? i : vacantIx + 1
        }
        return newLength
    }
}
