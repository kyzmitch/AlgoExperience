//
//  main.swift
//  Pow function
//
//  Created by Andrey Ermoshin on 05/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

class Solution {
    func myPow(_ x: Double, _ n: Int) -> Double {
        // Returns base raised to the power exponent
        // x - base and n - exponent
        let delta = 0.0000001
        if abs(x - 0.0) < delta {
            return 0
        }
        else if abs(abs(x) - 1.0) < delta {
            return n % 2 == 0 ? 1 : -1
        }
        
        var xx: Double
        var nn: Int
        if n < 0 {
            xx = 1 / x
            nn = -(n + 1)
        }
        else if n > 0 {
            xx = x
            nn = n - 1
        }
        else {
            return 1
        }
        
        if nn & 1 == 1 {
            // this is odd exponent number
            xx = (n > 0) ? xx * x : xx / x
            nn -= 1
        }
        
        while nn > 0 {
            xx = (n > 0) ? xx * x * x : xx / (x * x)
            nn -= 2
        }
        return xx
    }
}

let solver = Solution()
print("0.44894 ^ -5 = \(solver.myPow(0.44894, -5))") // 54.83508
print("34.00515 ^ -3 = \(solver.myPow(34.00515, -3))") // 3e-05


print("2 ^ -4 = \(solver.myPow(2, -4))") // 1/16 = 0.0625
print("2 ^ 3 = \(solver.myPow(2, 3))") // 8
print("2 ^ 4 = \(solver.myPow(2, 4))") // 16
print("7 ^ 3 = \(solver.myPow(7, 3))") // 343
print("2 ^ 10 = \(solver.myPow(2, 10))") // 1024
print("2.1 ^ 3 = \(solver.myPow(2.1, 3))") // 9.261
print("4.73 ^ 12 = \(solver.myPow(4.73, 12))") // 125410439.217423
