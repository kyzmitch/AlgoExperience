//
//  main.swift
//  Unique Paths 2
//
//  Created by Andrei Ermoshin on 25/10/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

import Foundation

/*
 A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).

 The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid (marked 'Finish' in the diagram below).

 Now consider if some obstacles are added to the grids. How many unique paths would there be?


 An obstacle and empty space is marked as 1 and 0 respectively in the grid.

 Note: m and n will be at most 100.
 */

class Solution {
    func bottomUpUniquePaths(_ obstacleGrid: [[Int]]) -> Int {
        // bottom-up solution
        let w = obstacleGrid.count
        guard w > 0 else {
            return 0
        }
        let h = obstacleGrid[0].count
        guard h > 0 else {
            return 0
        }

        if obstacleGrid[w - 1][h - 1] == 1 || obstacleGrid[0][0] == 1 {
            return 0
        }
        var obstacleGrid = obstacleGrid

        for i in stride(from: w - 1, to: -1, by: -1) {
            for j in stride(from: h - 1, to: -1, by: -1) {
                let v = obstacleGrid[i][j]
                if v == 1 {
                    obstacleGrid[i][j] = 0
                } else if i == w - 1 && j == h - 1 {
                    obstacleGrid[i][j] = 1
                }
                else if i == w - 1 {
                    // + 1 because bottom-up method
                    obstacleGrid[i][j] = obstacleGrid[i][j + 1]
                } else if j == h - 1 {
                     obstacleGrid[i][j] = obstacleGrid[i + 1][j]
                } else {
                    obstacleGrid[i][j] = obstacleGrid[i + 1][j] + obstacleGrid[i][j + 1]
                }
            }
        }

        return obstacleGrid[0][0]
    }

    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        // top-down solution
        let w = obstacleGrid.count
        guard w > 0 else {
            return 0
        }
        let h = obstacleGrid[0].count
        guard h > 0 else {
            return 0
        }

        // border case
        if obstacleGrid[0][0] == 1 {
            return 0
        }

        var obstacleGrid = obstacleGrid
        // very first cell means at least 1 possible path
        // so, remembering that
        obstacleGrid[0][0] = 1

        // if we checked manually the start point
        // then we need to check first row and first column
        for x in 1..<w {
            // first row can be reached only from left to right
            if obstacleGrid[x][0] == 0 && obstacleGrid[x - 1][0] == 1 {
                obstacleGrid[x][0] = 1
            } else {
                obstacleGrid[x][0] = 0
            }
        }
        for y in 1..<h {
            // first column can be reached only from up to bottom
            if obstacleGrid[0][y] == 0 && obstacleGrid[0][y - 1] == 1 {
                obstacleGrid[0][y] = 1
            } else {
                obstacleGrid[0][y] = 0
            }
        }

        for i in 1..<w {
            for j in 1..<h {
                let value = obstacleGrid[i][j]
                if value == 1 {
                    obstacleGrid[i][j] = 0
                } else {
                    obstacleGrid[i][j] = obstacleGrid[i - 1][j] + obstacleGrid[i][j - 1]
                }
            }
        }

        return obstacleGrid[w - 1][h - 1]
    }
}

let s = Solution()
let i1 = [
    [0,0,0],
    [0,1,0],
    [0,0,0]
]
print("ways \(s.bottomUpUniquePaths(i1))") // 2
print("ways \(s.bottomUpUniquePaths([[0, 1]]))") // 0
