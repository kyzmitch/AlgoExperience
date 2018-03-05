//
//  AVLTree.swift
//  AVLTree
//
//  Created by Andrey Ermoshin on 01/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// https://www.geeksforgeeks.org/avl-tree-set-1-insertion/

class BTNode<T: Comparable> {
    // it is not a constant to allow swap values during delete operation
    var value: T
    var left: BTNode?
    var right: BTNode?
    var height: Int = 1 // new node is initially added at leaf
    
    convenience init(_ v: T) {
        self.init(v, nil, nil)
    }
    
    init(_ v: T, _ l: BTNode?, _ r: BTNode?) {
        value = v
        left = l
        right = r
    }
    
    class func height(_ node: BTNode<T>?) -> Int {
        if let n = node {
            return n.height
        }
        return 0
    }
    
    class func balance(_ node: BTNode<T>) -> Int {
        return BTNode.height(node.left) - BTNode.height(node.right)
    }
    
    func remove(_ child: BTNode<T>) {
        if let l = left {
            if child === l {
                left = nil
                return
            }
        }
        if let r = right {
            if child === r {
                right = nil
                return
            }
        }
    }
    
    func replace(child: BTNode<T>, on node: BTNode<T>) {
        if let l = left {
            if child === l {
                left = node
                return
            }
        }
        if let r = right {
            if child === r {
                right = node
                return
            }
        }
    }
    
    func minimumNode() -> BTNode<T> {
        var current = self
        while current.left != nil {
            current = current.left!
        }
        
        return current
    }
    
    func rotatedRight() -> BTNode<T> {
        /*
         T1, T2, T3 and T4 are subtrees.
                z                                      y
               / \                                   /   \
              y   T4      Right Rotate (z)          x      z
             / \          - - - - - - - - ->      /  \    /  \
            x   T3                               T1  T2  T3  T4
           / \
         T1  T2
         
         */
        
        let y = self
        let x = y.left!
        let T2 = x.right
        
        // Perform rotation
        x.right = y
        y.left = T2
        
        // Update heights
        y.height = max(BTNode.height(y.left), BTNode.height(y.right)) + 1;
        x.height = max(BTNode.height(x.left), BTNode.height(x.right)) + 1;
        
        // Return new root
        return x
    }
    
    func rotatedLeft() -> BTNode<T> {
        /*
         
         z                               y
        / \                            /   \
          T1   y     Left Rotate(z)   z      x
         /  \   - - - - - - - ->    / \    / \
        T2   x                     T1  T2 T3  T4
            / \
          T3  T4
         
         */

        
        let x = self
        let y = x.right!
        let T2 = y.left
        
        // Perform rotation
        y.left = x
        x.right = T2
        
        //  Update heights
        x.height = max(BTNode.height(x.left), BTNode.height(x.right)) + 1
        y.height = max(BTNode.height(y.left), BTNode.height(y.right)) + 1
        
        // Return new root
        return y
    }
}

class BSTTree<T: Comparable> {
    typealias TreePayload = T
    var head: BTNode<T>?
    init(_ h: BTNode<T>) {
        head = h
    }
    
    typealias AfterInsertAction = (BTNode<T>) -> BTNode<T>
    typealias AfterDeleteAction = (BTNode<T>) -> Void
    
    func preorderPrint() {
        var output = ""
        preorderString(head, &output)
        print("preorder:\n\(output)")
    }
    
    fileprivate func preorderString(_ node: BTNode<T>?, _ output: inout String) {
        if let n = node {
            output.append("[\(n.value), l")
            preorderString(n.left, &output)
            output.append(", r")
            preorderString(n.right, &output)
            output.append("]")
        }
        else {
            output.append("[nil]")
        }
    }
    
    func inorderPrint() {
        var output = ""
        inorderString(head, &output)
        print("inorder:\n\(output)")
    }
    
    fileprivate func inorderString(_ node: BTNode<T>?, _ output: inout String) {
        if let n = node {
            output.append("[l")
            inorderString(n.left, &output)
            output.append(",\(n.value), r")
            inorderString(n.right, &output)
            output.append("]")
        }
        else {
            output.append("[nil]")
        }
    }
    
    func insert(_ value: T) {
        head = insert(value, head, nil)
    }
    
    fileprivate func insert(_ value: T, _ node: BTNode<T>?, _ afterHandler: AfterInsertAction?) -> BTNode<T> {
        
        guard let node = node else {
            return BTNode(value)
        }
        
        if value < node.value {
            node.left = insert(value, node.left, afterHandler)
        }
        else if value > node.value {
            node.right = insert(value, node.right, afterHandler)
        }
        else {
            // Equal keys are not allowed in BST
            // nothing to insert - the element is already inside tree
            return node
        }
        
        // update height
        node.height = 1 + max(BTNode.height(node.left), BTNode.height(node.right))
        
        // for simple BST tree
        // that closure is always nil
        // but it should be for AVL
        if let handler = afterHandler {
            return handler(node)
        }
        
        // unchanged
        return node
    }
    
    func delete(_ value: T) {
        // https://www.geeksforgeeks.org/binary-search-tree-set-2-delete/
        delete(value, head, nil, nil)
    }
    
    fileprivate func delete(_ value: T, _ node: BTNode<T>?, _ parent: BTNode<T>?, _ afterHandler: AfterDeleteAction?) {
        guard let n = node else { return }
        
        if value == n.value {
            if let p = parent {
                switch (n.left, n.right) {
                case (nil, nil):
                    // 1) Node to be deleted is leaf: Simply remove from the tree.
                    p.remove(n)
                case let (l?, nil):
                    // 2) Node to be deleted has only one child:
                    // Copy the child to the node and delete the child
                    p.replace(child: n, on: l)
                case let (nil, r?):
                    // 2) also
                    p.replace(child: n, on: r)
                case let (_, r?):
                    // node with two children: Get the inorder successor
                    // (smallest in the right subtree)
                    let minimumNode = r.minimumNode()
                    n.value = minimumNode.value
                    delete(minimumNode.value, n.right, n, afterHandler)
                }
            }
            else {
                switch (n.left, n.right) {
                case (nil, nil):
                    head = nil
                case let (l?, nil):
                    head = l
                case let (nil, r?):
                    head = r
                case let (_, r?):
                    let minimumNode = r.minimumNode()
                    n.value = minimumNode.value
                    delete(minimumNode.value, n.right, n, afterHandler)
                }
            }
        }
        else if value < n.value {
            delete(value, n.left, n, afterHandler)
        }
        else if n.value < value {
            delete(value, n.right, n, afterHandler)
        }
        
        n.height = 1 + max(BTNode.height(n.left), BTNode.height(n.right))
        
        if let handler = afterHandler {
            _ = handler(n)
        }
    }
}

class AVLTree<T: Comparable>: BSTTree<T> {
    
    override func insert(_ value: T) {
        head = insert(value, head, { node in
            // If this node becomes unbalanced, then
            // there are 4 cases
            let balance = BTNode.balance(node)
            
            if balance > 1 {
                if let l = node.left {
                    // Left Left Case
                    if value < l.value {
                        return node.rotatedRight()
                    }
                    // Left Right Case
                    if value > l.value {
                        node.left = l.rotatedLeft()
                        return node.rotatedRight()
                    }
                }
            }
            else if balance < -1 {
                if let r = node.right {
                    // Right Right Case
                    if value > r.value {
                        return node.rotatedLeft()
                    }
                    // Right Left Case
                    if value < r.value {
                        node.right = r.rotatedRight()
                        return node.rotatedLeft()
                    }
                }
            }
            
            // return the (unchanged) node
            return node
        })
    }
    
    override func delete(_ value: T) {
        // https://www.geeksforgeeks.org/avl-tree-set-2-deletion/
        delete(value, head, nil, {node in
            // TODO
            _ = BTNode.balance(node)
            
            // If this node becomes unbalanced, then there are 4 cases
            
        })
    }
}
