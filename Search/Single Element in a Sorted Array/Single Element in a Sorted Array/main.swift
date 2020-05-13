//
//  main.swift
//  Single Element in a Sorted Array
//
//  Created by Andrei Ermoshin on 5/13/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    func singleNonDuplicate(_ nums: [Int]) -> Int {
        let length = nums.count
        switch length {
        case 0:
            return -1
        case 1:
            // not valid case
            return nums[0]
        case 2:
            // not valid case, it is guarantied to be odd count
            return nums[0]
        default:
            // guaranty that at least 3 elements are in array
            // to check neighbour values
            break
        }
        var r = length - 1
        var l = 0
        var m = (r - l)/2
        var mValue = -1
        var ml = -1
        var mr = -1
        var elementsCount = -1
        while l < r && m != 0 && m != length {
            mValue = nums[m]
            ml = nums[m-1]
            mr = nums[m+1]
            // can't be equal to both according to task
            if ml == mValue && l < m {
                // checking left side: from l till m - 1 indexes
                // if left side contains one repeating element for sure
                // it means that for correctness it should also
                // contains k pairs of other elements
                // assert false: should be k + 1 elements `odd` amount of elements
                // assert true: if it's `even` - it means that number from left side of m index
                elementsCount = m - l + 1
                if elementsCount % 2 != 0 {
                        // expected value, it means that searching element
                        // from right
                        r = m
                    } else {
                        // not expected, means that element from left
                        l = m + 1
                    }
            } else if mValue == mr && m < r {
                // should be k + 1 element for correct case without searching number
                // assert false: k + 1 - odd
                // assert true: even
                elementsCount = r - m + 1
                if elementsCount % 2 != 0 {
                    // wrong branch, element should be from the left
                    l = m
                } else {
                    r = m - 1
                }
            } else {
                if ml == mValue {
                    l = m + 1
                } else if mValue == mr {
                    r = m - 1
                } else {
                    // mValue != ml && mvalue != mr
                    return mValue
                }
            }
            m = l + (r - l + 1)/2
        }
        return nums[m]
    }
}

let s = Solution()
let out1 = s.singleNonDuplicate([1,2,2,3,3])
print("answer \(out1)")
