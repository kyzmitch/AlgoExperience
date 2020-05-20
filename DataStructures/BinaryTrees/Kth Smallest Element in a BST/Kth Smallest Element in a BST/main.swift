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
        return _stack[_stack.count - k]
    }
    
    private func sortedAddToStack(_ stack: inout [Int], _ val: Int) {
        guard !stack.isEmpty else {
            stack.append(val)
            return
        }
        // sorted insert, min shold be at the end
        let pos = searchInsertPosition(&stack, val)
        stack.insert(val, at: pos)
    }
    
    /// binary search in sorted array, min should be at the end
    private func searchInsertPosition(_ nums: inout [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1
        var middleIndex = right / 2
        
        while left <= right {
            let current = nums[middleIndex]
            if current < target {
                right = middleIndex - 1
            }
            else if target < current {
                left = middleIndex + 1
            }
            else {
                // found
                return middleIndex
            }
            middleIndex = left + (right - left) / 2
        }
        
        // found position for in order insert
        return left
    }
    
    private func scan(_ root: TreeNode?, _ stack: inout [Int]) {
        guard let r = root else {
            return
        }
        sortedAddToStack(&stack, r.val)
        switch (r.left?.val, r.right?.val) {
        case ( _?, _?):
                scan(r.left, &stack)
                scan(r.right, &stack)
        case ( _?, nil):
                scan(r.left, &stack)
        case (nil, _?):
                scan(r.right, &stack)
            default:
                break
        }
    }
}

let s = Solution()
let head = TreeNode(5, TreeNode(3, TreeNode(2, TreeNode(1), nil), TreeNode(4)), TreeNode(6))
var kmin = s.kthSmallest(head, 1)
print("out 1: \(kmin)")
