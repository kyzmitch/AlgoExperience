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
    
    func withoutDuplicates() -> Array<Element> {
        var s = Set<Element>()
        for el in self {
            if !s.contains(el) {
                s.insert(el)
            }
        }
        return Array(s)
    }
    
    func firstRepeatedElement() -> Element? {
        var hashSet = Set<Element>()
        for el in self {
            if !hashSet.contains(el) {
                hashSet.insert(el)
            }
            else {
                return el
            }
        }
        return nil
    }
    
    func firstRepeatedElementWithoutHashing() -> Element? {
        if count < 2 {
            return nil
        }
        // Assuming that sorting takes O(n * long(n))
        let sortedSelf = self.sorted()
        // Now need to find exactly FIRST occurense
        // so, traverse original array O(n)
        for el in self {
            // Assuming that binary search is used inside O(log(n))
            guard let i = sortedSelf.index(of: el) else {
                continue
            }
            // check neighbours
            if i != 0 {
                let left = sortedSelf[i - 1]
                if el == left {
                    return el
                }
            }
            if i != sortedSelf.count - 1 {
                let right = sortedSelf[i + 1]
                if el == right {
                    return el
                }
            }
        }
        return nil
    }
}

extension Array where Iterator.Element == Int {
    func bruteForcePairsCount(with sum: Int) -> UInt {
        var counter: UInt = 0
        var tempDebug = [(Element, Element)]()
        for (i, el) in self.enumerated() {
            for (j, anotherEl) in self.enumerated() where j != i {
                if el + anotherEl == sum {
                    counter += 1
                    tempDebug.append((el, anotherEl))
                    // now need to exclude pair from search array
                }
            }
        }
        
        // need to exclude duplicates somehow
        if count % 2 == 0 {
            counter = counter / 2
        }
        return counter
    }
    
    func slowPairsCount(with sum: Int) -> UInt {
        // assuming that self doesn't contains
        // duplicated values
        var counter: UInt = 0
        var set = Set(self)
        var finishedElements = 0
        while set.count > 1 && finishedElements < self.count {
            for iValue in set {
                var needBreak = false
                let subSet = set.subtracting([iValue])
                for jValue in subSet {
                    if iValue + jValue == sum {
                        counter += 1
                        // exclude integers which were found
                        // in pair because it doesn't make sense
                        // to search for another number from array if
                        // we're sure that only number from found pair
                        // is correct
                        
                        // Next way of removing using Array is wrong
                        // after removing at i, the index j will be shifted and wrong
                        // arr.remove(at: i)
                        // arr.remove(at: j)
                        set.remove(iValue)
                        set.remove(jValue)
                        finishedElements += 2
                        // Also, better to use Set from self
                        // because removing from array is O(n)
                        // but from the set it is O(1)
                        needBreak = true
                        break
                    }
                }
                
                if needBreak {
                    break
                }
                else {
                    finishedElements += 1
                }
            }
        }
        return counter
    }
    
    func pairsCount(with sum: Int) -> UInt {
        var counter: UInt = 0
        var dict = Dictionary<Int, UInt>()
        for v in self {
            // again we assuming that there is no duplicates
            dict[v] = 1
        }
        
        for v in self {
            if let _ = dict[sum - v] {
                counter += 1
            }
        }
        
        return counter / 2
    }
    
    func longestConsecutiveSubsequenceUsingSorting() -> [Element] {
        let s = sorted() // O(n * log(n))
        var start: Int?
        var end: Int?
        var ranges = Array<(Int, Int)>()
        for i in (0..<s.count - 1) {
            let left = s[i]
            let right = s[i+1]
            if left + 1 == right{
                if let _ = start {
                    end = i + 1
                }
                else {
                    start = i
                    end = i + 1
                }
            }
            else {
                if let realStart = start, let realEnd = end {
                    ranges.append((realStart, realEnd))
                }
                // Need to erase previous start to allow check above
                // to work as in first time as expected
                start = nil
            }
        }
        // O(n)
        
        // search for longest subsequence
        var maxLength: Int = Int.min
        var indexOfMax: Int = 0
        for i in (0..<ranges.count) {
            let t = ranges[i]
            let length = t.1 - t.0
            if length > maxLength {
                maxLength = length
                indexOfMax = i
            }
        }
        // O(n)
        
        let r = ranges[indexOfMax]
        let subsequence = s[r.0...r.1]
        return Array<Element>(subsequence)
    }
    
    func longestConsecutiveSubsequence() -> [Element] {
        let s = Set(self)
        var currentSubsequence = [Element]()
        var history = [[Element]]()
        
        for i in (0..<count) {
            let left = self[i]
            if s.contains(left + 1) {
                if currentSubsequence.isEmpty {
                    currentSubsequence.append(left)
                }
                currentSubsequence.append(left + 1)
            }
            else {
                history.append(currentSubsequence)
                currentSubsequence.removeAll()
            }
        }
        
        var max = Int.min
        var index: Int = 0
        for i in (0..<history.count) {
            let subsequence = history[i]
            if subsequence.count > max {
                max = subsequence.count
                index = i
            }
        }
        
        return history[index]
    }
}
