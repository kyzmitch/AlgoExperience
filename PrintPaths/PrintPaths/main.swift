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
            var pathIndex: Int?
            for i in 0..<previousPaths.count {
                let path = previousPaths[i]
                if let lastValue = path.last {
                    if lastValue == value {
                        pathIndex = i
                        break
                    }
                }
            }
            
            if let pathIndex = pathIndex {
                var leafPath = previousPaths[pathIndex]
                leafPath.append(value)
                return [leafPath]
            }
            else {
                return [[Int]]()
            }
        }
        else {
            var leftPaths: [[Int]]?
            if let left = left {
                leftPaths = left.valuePathFromRoot(previousPaths: previousPaths)
            }
            var rightPaths: [[Int]]?
            if let right = right {
                rightPaths = right.valuePathFromRoot(previousPaths: previousPaths)
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
    }
    
    func printPaths() {
        // Given a binary tree, print out all of its root-to-leaf paths, one per line.
        if parent == nil && isLeaf() {
            print("Empty")
            return
        }
        else {
            let rootPart = Array<Array<Int>>([value])
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

let tree = BinaryTreeNodeRefType(newValue: 0)
tree.insert(valueForInsertion: -1)
tree.insert(valueForInsertion: 2)
tree.insert(valueForInsertion: -2)
tree.insert(valueForInsertion: 3)
tree.insert(valueForInsertion: 4)
tree.printPaths()


