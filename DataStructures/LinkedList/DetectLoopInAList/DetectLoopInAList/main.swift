//
//  main.swift
//  DetectLoopInAList
//
//  Created by Andrei Ermoshin on 8/10/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */

class Solution {
    func hasCycle(_ head: ListNode?) -> Bool {
        guard let h = head else {
            return false
        }
        var slow = h.next
        var fast = h.next?.next
        while slow != nil && fast != nil {
            if slow === fast {
                return true
            }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return false
    }
}
