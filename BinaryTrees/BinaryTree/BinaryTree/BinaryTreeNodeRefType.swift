//
//  BinaryTreeNodeRefType.swift
//  BinaryTree
//
//  Created by Andrey Ermoshin on 31/12/2017.
//  Copyright © 2017 Andrey Ermoshin. All rights reserved.
//

import Foundation

// Use 'final' keyword for class to meet requirements from compiler
// for returning Self from function
// specifically for search
final class BinaryTreeNodeRefType<T: Comparable> {
    // makeing properties fileprivate to allow
    // access to them from extension
    fileprivate let value: T
    // parent can be nil if it is root node
    fileprivate weak var parent: BinaryTreeNodeRefType?
    // childs should be stored by strong references
    fileprivate var left: BinaryTreeNodeRefType?
    fileprivate var right: BinaryTreeNodeRefType?
    
    // to protect from empty case
    // private init()
    // even if that init method is never used
    // compiler wants to initialize non optional values
    // but it is not possible or not convinient
    // value = T.init()
    // because for example Int can't be emtpy, but for example String could be
    
    init(newValue: T) {
        value = newValue
    }
}

// When you extend a generic type, you don’t provide a type parameter list as part of the extension’s definition.
// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179
// So, no need to write something like next
// extension BinaryTreeNodeRefType<T: Comparable>: Treelike

extension BinaryTreeNodeRefType: Treelike {
    typealias Element = T
    
    public func insert(valueForInsertion: Element) -> Self {
        // to maintain balanced binary tree
        // need to search place where to insert firstly from the root node
        if valueForInsertion == value {
            // nothing to insert - the element is already inside tree
            return self
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
        
        // self but it actually will not be used
        return self
    }
    
    func search(for value: T) -> BinaryTreeNodeRefType? {
        // 'Self' is only available in a protocol or as the result of a method in a class
        // empty case for class implementation is not justified
        // because if describe the value as Optional
        // then it will be very bad for performance to always cast from Optional to real type
        // during search or insert
        
        if value == self.value {
            return self
        }
        else {
            if let left = left {
                if value == left.value {
                    return left
                }
                else if value < left.value {
                    return left.search(for: value)
                }
            }
            if let right = right {
                if value == right.value {
                    return right
                }
                else if value > right.value {
                    return right.search(for: value)
                }
            }
        }
        
        return nil
    }
    
    func size() -> Int {
        return 1 + (left != nil ? left!.size() : 0) + (right != nil ? right!.size() : 0)
    }
    
    func isLeaf() -> Bool {
        return (left == nil && right == nil)
    }
    
    func maxDepth() -> Int {
        if isLeaf() {
            return 0
        }
        else {
            let lDepth = (left != nil ? 1 + left!.maxDepth() : 0)
            let rDepth = (right != nil ? 1 + right!.maxDepth() : 0)
            
            if lDepth > rDepth {
                return lDepth
            }
            else {
                // lDepth is the same or less than rDepth
                // so it is ok to return rDepth if they are equals
                return rDepth
            }
        }
    }
    
    func minValue() -> T? {
        // minimum in that binary search tree should be on the left subtree or minimum is a root node
        
        if let left = left {
            return left.minValue()
        }
        else {
            return value
        }
    }
    
    class func printTree(node: BinaryTreeNodeRefType?) {
        // Need to print tree values in increasing order
        // so, first need to find minimum value (node)
        // and after that need to move up and check right nodes
        
        guard let node = node else { return  }
        
        if let left = node.left {
            printTree(node: left)
        }
        print("\(node.value)")
        if let right = node.right {
            printTree(node: right)
        }
    }
    
    func sortedArray() -> [T]? {
        if left == nil && right == nil {
            return [value]
        }
        else {
            var result = [T]()
            if let left = left, let leftArray = left.sortedArray() {
                result.append(contentsOf: leftArray)
            }
            result.append(value)
            if let right = right, let rightArray = right.sortedArray() {
                result.append(contentsOf: rightArray)
            }
            return result
        }
    }
    
    func printTree() {
        BinaryTreeNodeRefType.printTree(node: self)
    }
    
    func nodeWithMinValue() -> BinaryTreeNodeRefType? {
        if let left = left {
            return left.nodeWithMinValue()
        }
        else {
            return self
        }
    }
    
    func nodeWithMaxValue() -> BinaryTreeNodeRefType? {
        if let right = right {
            return right.nodeWithMaxValue()
        }
        else {
            return self
        }
    }
    
    func printPostorder() {
        // Given a binary tree, print out the nodes of the tree according to a bottom-up "postorder" traversal
        // -- both subtrees of a node are printed out completely before the node itself is printed,
        // and each left subtree is printed before the right subtree.
        
        print("\(postordered())")
    }
    
    class func printPostorder2(node: BinaryTreeNodeRefType?) {
        if let node = node {
            printTree2(node: node.left)
            printTree2(node: node.right)
            print("\(node.value)")
        }
        else {
            print(#function + ": nil node")
            return
        }
    }
    
    class func printTree2(node: BinaryTreeNodeRefType?) {
        // Need to print tree values in increasing order
        // so, first need to find minimum value (node)
        // and after that need to move up and check right nodes
        
        guard let node = node else { return  }
        
        if let left = node.left {
            printTree(node: left)
        }
        if let right = node.right {
            printTree(node: right)
        }
        print("\(node.value)")
    }
    
    func postordered() -> [T] {
        var result = [T]()
        switch (left, right) {
        case let (l?, r?):
            // it is root
            result.append(contentsOf: l.postordered())
            result.append(contentsOf: r.postordered())
            result.append(value)
            return result
        case (.some(let l), .none):
            result.append(contentsOf: l.postordered())
            result.append(value)
            return result
        case (.none, .some(let r)):
            result.append(contentsOf: r.postordered())
            result.append(value)
            return result
        case (.none, .none):
            return [value]
        }
    }
}

extension BinaryTreeNodeRefType where Element == Int {
    func hasPathSum(sum: Element) -> Bool {
        if isLeaf() {
            if parent == nil {
                // this is root
                // We'll say that an empty tree contains no root-to-leaf paths
                return false
            }
            else {
                return (sum - value == 0)
            }
        }
        else {
            let remaining = sum - value
            let lHasSum = (left != nil ? left!.hasPathSum(sum: remaining) : false)
            let rHasSum = (right != nil ? right!.hasPathSum(sum: remaining) : false)
            return lHasSum || rHasSum
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

