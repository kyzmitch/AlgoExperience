//
//  main.swift
//  Sum 3
//
//  Created by admin on 15/03/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

// signed numbers
// number of i, j, k where
// a[i] + b[j] + c[k] = x
// without additional space usage
// try O(n^2)
// arrays could have different lengths


class Solution {
    func verySlowCombinationsNumber(_ a: inout [Int], _ b: inout [Int], _ c: inout [Int], _ sum: Int) -> UInt {
        let an = a.count
        let bn = b.count
        let cn = c.count
        
        var n: UInt = 0
        
        for i in 0..<an {
            for j in 0..<bn {
                let partlySum = a[i] + b[j]
                for k in 0..<cn {
                    if sum == partlySum + c[k] {
                        // linear search
                        // O(a*b*c) almost O(n^3)
                        n += 1
                    }
                }
            }
        }
        
        return n
    }
    
    private func binarySearch(_ nums: [Int], _ x: Int) -> Int? {
        // returns index
        // let's say that Swift Array method is a binary search inside
        return nums.index(of: x)
    }
    
    private func numberOfSameValueNearby(_ nums: [Int], _ value: Int, _ valueIndex: Int) -> UInt {
        let n = nums.count
        
        var leftIndex = valueIndex - 1
        var canCheckLeft = leftIndex >= 0
        var rightIndex = valueIndex + 1
        var canCheckRight = rightIndex < n
        
        var result: UInt = 0
        
        while canCheckLeft || canCheckRight {
            var newValues: UInt = 0
            if canCheckLeft {
                if nums[leftIndex] == value {
                    newValues += 1
                }
                leftIndex -= 1
                canCheckLeft = leftIndex >= 0
            }
            if canCheckRight {
                if nums[rightIndex] == value {
                    newValues += 1
                }
                rightIndex += 1
                canCheckRight = rightIndex < n
            }
            result += newValues
        }
        
        return result
    }
    
    func slowCombinationsNumber(_ a: inout [Int], _ b: inout [Int], _ c: inout [Int], _ sum: Int) -> UInt {
        let an = a.count
        let bn = b.count
        
        var n: UInt = 0
        
        c.sort() // O(n * log(n))
        
        for i in 0..<an {
            for j in 0..<bn {
                let partlySum = a[i] + b[j]
                let valueToSearch = sum - partlySum
                if let found = binarySearch(c, valueToSearch) {
                    n += 1
                    // TODO: what if the C array contains duplicates
                    // so, binary search will return just first found index
                    // but number of combinations in that case
                    // will be wrong
                    // AS a solution possibly need to do
                    // additonal linear search from the left and from the right
                    // of returned index and compare values on these indexes
                    // with initially found value
                    // This is how we can get correct number of combinations
                    // for given i and j
                    n += numberOfSameValueNearby(c, valueToSearch, found)
                }
            }
        }
        
        return n
    }
}

let solver = Solution()
var a1 = [0]
var b1 = [1, 10, -1, 2]
var c1 = [3, 5, 3]

print("first \(solver.verySlowCombinationsNumber(&a1, &b1, &c1, 4))")
print("first \(solver.slowCombinationsNumber(&a1, &b1, &c1, 4))")
