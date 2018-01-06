//
//  ArrayQuickSort.swift
//  QuickSort
//
//  Created by admin on 06/01/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

extension Array where Element: Comparable {
    enum PivotSelection: UInt8 {
        case last
        case randomized
    }
    
    typealias PartitioningMethod = (_ arr: inout [Array.Element], _ start: Int, _ end: Int) -> Array.Index
    
    mutating func quickSort(pivotSelection: PivotSelection = .last) {
        // in-place sort
        var method: PartitioningMethod
        switch pivotSelection {
        case .last:
            method = Array.partitioningUsingLastAsPivot
        case .randomized:
            method = Array.partitioningUsingRandomIndex
        }
        Array.quickSort(array: &self, startIx: 0, endIx: count - 1, partitioningFunction: method)
    }
    
    private static func quickSort(array: inout [Array.Element], startIx: Int, endIx: Int, partitioningFunction: PartitioningMethod) {
        // recursion implementation which can lead to stack overflow
        if startIx >= endIx {
            return
        }
        
        let index = partitioningFunction(&array, startIx, endIx)
        Array.quickSort(array: &array, startIx: startIx, endIx: index - 1, partitioningFunction: partitioningFunction)
        Array.quickSort(array: &array, startIx: index + 1, endIx: endIx, partitioningFunction: partitioningFunction)
    }
    
    private static func partitioningUsingLastAsPivot(arr: inout [Element], start: Int, end: Int) -> Array.Index {
        var i = start - 1
        let pivot = arr[end]
        
        for j in stride(from: start, to: end + 1, by: 1) {
            if arr[j] <= pivot {
                i += 1
                Array.swap(arr: &arr, l: i, r: j)
            }
        }
        return i
    }
    
    private static func partitioningUsingRandomIndex(arr: inout [Element], start: Int, end: Int) -> Array.Index {
        return 0
    }
    
    private static func swap(arr: inout [Element], l: Int, r: Int) {
        let temp = arr[l]
        arr[l] = arr[r]
        arr[r] = temp
    }
}
