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
