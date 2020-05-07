//
//  main.swift
//  Cousins in Binary Tree
//
//  Created by Andrei Ermoshin on 5/7/20.
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
    
    static func fromArray(_ array: [Int?]) -> TreeNode? {
        guard !array.isEmpty else {
            return nil
        }
        return nil
    }
 }

class Solution {
    func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
        guard let ro = root else {
            // empty
            return false
        }
        guard ro.val != x && ro.val != y else {
            return false
        }
        guard let l = ro.left, let r = ro.right else {
            // only one leaf
            return false
        }
        let left = search(ro, l, x, y, 0)
        let right = search(ro, r, x, y, 0)
        if right?.done ?? false {
            return true
        }
        if left?.done ?? false {
            return true
        }
        guard let lt = left, let rt = right else {
            // x or y wesn't found
            return false
        }
        if lt.depth == rt.depth && lt.parent !== rt.parent {
            return true
        } else {
            return false
        }
    }
    
    func search(_ parent: TreeNode, _ branch: TreeNode?, _ x: Int, _ y: Int, _ depth: Int) -> (parent: TreeNode, depth: Int, done: Bool)? {
        guard let b = branch else {
                // end of branch which doesn't contain x or y
                return nil
        }
        if b.val == x {
            return (parent, depth + 1, false)
        } else if b.val == y {
            return (parent, depth + 1, false)
        } else {
            let optionalLT = search(b, b.left, x, y, depth + 1)
            let optionalRT = search(b, b.right, x, y, depth + 1)
            switch (optionalLT, optionalRT) {
                case (let lt?, let rt?):
                    // found both x and y on one side of tree
                    if lt.depth == rt.depth && lt.parent !== rt.parent {
                        return (parent, 1000, true)
                    } else {
                        return nil
                    }
                case (let lt?, _):
                    // found x pr y, not sure if need to return value to check if
                    // x found 2 times or the same for y
                    return lt
                case (_, let rt?):
                    return rt
                default:
                    // should be not possible, because task guaranties to have x or y on on side
                    return nil
            }
        }
    }
}


// tests
let solver = Solution()
// let input1 = [1,2,3,4]
let in1 = TreeNode(1, TreeNode(2, TreeNode(4), nil), TreeNode(3))
let out1 = solver.isCousins(in1, 4, 3)
assert(out1 == false)
