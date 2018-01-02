//
//  main.swift
//  MergeSort
//
//  Created by admin on 31/12/2017.
//  Copyright © 2017 kyzmitch. All rights reserved.
//

import Foundation

// even amount of elements in the array test
let evenArray = [38, 27, 27, 3]
print("Original even array: \(evenArray)")
let evenSorted = evenArray.mergeSort()
print("Even amount test - merge sort: \(evenSorted)")

// odd amount test
let oddArray = [50, 11, 40, 3, 9, 3, 11, 1000, 49]
let oddSorted = oddArray.mergeSort()
print("Odd amount test - merge sort: \(oddSorted)")

let stringsArray = ["AB", "ZB", "A", "M", "B", "F", "A"]
let sortedStrings = stringsArray.mergeSort()
print("Sorted strings: \(sortedStrings)")
