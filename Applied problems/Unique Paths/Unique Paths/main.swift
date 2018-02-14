//
//  main.swift
//  Unique Paths
//
//  Created by Andrey Ermoshin on 14/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// A robot is located at the top-left corner of a m x n grid
// The robot can only move either down or right at any point in time.
// Example:
// height 3 x width 7
// m - height, n - width
// m and n <= 100

class Solution {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        if m == 0 || n == 0 {
            return 0
        }
        if m == 1 || n == 1 {
            return 1
        }
        // cache to stores paths count for specific
        // rectangles, but values will be mirrored actually
        // so cache[i, j] = cache[j, i], i != j
        var cache = Array<Array<Int>>(repeatElement(Array<Int>(repeatElement(1, count: m)), count: n))
        // x, y so cache[x][y] - width * height
        
        for x in (1..<n) {
            for y in (1..<m) {
                
                let pathCount = cache[x - 1][y] + cache[x][y - 1]
                cache[x][y] = pathCount
                // set mirrored as well
                if x != y && y < n && x < m {
                    cache[y][x] = pathCount
                }
            }
        }
        
        return cache[n - 1][m - 1]
    }
}

let solver = Solution()
print("paths count for \(1)*\(1) is \(solver.uniquePaths(1, 1))") // 1
print("paths count for \(1)*\(2) is \(solver.uniquePaths(1, 2))") // 1
print("paths count for \(2)*\(1) is \(solver.uniquePaths(2, 1))") // 1
print("paths count for \(2)*\(2) is \(solver.uniquePaths(2, 2))") // 2
print("paths count for \(2)*\(2) is \(solver.uniquePaths(2, 2))") // 2
print("paths count for \(2)*\(3) is \(solver.uniquePaths(2, 3))") // 3 - only down or right moves, can't move up
print("paths count for \(3)*\(2) is \(solver.uniquePaths(3, 2))") // 3 - mirrored version is also the same
print("paths count for \(3)*\(3) is \(solver.uniquePaths(3, 3))") // 6
print("paths count for \(3)*\(4) is \(solver.uniquePaths(3, 4))") // 10
