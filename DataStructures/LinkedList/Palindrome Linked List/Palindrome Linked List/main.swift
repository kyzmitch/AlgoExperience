//
//  main.swift
//  Palindrome Linked List
//
//  Created by Andrey Ermoshin on 09/02/2018.
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
    func isPalindrome(_ head: ListNode?) -> Bool {
        guard let h = head else { return true }
        var slow: ListNode? = head // will be middle after 1st cycle
        var fast = h
        
        var reversedHalf = ListNode(h.val)
        var isOddAmount = false
        // need to find the middle O(n/2)
        while true {
            guard let n1 = fast.next else {
                isOddAmount = true
                break
            }
            guard let n2 = n1.next else {
                fast = n1 // to mark end of the list
                isOddAmount = false
                break
            }
            fast = n2
            slow = slow?.next
            
            // creating reversed sub list
            let node = ListNode(slow!.val)
            node.next = reversedHalf
            reversedHalf = node
        }
        
        var left: ListNode? = reversedHalf
        var right: ListNode? = slow
        if isOddAmount {
            if let leftCorrected = reversedHalf.next {
                left = leftCorrected
            }
        }
        if let rightCorrected = slow?.next {
            right = rightCorrected
        }
        
        while let l = left, let r = right {
            if l.val != r.val {
                return false
            }
            left = l.next
            right = r.next
        }
        
        return true
    }
}

let solver = Solution()

let r = ListNode(1)
r.next = ListNode(2)
print("Is it palindrome - \(solver.isPalindrome(r) ? "yes":"no")")

let root = ListNode(1)
root.next = ListNode(2)
root.next?.next = ListNode(10)
root.next?.next?.next = ListNode(2)
root.next?.next?.next?.next = ListNode(1)


print("Is it palindrome - \(solver.isPalindrome(root) ? "yes":"no")")

let raat = ListNode(1)
raat.next = ListNode(3)
raat.next?.next = ListNode(2)
raat.next?.next?.next = ListNode(4)
raat.next?.next?.next?.next = ListNode(3)
raat.next?.next?.next?.next?.next = ListNode(2)
raat.next?.next?.next?.next?.next?.next = ListNode(1)
print("Is it palindrome - \(solver.isPalindrome(raat) ? "yes":"no")")



