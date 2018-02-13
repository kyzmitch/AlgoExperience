//
//  main.swift
//  Minimum Moves to Equal Array Elements
//
//  Created by admin on 13/02/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

// Given a non-empty integer array of size n, find the minimum number of moves
// required to make all array elements equal, where a move is incrementing n - 1 elements by 1.

// Input:
// [1,2,3]

// Output:
// 3

// Explanation:
// Only three moves are needed (remember each move increments two elements):

// [1,2,3]  =>  [2,3,3]  =>  [3,4,3]  =>  [4,4,4]

class Solution {
    typealias Element = (index: Int, maximum: Int)
    
    func slowMinMoves(_ nums: [Int]) -> Int {
        
        var array = nums
        let numsCount = array.count
        var iterationsNumber: Int = 0
        while true {
            var maximum: Element = (Int.min, Int.min)
            var minimum: Int = Int.max
            for (i, x) in array.enumerated() {
                if maximum.maximum < x {
                    maximum = (i, x)
                }
                if minimum > x {
                    minimum = x
                }
            }
            if maximum.maximum == minimum {
                break
            }
            
            for i in (0..<numsCount) {
                if i != maximum.index {
                    array[i] += 1
                }
            }
            iterationsNumber += 1
        }
        
        return iterationsNumber
    }
    
    func freezedMinMoves(_ nums: [Int]) -> Int {
        
        var array = nums
        let numsCount = array.count
        var iterationsNumber: Int = 0
        while true {
            var maximum: Element = (Int.min, Int.min)
            var minimum: Int = Int.max
            for i in (0..<numsCount) {
                let x = array[i]
                if maximum.maximum < x {
                    maximum = (i, x)
                }
                if minimum > x {
                    minimum = x
                }
                array[i] += 1
            }
            if maximum.maximum == minimum {
                break
            }
            array[maximum.index] -= 1
            iterationsNumber += 1
        }
        
        return iterationsNumber
    }
    
    func minMoves(_ nums: [Int]) -> Int {
        
        // x * numsCount = sum + movesCount * (numsCount - 1)
        // x = min + movesCount
        // so, it is system of linear equations
        // movesCount = sum - min * numsCount
        
        let numsCount = nums.count
        if numsCount < 2 {
            return 0
        }
        
        var minimum = Int.max
        var sum = 0
        for i in (0..<numsCount) {
            let x = nums[i]
            sum += x
            if minimum > x {
                minimum = x
            }
        }
        
        return sum - minimum * numsCount
    }
}

let solver = Solution()
let input1 = [1,2,3]
print("Minimum number of moves - \(solver.minMoves(input1))")
let input2 = [0,2,3]
print("Minimum number of moves - \(solver.minMoves(input2))")
