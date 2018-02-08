//
//  main.swift
//  FizzBuzz
//
//  Created by Andrey Ermoshin on 08/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// Write a program that outputs the string representation
// of numbers from 1 to n.
//
// But for multiples of three it should output “Fizz”
// instead of the number and for the multiples of five output “Buzz”.
// For numbers which are multiples of both three and five
// output “FizzBuzz”.

class Solution {
    func fizzBuzz(_ n: Int) -> [String] {
        if n < 1 {
            return [String]()
        }
        var result = [String]()
        for i in 1...n {
            let by3 = (i % 3 == 0)
            let by5 = (i % 5 == 0)
            if by3 && !by5 {
                result.append("Fizz")
            }
            else if by5 && !by3 {
                result.append("Buzz")
            }
            else if by3 && by5 {
                result.append("FizzBuzz")
            }
            else {
                result.append("\(i)")
            }
        }
        return result
    }
}

// 27.66
let solver = Solution()
print("1) \n\(solver.fizzBuzz(15))")
