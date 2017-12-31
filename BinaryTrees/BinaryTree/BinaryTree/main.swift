//
//  main.swift
//  BinaryTree
//
//  Created by Andrey Ermoshin on 31/12/2017.
//  Copyright © 2017 Andrey Ermoshin. All rights reserved.
//

import Foundation

var enumTree = BinaryTreeNodeEnum<Int>(newValue: 0)
enumTree = enumTree.insert(valueForInsertion: -1)
enumTree = enumTree.insert(valueForInsertion: 2)
enumTree = enumTree.insert(valueForInsertion: 4)
enumTree = enumTree.insert(valueForInsertion: -2)
enumTree = enumTree.insert(valueForInsertion: 1)
//enumTree.printTree()
//let sortedEnumArray = enumTree.sortedArray()
//print("enum: " + enumTree.description)
//if let foundNode = enumTree.search(for: 2) {
//    print("\(foundNode.description)")
//}
//
//print("enum size: \(enumTree.size())")
//print("enum max depth: \(enumTree.maxDepth())")
//if let min = enumTree.minValue() {
//    print("min value: \(min)")
//}

let refTree = BinaryTreeNodeRefType<Int>(newValue: 0)
refTree.insert(valueForInsertion: -1)
refTree.insert(valueForInsertion: 2)
refTree.insert(valueForInsertion: 4)
refTree.insert(valueForInsertion: -2)
refTree.insert(valueForInsertion: 1)
let hasSum = refTree.hasPathSum(sum: -3)
print("Has path with sum: \(hasSum)")
//refTree.printTree()
//let array = refTree.sortedArray()
//refTree.printPostorder()
//BinaryTreeNodeRefType.printTree2(node: refTree)
//
//print("ref type: " + refTree.description)
//print("ref size: \(refTree.size())")
//print("ref max depth: \(refTree.maxDepth())")
//if let minRef = refTree.minValue() {
//    print("min value: \(minRef)")
//}
//
//
//// Modern way to write for loop
//let worstCaseForTree = BinaryTreeNodeRefType<Int>(newValue: 0)
//let n = 10
//for i in 1..<n {
//    worstCaseForTree.insert(valueForInsertion: -i)
//}
//print("worst case for inserting: " + worstCaseForTree.description)

