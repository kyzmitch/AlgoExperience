//
//  ArrayExtension.swift
//  ArrayAlgorithms
//
//  Created by admin on 11/01/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

extension Array where Element: Comparable & Hashable {
    func mergingIsSubset(of array: [Element]) -> Bool {
        // https://www.geeksforgeeks.org/find-whether-an-array-is-subset-of-another-array-set-1/
        // Method 3 (Use Sorting and Merging )
        
        if array.count < self.count {
            return false
        }
        
        let a = array.sorted()
        let b = self.sorted()
        
        // merge both arrays
        var ai = 0
        var bj = 0
        while ai < a.count && bj < b.count {
            let aValue = a[ai]
            let bValue = b[bj]
            if aValue == bValue {
                // [1, 3, 5] vs [1, 3]
                ai += 1
                bj += 1
            }
            else if aValue < bValue {
                // [-10, 1, 3] vs [1, 3]
                ai += 1
            }
            else {
                // [2, 3, 5] vs [1, 3]
                return false
            }
        }
        
        return (bj < b.count) ? false : true
    }
    
    func hashingIsSubset(of array: Array<Element>) -> Bool {
        if array.count < self.count {
            return false
        }
        var arraySet = Set<Element>()
        for itemA in array {
            arraySet.insert(itemA)
        }
        
        for itemB in self {
            if !arraySet.contains(itemB) {
                return false
            }
        }
        
        return true
    }
}
