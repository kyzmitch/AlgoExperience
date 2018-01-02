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
let evenSorted = evenArray.mergeSorted()
print("Even amount test - merge sort: \(evenSorted)")

// odd amount test
let oddArray = [50, 11, 40, 3, 9, 3, 11, 1000, 49]
let oddSorted = oddArray.mergeSorted()
print("Odd amount test - merge sort: \(oddSorted)")

let stringsArray = ["AB", "ZB", "A", "M", "B", "F", "A"]
let sortedStrings = stringsArray.mergeSorted()
print("Sorted strings: \(sortedStrings)")


var mergeSortInPlace = oddArray
print("Array before in place sort: \(mergeSortInPlace)")
mergeSortInPlace.mergeSort()
print("Merge sort in place: \(mergeSortInPlace)")
