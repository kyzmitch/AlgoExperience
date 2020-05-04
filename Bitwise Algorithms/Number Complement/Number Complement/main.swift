//
//  main.swift
//  Number Complement
//
//  Created by Andrei Ermoshin on 5/4/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    func findComplement(_ num: Int32) -> Int32 {
        var r: Int32 = 0
        var l = num.bitWidth
        var max: Int32 = 0
        for i in 0..<l {
            max = 1 << i
            if num < max {
                l = i
                break
            }
        }
        
        var v: Int32 = 0
        for i in 0..<l {
            v = num & 1 << i
            r |= v > 0 ? 0 : (1 << i)
        }
        return r
    }
}

let solver = Solution()
assert(solver.findComplement(1) == 0)
let result2 = solver.findComplement(5)
assert(result2 == 2)
