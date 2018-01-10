//
//  main.swift
//  BinaryTreeMirror
//
//  Created by admin on 13/11/2017.
//  Copyright © 2017 kyzmitch. All rights reserved.
//



class BinaryTreeNodeRefType<T: Comparable> {
    private let value: T
    private weak var parent: BinaryTreeNodeRefType?
    private var left: BinaryTreeNodeRefType?
    private var right: BinaryTreeNodeRefType?
    
    init(newValue: T) {
        value = newValue
    }
    
    public func insert(valueForInsertion: T) {
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
    
    func mirror() {
        let tempNode = left
        left = right
        right = tempNode
        left?.mirror()
        right?.mirror()
        
        // memory usage: c * log(n) even if recursive function is without parameters
        // calls to that function consts some memory in stack
    }
    
    static func invertTree(_ root: BinaryTreeNodeRefType?) -> BinaryTreeNodeRefType? {
        // https://leetcode.com/problems/invert-binary-tree/description/
        // solution from D. Volevodz
        // for some reason I know that problem as mirroring problem
        // but on leetcode website it is called inverting bst
        if let temp = root {
            let l = invertTree(temp.left)
            let r = invertTree(temp.right)
            temp.left = r
            temp.right = l
            return temp
        }
        return nil
    }
    
    class TreeNodeRecord {
        let node: BinaryTreeNodeRefType
        let position: Int
        
        init(binaryNode: BinaryTreeNodeRefType, nodePosition: Int) {
            node = binaryNode
            position = nodePosition
        }
    }
    
    func mirrorWithoutRecursion() {
        // https://refactoring.com/catalog/replaceRecursionWithIteration.html
        // I heard that it could be implemented with using
        // supplementary data structure such as stack
        
        var index:BinaryTreeNodeRefType? = self
        var sl = Stack<BinaryTreeNodeRefType>()
        
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
tree.mirror()
print("After mirroring")
print(tree.description)

let tree2 = BinaryTreeNodeRefType(newValue: 0)
tree2.insert(valueForInsertion: -1)
tree2.insert(valueForInsertion: 2)
tree2.insert(valueForInsertion: -2)
tree2.insert(valueForInsertion: 1)
tree2.insert(valueForInsertion: 3)
tree2.insert(valueForInsertion: 1)
print(tree2.description)
let tree2Inverted = BinaryTreeNodeRefType.invertTree(tree2)
if let inverted = tree2Inverted {
    print("After inverting")
    print(inverted.description)
}


