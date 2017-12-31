//
//  main.swift
//  DoubleTree
//
//  Created by admin on 13/11/2017.
//  Copyright © 2017 kyzmitch. All rights reserved.
//

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
    
    func double() {
        // For each node in a binary search tree, create a new duplicate node,
        // and insert the duplicate as the left child of the original node.
        // The resulting tree should still be a binary search tree.
        let copyNode = BinaryTreeNodeRefType(newValue: value)
        copyNode.parent = self
        copyNode.left = left
        left = copyNode
        copyNode.left?.double()
        right?.double()
    }
}
extension BinaryTreeNodeRefType: CustomStringConvertible {
    var description: String {
        var text: String = "\(value) "
        if let left = left {
            if let right = right {
                text += "{\(left.description), \(right.description)}"
            }
            else {
                text += "{\(left.description), empty}"
            }
        }
        else {
            if let right = right {
                text += "{empty, \(right.description)}"
            }
        }
        return text
    }
}

let tree = BinaryTreeNodeRefType(newValue: 2)
tree.insert(valueForInsertion: 1)
tree.insert(valueForInsertion: 3)
print(tree.description)
tree.double()
print("After doubling")
print(tree.description)

