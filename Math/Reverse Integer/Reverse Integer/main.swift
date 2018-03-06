//
//  main.swift
//  Reverse Integer
//
//  Created by Andrey Ermoshin on 06/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// Given a 32-bit signed integer, reverse digits of an integer.
//Example 1:
//
//Input: 123
//Output:  321

//Example 2:
//
//Input: -123
//Output: -321

//Example 3:
//
//Input: 120
//Output: 21


class Solution {
    func reverse(_ x: Int) -> Int {
        if x == 0 {
            return 0
        }
        
        let absX = abs(x)
        var integer = absX / 10
        var digit = absX % 10
        var result = digit // digit * 1
        
        while integer != 0 {
            digit = integer % 10
            result = result * 10 + digit
            if result > Int32.max {
                return 0
            }
            integer /= 10
        }
        
        result = x > 0 ? result : -result
        return Int(result)
    }
}

let solver = Solution()
print("reverse of 1534236469 is \(solver.reverse(1534236469))") // 0
print("reverse of 123 is \(solver.reverse(123))") // 321
print("reverse of -123 is \(solver.reverse(-123))") // -321
print("reverse of 120 is \(solver.reverse(120))") // 21
