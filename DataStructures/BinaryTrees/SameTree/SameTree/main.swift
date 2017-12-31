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
    
    func isSame(node: BinaryTreeNodeRefType) -> Bool {
        
        if value != node.value {
            return false
        }
        var lSame: Bool
        switch (left, node.left) {
        case (nil, nil):
            lSame = true
            break
        case let (l?, nl?):
            lSame = l.isSame(node: nl)
            break
        default:
            lSame = false
        }
        
        var rSame: Bool
        switch (right, node.right) {
        case (nil, nil):
            rSame = true
            break
        case let (r?, nr?):
            rSame = r.isSame(node: nr)
            break
        default:
            rSame = false
        }
        return lSame && rSame
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
tree.insert(valueForInsertion: 5)
tree.insert(valueForInsertion: 3)
print(tree.description)
let eert = BinaryTreeNodeRefType(newValue: 0)
eert.insert(valueForInsertion: -1)
eert.insert(valueForInsertion: 2)
eert.insert(valueForInsertion: -2)
eert.insert(valueForInsertion: 1)
eert.insert(valueForInsertion: 3)
print(eert.description)
print("\(tree.isSame(node: eert))")
