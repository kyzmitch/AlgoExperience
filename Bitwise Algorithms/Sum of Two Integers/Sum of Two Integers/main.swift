//
//  main.swift
//  Sum of Two Integers
//
//  Created by Andrey Ermoshin on 16/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// Calculate the sum of two integers a and b, but you are not allowed to use the operator + and -.


class Solution {
    func getSum(_ a: Int, _ b: Int) -> Int {
        let size = Int.bitWidth
        var pointer = 1
        var rest = 0
        var result = 0
        for _ in (0..<size) {
            let sum = (a & pointer) & (b & pointer)
            let diff = (a & pointer) ^ (b & pointer)
            if diff != 0 {
                // 0 ^ 1 or 1 ^ 0
                if rest != 0 {
                    // 1 & 1 = 0 and rest = 1
                    // result |= 0
                    rest = pointer << 1
                }
                else {
                    result |= diff
                    rest = 0
                }
            }
            else if sum != 0 {
                // 1 & 1
                if rest != 0 {
                    result |= sum
                    rest = pointer << 1
                }
                else {
                    // result |= 0
                    rest = pointer << 1
                }
            }
            else {
                // 0 & 0
                result |= rest
                rest = 0
            }
            pointer = pointer << 1
        }
        return result
    }
}

let solver = Solution()
print("Sum = \(solver.getSum(20, 30))") // 50
print("Sum = \(solver.getSum(2, 15))") // 17
print("Sum = \(solver.getSum(10, 2))") // 12
print("Sum = \(solver.getSum(1, 2))") // 3
