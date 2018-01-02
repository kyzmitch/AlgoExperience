//
//  ArrayMergeSort.swift
//  MergeSort
//
//  Created by admin on 31/12/2017.
//  Copyright © 2017 kyzmitch. All rights reserved.
//

import Foundation

// https://www.geeksforgeeks.org/merge-sort/

// Merge Sort algorithm of sorting is more useful for linked lists. )(n*log(n))
// Requires temporary array with the same length (n) , so, it is not in-place sorting

/*
 MergeSort(arr[], l,  r)
 If r > l
 1. Find the middle point to divide the array into two halves:
 middle m = (l+r)/2
 2. Call mergeSort for first half:
 Call mergeSort(arr, l, m)
 3. Call mergeSort for second half:
 Call mergeSort(arr, m+1, r)
 4. Merge the two halves sorted in step 2 and 3:
 Call merge(arr, l, m, r)
 
 */

extension Array where Element: Comparable {
    func mergeSort() -> Array {
        if count < 2 {
            return self
        }
        var sortedArray = self
        mergeSort(leftBorder: 0, rightBorder: count - 1, resultArray: &sortedArray)
        return sortedArray
    }
    
    private func mergeSort(leftBorder l: Int, rightBorder r: Int, resultArray: inout Array) {
        
        // NOTE: array argument always copied, but copied on write,
        // so it should be fast and almost as passing by reference
        // and actually Array structure inside operates with references for that purpose
        
        if r - l < 1 {
            return
        }
        let middle = l + (r - l)/2
        mergeSort(leftBorder: l, rightBorder: middle, resultArray: &resultArray)
        mergeSort(leftBorder: middle + 1, rightBorder: r, resultArray: &resultArray)
        merge(leftBorder: l, middle: middle, rightBorder: r, resultArray: &resultArray)
    }
    
    private func merge(leftBorder l: Int, middle m: Int, rightBorder r: Int, resultArray: inout Array) {
        // https://medium.com/@mimicatcodes/array-and-arrayslice-in-swift-3-aaa6841d3119
        // creating ArraySlice below
        let leftSlice = resultArray[l...m]
        let rightSlice = resultArray[(m+1)...r]
        
        var i = l
        var j = m + 1
        var k = l
        let leftLastIndex = i + leftSlice.count
        let rightLastIndex = j + rightSlice.count
        while i < leftLastIndex && j < rightLastIndex {
            
            let lValue = leftSlice[i]
            let rValue = rightSlice[j]
            if lValue < rValue {
                resultArray[k] = lValue
                i += 1
            }
            else if rValue < lValue {
                resultArray[k] = rValue
                j += 1
            }
            else {
                resultArray[k] = lValue
                i += 1
            }
            k += 1
        }
        
        // copy remaning elements if one of array slices already iterated completely
        if i < leftLastIndex {
            let leftRemaining = leftSlice.suffix(from: i)
            resultArray.replaceSubrange(k..<(k + leftRemaining.count), with: leftRemaining)
            k += leftRemaining.count
        }
        
        if j < rightLastIndex {
            let rightRemaining = rightSlice.suffix(from: j)
            resultArray.replaceSubrange(k..<(k + rightRemaining.count), with: rightRemaining)
        }
    }
}

