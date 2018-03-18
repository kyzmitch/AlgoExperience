//
//  main.swift
//  Reverse Linked List
//
//  Created by Andrey Ermoshin on 18/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation



  public class ListNode {
      public var val: Int
      public var next: ListNode?
      public init(_ val: Int) {
          self.val = val
          self.next = nil
      }
  }

class Solution {
    func reverseList(_ head: ListNode?) -> ListNode? {
        var current: ListNode? = head
        var previous: ListNode?
        var next: ListNode?
        
        while current != nil {
            // save reference to next element
            next = current?.next
            // swap nodes or add one more node to reversed node
            // now current is new head of reversed node
            current?.next = previous
            // move previous on next position
            // which was remembered at the end of previous iteration
            previous = current
            // move current to next position
            // which was remembered at the beginning of current iteration
            current = next
        }
        
        return previous
    }
}

let solver = Solution()
let list = ListNode(1)
list.next = ListNode(2)
list.next?.next = ListNode(3)
let reversedList = solver.reverseList(list)
print("reversed list")
