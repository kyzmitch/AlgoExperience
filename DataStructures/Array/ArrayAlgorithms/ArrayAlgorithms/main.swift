//
//  main.swift
//  ArrayAlgorithms
//
//  Created by admin on 11/01/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

let arr1 = [11, 1, 13, 21, 3, 7]
let arr2 = [11, 3, 7, 1]

print("1) merging is subset: \(arr2.mergingIsSubset(of: arr1))")

let s1 = [10, 5, 2, 23, 19]
let s2 = [19, 5, 3]

print("2) merging is subset: \(s2.mergingIsSubset(of: s1))")

let ss1 = [11, 1, 13, 21, 3, 7]
let ss2 = [11, 3, 7, 1]

print("3) hashing is subset: \(ss2.hashingIsSubset(of: ss1))")

let f1 = [10, 5, 2, 23, 19]
let f2 = [19, 5, 3]

print("4) hashing is subset: \(f2.hashingIsSubset(of: f1))")


let test1 = [1, 5, 7, -1]
print("5) pairs count \(test1.bruteForcePairsCount(with: 6))")
print("6) pairs count \(test1.slowPairsCount(with: 6))")

let test2 = [1, 7, 5, -1, 10, 20, 30, 40]

print("7) pairs count \(test2.slowPairsCount(with: 6))")
print("8) pairs count \(test2.pairsCount(with: 6))")

let test3 = [12, 10, 9, 45, 2, 10, 10, 45]
let test4 = [12, 10, 9, 45, 9, 45, 10, 1]
let test3after = test3.withoutDuplicates()
let test4after = test4.withoutDuplicates()

print("9) without duplicates \(test3after.description)")
print("10) without duplicates \(test4after.description)")

print("11) first repeated element \(test3.firstRepeatedElement())")
print("12) first repeated element \(test3.firstRepeatedElementWithoutHashing())")

let test5 = [1, 9, 3, 10, 4, 20, 2]
print("13) longest consecutive subsequence (sorting) \(test5.longestConsecutiveSubsequenceUsingSorting())")
print("14) longest consecutive subsequence (hashing) \(test5.longestConsecutiveSubsequence())")
