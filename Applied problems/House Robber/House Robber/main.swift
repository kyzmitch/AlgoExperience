//
//  main.swift
//  House Robber
//
//  Created by Andrey Ermoshin on 10/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// Given a list of non-negative integers representing the
// amount of money of each house, determine the maximum
// amount of money you can rob tonight without alerting the police.

// security system connected and it will automatically contact
// the police if two adjacent houses were broken into on
// the same night.

class Solution {
    func rob(_ nums: [Int]) -> Int {
        var money1 = 0
        var money2 = 0
        
        for (i, x) in nums.enumerated() {
            if i % 2 == 0 {
                money1 = max(money1 + x, money2)
            }
            else {
                money2 = max(money2 + x, money1)
            }
        }
        
        // two variables (wallets) were used for memorization
        // so, it is Tabulation Method – Bottom Up
        return max(money1, money2)
    }
}


let solver = Solution()
let input1 = [2,1,1,2]
print("Can rob: \(solver.rob(input1)) money without been noticed by police")


