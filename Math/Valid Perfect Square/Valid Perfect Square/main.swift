//
//  main.swift
//  Valid Perfect Square
//
//  Created by Andrei Ermoshin on 5/9/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    static var primeSquars = Array<Int>()
    
    func isPerfectSquare(_ num: Int) -> Bool {
        // A perfect square is a number that can be expressed as the product of two equal integers.
        // 1. using prime factors like 36 = 2 * 18 = 2 * 2 * 9 = 2 * 2 * 3 * 3
        // = 2 * 3 * 2 * 3 =  6 * 6
        // prime factor/number - can be divided only by 1 or by itself
        // 2. geometry equations? doesn't work
        // sqr = x * x
        // triangle sqr = x * x * 0.5
        
        if Solution.primeSquars.isEmpty {
            Solution.primeSquars.append(0)
            //Solution.primeSquars.append(1) // 1 * 1
            // Solution.primeSquars.append(4) // 2 * 2
        }
        
        var j = 1
        
        // Optimization for calls for different numbers
        if let lastPerfectSquare = Solution.primeSquars.last {
            if lastPerfectSquare > num {
                // start checks from last element
                // towards first one
                // it is sorted array, so, binary search should be best
                var l = 0
                var r = Solution.primeSquars.count - 1
                
                while l <= r {
                    let m = l + (r - l)/2
                    let value = Solution.primeSquars[m]
                    if value == num {
                        return true
                    }
                    if value < num {
                        l = m + 1
                    } else if value > num {
                        r = m - 1
                    }
                }
                return false
            } else if lastPerfectSquare < num {
                // improve j index to skip already calculated prime numbers
                j = Solution.primeSquars.count
            } else {
                return true
            }
        }
        
        var jj = j * j
        while jj < num {
            j += 1
            jj = j * j
            Solution.primeSquars.append(jj)
        }
        return jj == num
    }
}

let solver = Solution()
let o1 = solver.isPerfectSquare(1)
print("finish 1 \(o1)")
