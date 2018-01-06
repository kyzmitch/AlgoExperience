//
//  main.swift
//  QuickSort
//
//  Created by admin on 05/01/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

// even amount of elements in the array test
var evenArray = [38, 27, 27, 3]
print("Original even array: \(evenArray)")
evenArray.quickSort()
print("Even amount test - quick sort: \(evenArray)")

// odd amount test
var oddArray = [50, 11, 40, 3, 9, 3, 11, 1000, 49]
oddArray.quickSort()
print("Odd amount test - quick sort: \(oddArray)")

var stringsArray = ["AB", "ZB", "A", "M", "B", "F", "A"]
stringsArray.quickSort()
print("Sorted strings: \(stringsArray)")

