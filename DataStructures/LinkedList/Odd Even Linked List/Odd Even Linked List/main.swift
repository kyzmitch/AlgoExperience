//
//  main.swift
//  Odd Even Linked List
//
//  Created by Andrei Ermoshin on 5/19/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */
class Solution {
    func oddEvenList(_ head: ListNode?) -> ListNode? {
        guard head != nil else {
            return nil
        }
        guard head!.next != nil else {
            return head
        }
        
        // We just need to form a linked list of all
        // odd nodes(X) and another linked list of all
        // even nodes(Y). Afterwards, we link Y to the end of X, and return the head of X.
        let oddHead = head
        let evenHead: ListNode? = head!.next
        var oddI = oddHead
        var evenI = evenHead
        while evenI != nil && evenI?.next != nil {
            oddI!.next = oddI!.next!.next
            evenI!.next = evenI!.next!.next
            oddI = oddI!.next
            evenI = evenI!.next
        }
        
        oddI!.next = evenHead
        return oddHead
    }
}
