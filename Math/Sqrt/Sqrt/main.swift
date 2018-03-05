//
//  main.swift
//  Sqrt
//
//  Created by Andrey Ermoshin on 05/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

class Solution {
    func mySqrt(_ x: Int) -> Int {
        if x <= 0 {
            // not valid case if x < 0
            // we're not handling complex numbers
            return 0
        }
        
        var left = 1
        var right = x
        var sqrt = (left + right) / 2
        var qValue = sqrt * sqrt
        
        while left < right {
            if qValue > x {
                if right == sqrt {
                    break
                }
                right = sqrt
            }
            else if qValue < x {
                if left == sqrt {
                    break
                }
                left = sqrt
            }
            else {
                return sqrt
            }
            sqrt = (left + right) / 2
            qValue = sqrt * sqrt
        }
        
        return sqrt
    }
}

let solver = Solution()
print("sqrt (\(9)) = \(solver.mySqrt(9))")
print("sqrt (\(4)) = \(solver.mySqrt(4))")
print("sqrt (\(1)) = \(solver.mySqrt(1))")
print("sqrt (\(16)) = \(solver.mySqrt(16))")
print("sqrt (\(3)) = \(solver.mySqrt(3))") // 1.73 = 1
print("sqrt (\(8)) = \(solver.mySqrt(8))") // 2.8 = 2
