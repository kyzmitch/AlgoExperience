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
    let value: T
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
}

class BSTTree<T: Comparable> {
    typealias TreePayload = T
    var head: BTNode<T>?
    init(_ h: BTNode<T>) {
        head = h
    }
    
    class func height(_ node: BTNode<T>?) -> Int {
        if let n = node {
            return n.height
        }
        return 0
    }
    
    class func balance(_ node: BTNode<T>?) -> Int {
        if let n = node {
            return BSTTree.height(n.left) - BSTTree.height(n.right)
        }
        return 0
    }
    
    func preorderPrint() {
        var output = ""
        preorderString(head, &output)
        print(output)
    }
    
    fileprivate func preorderString(_ node: BTNode<T>?, _ output: inout String) {
        if let n = node {
            output.append("[\(n.value), l")
            preorderString(n.left, &output)
            output.append("r")
            preorderString(n.right, &output)
            output.append("]")
        }
        else {
            output.append("[nil]")
        }
    }
    
    func insert(_ value: T) {
        head = insert(value, head)
    }
    
    fileprivate func insert(_ value: T, _ node: BTNode<T>?) -> BTNode<T> {
        
        guard let node = node else {
            return BTNode(value)
        }
        
        if value < node.value {
            node.left = insert(value, node.left)
        }
        else if value > node.value {
            node.right = insert(value, node.right)
        }
        else {
            // Equal keys are not allowed in BST
            // nothing to insert - the element is already inside tree
            return node
        }
        
        // update height
        node.height = 1 + max(BSTTree.height(node.left), BSTTree.height(node.right))
        
        // unchanged
        return node
    }
}

protocol TreeRotating {
    associatedtype TreePayload: Comparable
    static func rotateRight(_ y: BTNode<TreePayload>) -> BTNode<TreePayload>
    static func rotateLeft(_ x: BTNode<TreePayload>) -> BTNode<TreePayload>
}

class AVLTree<T: Comparable>: BSTTree<T>, TreeRotating {
    
    override fileprivate func insert(_ value: T, _ node: BTNode<T>?) -> BTNode<T> {
        // Perform standard BST insert for value
        guard let node = node else {
            return BTNode(value)
        }
        
        if value < node.value {
            node.left = insert(value, node.left)
        }
        else if value > node.value {
            node.right = insert(value, node.right)
        }
        else {
            // Equal keys are not allowed in BST
            // nothing to insert - the element is already inside tree
            return node
        }
        
        // update height
        node.height = 1 + max(BSTTree.height(node.left), BSTTree.height(node.right))
        
        // If this node becomes unbalanced, then
        // there are 4 cases
        let balance = AVLTree.balance(node)
        
        // Left Left Case
        if balance > 1 && value < node.left!.value {
            return AVLTree.rotateRight(node)
        }
        
        // Right Right Case
        if balance < -1 && value > node.right!.value {
            return AVLTree.rotateLeft(node)
        }
        
        // Left Right Case
        if balance > 1 && value > node.left!.value {
            node.left = AVLTree.rotateLeft(node.left!);
            return AVLTree.rotateRight(node)
        }
        
        // Right Left Case
        if balance < -1 && value < node.right!.value {
            node.right = AVLTree.rotateRight(node.right!)
            return AVLTree.rotateLeft(node)
        }
        
        // return the (unchanged) node pointer
        return node
    }
    
    static func rotateRight(_ y: BTNode<TreePayload>) -> BTNode<TreePayload> {
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
        
        
        let x = y.left!
        let T2 = x.right
        
        // Perform rotation
        x.right = y
        y.left = T2
        
        // Update heights
        y.height = max(AVLTree.height(y.left), AVLTree.height(y.right)) + 1;
        x.height = max(AVLTree.height(x.left), AVLTree.height(x.right)) + 1;
        
        // Return new root
        return x
    }
    
    static func rotateLeft(_ x: BTNode<TreePayload>) -> BTNode<TreePayload> {
        /*
         
       z                                y
      / \                            /   \
    T1   y     Left Rotate(z)       z      x
        /  \   - - - - - - - ->    / \    / \
       T2   x                     T1  T2 T3  T4
           / \
         T3  T4
         
         */
        
        let y = x.right!
        let T2 = y.left
        
        // Perform rotation
        y.left = x
        x.right = T2
        
        //  Update heights
        x.height = max(AVLTree.height(x.left), AVLTree.height(x.right)) + 1
        y.height = max(AVLTree.height(y.left), AVLTree.height(y.right)) + 1
        
        // Return new root
        return y
    }
}
