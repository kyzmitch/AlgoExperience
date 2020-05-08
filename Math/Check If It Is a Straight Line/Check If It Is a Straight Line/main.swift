//
//  main.swift
//  Check If It Is a Straight Line
//
//  Created by Andrei Ermoshin on 5/8/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    func checkStraightLine(_ coordinates: [[Int]]) -> Bool {
        let n = coordinates.count
        guard n > 2 else {
            return true
        }
        
        // line equation by two points
        // should be linear equation like f(x) = y = x + a, where a >= 0 || a < 0
        let p1 = coordinates[0]
        let x1 = p1[0]
        let y1 = p1[1]
        let p2 = coordinates[1]
        let x2 = p2[0]
        let y2 = p2[1]
        guard x1 != x2 else {
            // vertical line like x = b
            for i in 2..<n {
                if coordinates[i][0] != x1 {
                    return false
                }
            }
            return true
        }
        
        // y = m*x + b
        let m = (y1 - y2)/(x1 - x2)
        let b = y1 - m * x1
        
        for i in 2..<n {
            if coordinates[i][1] != m * coordinates[i][0] + b {
                return false
            }
        }
        return true
    }
}

let solver = Solution()
let in1 = [[-7,-3],[-7,-1],[-2,-2],[0,-8],[2,-2],[5,-6],[5,-5],[1,7]]
assert(solver.checkStraightLine(in1) == false)
