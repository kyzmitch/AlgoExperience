//
//  main.swift
//  Bubble sort
//
//  Created by Andrey Ermoshin on 07/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation


// https://www.geeksforgeeks.org/bubble-sort/

extension Array where Element: Comparable {
    mutating func bubbleSort() {
        let n = count
        var wasSwap = false
        for _ in 0..<n {
            for j in 1..<n {
                if self[j] < self[j - 1] {
                    wasSwap = true
                    self.swapAt(j, j - 1)
                }
            }
            if !wasSwap {
                return
            }
            else {
                wasSwap = false
            }
        }
    }
}

var input = [64,34,25,12,22,11,90]
input.bubbleSort()
print("\(input)")
