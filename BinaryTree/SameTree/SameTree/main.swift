//
//  main.swift
//  SameTree
//
//  Created by Andrey Ermoshin on 14/11/2017.
//  Copyright © 2017 Andrei Ermoshin. All rights reserved.
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

let tree = BinaryTreeNodeRefType(newValue: 0)
tree.insert(valueForInsertion: -1)
tree.insert(valueForInsertion: 2)
tree.insert(valueForInsertion: -2)
tree.insert(valueForInsertion: 1)
tree.insert(valueForInsertion: 3)
tree.insert(valueForInsertion: 1)
print(tree.description)

print("After mirroring")
print(tree.description)
