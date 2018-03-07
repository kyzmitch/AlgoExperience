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
            let l = left + 1
            if l != right  {
                let minimumIndex = self.indexOfFirstMinimumInNotSorted(l, right)
                self.swapAt(left, minimumIndex)
            }
            
            left = l
        }
    }
    
    func indexOfFirstMinimumInNotSorted(_ left: Int, _ right: Int) -> Int {
        var minimum = self[left]
        var resultIndex = left
        for i in (left+1)...right {
            let current = self[i]
            if current < minimum {
                minimum = current
                resultIndex = i
            }
        }
        return resultIndex
    }
}

var input = [64,25,12,22,11]
input.selectionSort()
print("\(input)")
