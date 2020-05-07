//
//  main.swift
//  Majority Element
//
//  Created by Andrei Ermoshin on 5/7/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    func majorityElement(_ nums: [Int]) -> Int {
        var d = [Int: Int]()
        var maxKey: Int?
        var maxCount = 0
        let limit = nums.count / 2
        
        for n in nums {
            let newCount: Int
            if let c = d[n] {
                newCount = c + 1
                d[n] = newCount
            } else {
                newCount = 1
                d[n] = 1
            }
            if newCount > limit {
                return n
            }
            if maxCount < newCount {
                maxKey = n
                maxCount = newCount
            }
        }
        
        return maxKey!
    }
}
