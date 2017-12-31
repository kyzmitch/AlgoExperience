//
//  Treelike.swift
//  BinaryTree
//
//  Created by Andrey Ermoshin on 31/12/2017.
//  Copyright © 2017 Andrey Ermoshin. All rights reserved.
//

import Foundation

// Generic protocols
// https://dispatchswift.com/generic-protocols-in-swift-b47414e29bba
// https://milen.me/writings/swift-generic-protocols/

// http://cslibrary.stanford.edu/110/BinaryTrees.html
// Basically, binary search trees are fast at insert and lookup.

protocol Treelike {
    associatedtype Element: Comparable
    func insert(valueForInsertion: Element) -> Self
    func search(for value: Element) -> Self?
    func size() -> Int
    func maxDepth() -> Int
    func isLeaf() -> Bool
    // for minimum value we could have empty tree case
    // so, for enum implementation at least we need possibility to
    // return nil, so it could be achived only by using Optional return value
    func minValue() -> Element?
    func printTree() -> Void
    func sortedArray() -> [Element]?
    func printPostorder() -> Void
}

