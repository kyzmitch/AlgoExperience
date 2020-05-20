//
//  main.swift
//  Kth Smallest Element in a BST
//
//  Created by Andrei Ermoshin on 5/20/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation


 public class TreeNode {
     public var val: Int
     public var left: TreeNode?
     public var right: TreeNode?
     public init() { self.val = 0; self.left = nil; self.right = nil; }
     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
         self.val = val
         self.left = left
         self.right = right
     }
 }

class Solution {
    private var _stack = [Int]()
    
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        _stack.removeAll()
        scan(root, &_stack)
        return _stack[k - 1]
    }
    
    private func scan(_ root: TreeNode?, _ stack: inout [Int]) {
        guard let r = root else {
            return
        }
        
        scan(r.left, &stack)
        stack.append(r.val)
        scan(r.right, &stack)
    }
}

let s = Solution()
let head = TreeNode(5, TreeNode(3, TreeNode(2, TreeNode(1), nil), TreeNode(4)), TreeNode(6))
var kmin = s.kthSmallest(head, 1)
print("out 1: \(kmin)")
