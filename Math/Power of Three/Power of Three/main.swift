//
//  main.swift
//  Power of Three
//
//  Created by Andrey Ermoshin on 05/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

class Solution {
    // 3 * 3 * 3 * .... and not x^3
    func isPowerOfThree(_ n: Int) -> Bool {
        var nn = n
        if nn <= 0 {
            return false
        }
        else {
            while nn % 3 == 0 {
                nn /= 3
            }
            return nn == 1
        }
    }
}

let solver = Solution()
print("\(-3) is power of three \(solver.isPowerOfThree(-3))") // false -1 * 3 contains not only 3 number
print("\(8) is power of three \(solver.isPowerOfThree(8))")
print("\(9) is power of three \(solver.isPowerOfThree(9))")
print("\(16) is power of three \(solver.isPowerOfThree(16))")

