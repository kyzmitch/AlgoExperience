//
//  main.swift
//  Selection sort
//
//  Created by Andrey Ermoshin on 07/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// https://www.geeksforgeeks.org/selection-sort/

extension Array where Element: Comparable {
    mutating func selectionSort() {
        var left = 0
        let right = count - 1
        while left < right {
            let minimumIndex = self.indexOfFirstMinimumInNotSorted(left, right)
            if left != minimumIndex {
                self.swapAt(left, minimumIndex)
            }
            
            left += 1
        }
    }
    
    func indexOfFirstMinimumInNotSorted(_ left: Int, _ right: Int) -> Int {
        if left == right {
            return left
        }
        var minimum = self[left]
        var resultIndex = left
        for i in left...right {
            let current = self[i]
            if current < minimum {
                minimum = current
                resultIndex = i
            }
        }
        return resultIndex
    }
}

var input1 = [5,25,12,22,11]
input1.selectionSort()
print("\(input1)")

var input = [64,25,12,22,11]
input.selectionSort()
print("\(input)")
