//
//  main.swift
//  Add Two Numbers
//
//  Created by Andrei Ermoshin on 4/26/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

/**
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

 You may assume the two numbers do not contain any leading zero, except the number 0 itself.

 Example:

 Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
 Output: 7 -> 0 -> 8
 Explanation: 342 + 465 = 807.
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    public init?(_ array: [Int]) {
        guard let first = array.first else { return nil }
        val = first
        var iterator: ListNode = self
        for i in (1..<array.count) {
            let node = ListNode(array[i])
            iterator.next = node
            iterator = node
        }
    }
 }
 
class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        return solution1(l1, l2)
    }
    
    private func solution1(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {

        var l1 = l1, l2 = l2
        var result: ListNode? = ListNode(-1)
        let preHead = result // Keep a reference to access the head
        var rest = 0

        // 1. Compute addition on both lists
        while let ll1 = l1, let ll2 = l2 {
            let add = ll1.val + ll2.val + rest
            let computedNode = ListNode(add % 10)
            result?.next = computedNode
            rest = add  - computedNode.val
            l1 = ll1.next
            l2 = ll2.next
            result = result?.next
        }
        
        var remL = l1 == nil ? l2 : l1
        // 2. Compute carry on remaining list (if there is one)
        while rest > 0, let remainingL = remL {
            let add = remainingL.val + rest
            result?.next = add >= 10 ? ListNode(0) : ListNode(add)
            rest = add / 10
            remL = remainingL.next
            result = result?.next
        }
        
        // If there is a carry, the remaining list is nil, so add the carry to the last link.
        // If there is no carry, we can append the remaining list.
        result?.next = rest > 0 ? ListNode(rest) : remL
        return preHead?.next // Return the reference to head
    }
}

let input1 = ListNode([1,8])
let input2 = ListNode([0])
let solver = Solution()
let sum = solver.addTwoNumbers(input1, input2)
print("sum \(sum)")
