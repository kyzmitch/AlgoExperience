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
        swap(&left, &right)
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
    
    func iterativeMirrorWithStack() {
        // https://refactoring.com/catalog/replaceRecursionWithIteration.html
        
        var s = Stack<BinaryTreeNodeRefType>()
        s.push(self)
        
        while s.count != 0 {
            let node = s.pop()
            swap(&node.left, &node.right)
            if let l = node.left {
                s.push(l)
            }
            if let r = node.right {
                s.push(r)
            }
        }
    }
    
    func iterativeMirrorWithQueue() {
        // Using queue over stack doesn't make difference
        var q = Queue<BinaryTreeNodeRefType>()
        q.enqueue(self)
        
        while q.count != 0 {
            let node = q.dequeue()
            swap(&node.left, &node.right)
            if let l = node.left {
                q.enqueue(l)
            }
            if let r = node.right {
                q.enqueue(r)
            }
        }
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

let tree0 = BinaryTreeNodeRefType(newValue: 100)
tree0.insert(valueForInsertion: 20)
tree0.insert(valueForInsertion: 10)
tree0.insert(valueForInsertion: 30)
tree0.insert(valueForInsertion: 500)
print(tree0.description)
tree0.iterativeMirrorWithStack()
tree0.iterativeMirrorWithQueue()
print("After iterative mirroring")
print(tree0.description)

let tree = BinaryTreeNodeRefType(newValue: 0)
tree.insert(valueForInsertion: -1)
tree.insert(valueForInsertion: 2)
tree.insert(valueForInsertion: -2)
tree.insert(valueForInsertion: 1)
tree.insert(valueForInsertion: 3)
tree.insert(valueForInsertion: 1)
print(tree.description)
tree.mirror()
print("After recursive mirroring")
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


