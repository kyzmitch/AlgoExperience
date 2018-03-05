//
//  main.swift
//  Sorted array to BST
//
//  Created by Andrey Ermoshin on 05/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation



  public class TreeNode {
      public var val: Int
      public var left: TreeNode?
      public var right: TreeNode?
    
      public init(_ val: Int) {
          self.val = val
          self.left = nil
          self.right = nil
      }
    
  }

class Solution {
    
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        let length = nums.count
        if length == 0 {
            return nil
        }
        var sortedSource = nums
        return balancedInsert(&sortedSource, left: 0, right: length - 1)
    }
    
    func balancedInsert(_ nums: inout [Int], left: Int, right: Int) -> TreeNode? {
        if left > right {
            return nil
        }
        let middle = left + (right-left)/2
        let head = TreeNode(nums[middle])
        head.left = balancedInsert(&nums, left:  left, right: middle - 1)
        head.right = balancedInsert(&nums, left: middle + 1, right: right)
        return head
    }
}

let solver = Solution()
let bst = solver.sortedArrayToBST([10,40,41,60,70])
print("BST")
