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

extension Array {
    mutating func mergeSort() {
        if count < 2 {
            return
        }
        Array.mergeSort(array: self, leftBorder: 0, rightBorder: count - 1)
    }
    
    static private func mergeSort(array: Array, leftBorder l: Int, rightBorder r: Int) {
        
        // NOTE: array argument always copied, but copied on write,
        // so it should be fast and almost as passing by reference
        // and actually Array structure inside operates with references for that purpose
        
        if r - l < 2 {
            return
        }
        let middle = l + (r - l)/2
        mergeSort(array: array, leftBorder: l, rightBorder: middle)
        mergeSort(array: array, leftBorder: middle + 1, rightBorder: r)
        merge(array: array, leftBorder: l, middle: middle, rightBorder: r)
    }
    
    static private func merge(array: Array, leftBorder l: Int, middle m: Int, rightBorder r: Int) {
        
    }
}

