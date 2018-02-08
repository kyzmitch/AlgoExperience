//
//  main.swift
//  MergeTwoSortedLists
//
//  Created by Andrey Ermoshin on 08/02/2018.
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
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        
        switch (l1, l2) {
        case (nil, nil):
            return nil
        case (nil, _?):
            return l2
        case (_?, nil):
            return l1
        case let (firstHead?, secondHead?):
            
            var resultHead: ListNode?
            var indexNode: ListNode
            var f: ListNode? = firstHead
            var s: ListNode? = secondHead
            
            // Need to init result head before cycle
            if firstHead.val < secondHead.val {
                resultHead = ListNode(firstHead.val)
                indexNode = resultHead!
                f = firstHead.next
            }
            else if firstHead.val > secondHead.val {
                resultHead = ListNode(secondHead.val)
                indexNode = resultHead!
                s = secondHead.next
            }
            else {
                // equality
                resultHead = ListNode(firstHead.val)
                resultHead!.next = ListNode(secondHead.val)
                indexNode = resultHead!.next!
                f = firstHead.next
                s = secondHead.next
            }
            
            while true {
                switch (f, s) {
                case (nil, nil):
                    // both lists were with same length
                    return resultHead
                case let (ff?, nil):
                    indexNode.next = ff
                    return resultHead
                case let (nil, ss?):
                    indexNode.next = ss
                    return resultHead
                case let (ff?, ss?):
                    if ff.val < ss.val {
                        indexNode.next = ff
                        f = ff.next
                    }
                    else if ff.val > ss.val {
                        indexNode.next = ss
                        s = ss.next
                    }
                    else {
                        indexNode.next = ListNode(ff.val)
                        indexNode = indexNode.next!
                        indexNode.next = ListNode(ss.val)
                        f = ff.next
                        s = ss.next
                    }
                    indexNode = indexNode.next!
                }
            }
        }
    }
}

let l1 = ListNode(1)
l1.next = ListNode(2)
l1.next?.next = ListNode(4)

let l2 = ListNode(1)
l2.next = ListNode(3)
l2.next?.next = ListNode(4)

let solver = Solution()
let r = solver.mergeTwoLists(l1, l2)

var index = r
while let i = index {
    print("(\(i.val))")
    index = i.next
}

