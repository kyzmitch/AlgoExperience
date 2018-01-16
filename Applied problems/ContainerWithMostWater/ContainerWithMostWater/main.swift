//
//  main.swift
//  ContainerWithMostWater
//
//  Created by admin on 16/01/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

func maxArea(_ height: [Int]) -> Int {
    
    var begin = 0
    var end = height.count - 1
    var total = 0
    while begin < end {
        let minHeight = Swift.min(height[begin], height[end])
        let area = (end - begin) * minHeight
        total = Swift.max(total, area)
        if height[begin] > height[end] {
            end -= 1
        } else {
            begin += 1
        }
    }
    return total
}

let pointsHeights = [1, 4, 3, 4, 7]
print("max area is \(maxArea(pointsHeights))")
