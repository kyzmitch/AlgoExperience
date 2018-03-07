//
//  main.swift
//  Insertion sort
//
//  Created by Andrey Ermoshin on 07/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// https://www.geeksforgeeks.org/insertion-sort/


extension Array where Element: Comparable {
    mutating func insertionSort() {
        let n = count
        if n < 2 {
            return
        }
        
        for i in 1..<n {
            let current = self[i]
            var insertionIndex = i - 1
            while insertionIndex >= 0 && current < self[insertionIndex] {
                // shifting elements to free slot for element
                // which we want to insert in sorted subarray
                self[insertionIndex + 1] = self[insertionIndex]
                insertionIndex -= 1
            }
            if insertionIndex + 1 != i {
                self[insertionIndex + 1] = current
            }
        }
    }
}

var input = [12,11,13,5,6]
input.insertionSort()
print("\(input)")
