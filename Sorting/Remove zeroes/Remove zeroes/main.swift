//
//  main.swift
//  Remove zeroes
//
//  Created by admin on 15/03/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

func removeZeroes(_ nums: inout [Int]) {
    let n = nums.count
    var zeroesNumber = 0
    var j = 0
    
    for i in 0..<n {
        let current = nums[i]
        if current == 0 {
            zeroesNumber += 1
        }
        else {
            nums[j] = current
            j += 1
        }
    }
    
    nums.removeLast(zeroesNumber)
}

var input1 = [0,1,0,4,10]
print("#1 input \(input1)")
removeZeroes(&input1)
print("#1 output \(input1)")

var input2 = [0,0,0,2,0]
print("#2 input \(input2)")
removeZeroes(&input2)
print("#2 output \(input2)")
