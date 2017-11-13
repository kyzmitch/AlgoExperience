//
//  main.swift
//  PrintPaths
//
//  Created by Andrey Ermoshin on 13/11/2017.
//  Copyright © 2017 Andrei Ermoshin. All rights reserved.
//

import Foundation


class BinaryTreeNodeRefType {
    private let value: Int
    private weak var parent: BinaryTreeNodeRefType?
    private var left: BinaryTreeNodeRefType?
    private var right: BinaryTreeNodeRefType?
    
    init(newValue: Int) {
        value = newValue
    }
    
    public func insert(valueForInsertion: Int) {
        if valueForInsertion == value {
            return
        }
        if valueForInsertion < value {
            if let left = left {
                left.insert(valueForInsertion: valueForInsertion)
            }
            else {
                left = BinaryTreeNodeRefType(newValue: valueForInsertion)
                left?.parent = self
            }
        }
        else {
            if let right = right {
                right.insert(valueForInsertion: valueForInsertion)
            }
            else {
                right = BinaryTreeNodeRefType(newValue: valueForInsertion)
                right?.parent = self
            }
        }
    }
    
    func isLeaf() -> Bool {
        return left == nil && right == nil
    }
    
    private func valuePathFromRoot(previousPaths: [[Int]]) -> [[Int]] {
        if isLeaf() {
            if let parent = parent {
                let result = previousPaths.getAppendedSubArray(with: parent.value, newValue: value)
                return result != nil ? result! : [[Int]]()
            }
        }
        else {
            var input = previousPaths
            input.appendSubarray(with: parent!.value, newValue: value)
            
            var leftPaths: [[Int]]?
            if let left = left {
                leftPaths = left.valuePathFromRoot(previousPaths: input)
            }
            var rightPaths: [[Int]]?
            if let right = right {
                rightPaths = right.valuePathFromRoot(previousPaths: input)
            }
            if leftPaths != nil && rightPaths != nil {
                var r = leftPaths!
                r.append(contentsOf: rightPaths!)
                return r
            }
            else if leftPaths != nil {
                return leftPaths!
            }
            else if rightPaths != nil {
                return rightPaths!
            }
        }
        return [[Int]]()
    }
    
    func printPaths() -> Void {
        // Given a binary tree, print out all of its root-to-leaf paths, one per line.
        if parent == nil && isLeaf() {
            print("Empty")
        }
        else {
            let rootPart = [[value]]
            if let left = left {
                let leftPaths = left.valuePathFromRoot(previousPaths: rootPart)
                print("\(leftPaths)")
            }
            if let right = right {
                let rightPaths = right.valuePathFromRoot(previousPaths: rootPart)
                print("\(rightPaths)")
            }
        }
    }
}

extension Array where Element == Array<Int> {
    nonmutating func getAppendedSubArray(with endValue: Int, newValue: Int) -> [[Int]]? {
        var pathIndex: Int?
        for (index, element) in self.enumerated() {
            if let lastValue = element.last {
                if lastValue == endValue {
                    pathIndex = index
                    break
                }
            }
        }
        
        if let pathIndex = pathIndex {
            var leafPath = self[pathIndex]
            leafPath.append(newValue)
            return [leafPath]
        }
        return nil
    }
    
    mutating func appendSubarray(with endValue: Int, newValue: Int) {
        var pathIndex: Int?
        for (index, element) in self.enumerated() {
            if let lastValue = element.last {
                if lastValue == endValue {
                    pathIndex = index
                    break
                }
            }
        }
        
        if let pathIndex = pathIndex {
            var leafPath = self[pathIndex]
            leafPath.append(newValue)
            self[pathIndex] = leafPath
        }
    }
}

let tree = BinaryTreeNodeRefType(newValue: 0)
tree.insert(valueForInsertion: -1)
tree.insert(valueForInsertion: 2)
tree.insert(valueForInsertion: -2)
tree.insert(valueForInsertion: 3)
tree.insert(valueForInsertion: 4)
tree.insert(valueForInsertion: 1)
tree.printPaths()


