//
//  main.swift
//  First Bad Version
//
//  Created by Andrei Ermoshin on 5/1/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

/**
 * The knows API is defined in the parent class VersionControl.
 *     func isBadVersion(_ version: Int) -> Bool{}
 */

func isBadVersion(_ version: Int) -> Bool{
    return version >= 3 ? true : false
}

class Solution  {
    func firstBadVersion(_ n: Int) -> Int {
        if n == 1 {
            return 1
        }
        var l = 1
        var r = n
        var lowestBad = n
        var m: Int = l + (r - l)/2
        while l < r {
            if isBadVersion(m) {
                lowestBad = m
                r = m
            } else {
                if l == m {
                    break
                }
                l = m
            }
            let m2: Int = l + (r - l)/2
            m = m2
        }
        return lowestBad
    }
}
