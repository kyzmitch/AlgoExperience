//
//  main.swift
//  Product of Array Except Self
//
//  Created by admin on 22/02/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

class Solution {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        let n = nums.count
        var r = Array<Int>(repeatElement(1, count: n)) // assuming that all elements > 0
        var left = 1
        var right = 1
        for i in (0..<n) {
            r[i] *= left
            left *= nums[i]
            let j = n - 1 - i
            r[j] *= right
            right *= nums[j]
        }
        
        return r
    }
}

let nums = [1,2,3,4]

let solver = Solution()
let r = solver.productExceptSelf(nums)
print("result: \(r)")
