//
//  ListBottomUpSort.swift
//  Sort List
//
//  Created by Andrey Ermoshin on 10/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// https://en.wikipedia.org/wiki/Merge_sort#Bottom-up_implementation_using_lists

class Solution {
    private func merge(_ a: ListNode?, _ b: ListNode?) -> ListNode? {
        guard let l1Head = a else{
            return b
        }
        guard let l2Head = b else {
            return a
        }
        
        var result: ListNode?
        if l1Head.val <= l2Head.val {
            result = l1Head
            result?.next = merge(l1Head.next, l2Head)
        }
        else {
            result = l2Head
            result?.next = merge(l1Head, l2Head.next)
        }
        
        return result
    }
    
    func sortList(_ head: ListNode?) -> ListNode? {
        guard let head = head else {
            return nil
        }
        
        let n = 32
        var cache = Array<ListNode?>(repeatElement(nil, count: n))
        var result: ListNode? = head
        var next: ListNode?
        
        var i: Int
        // merge nodes into array
        while result != nil {
            next = result?.next
            result?.next = nil
            i = 0
            while i < n {
                if let x = cache[i] {
                    result = merge(x, result)
                    cache[i] = nil
                }
                else {
                    break
                }
                i += 1
            }
            // do not go past end of array
            if i == n {
                i -= 1
            }
            cache[i] = result
            result = next
        }
        
        // merge array into single list
        result = nil
        i = 0
        while i < n {
            result = merge(cache[i], result)
            i += 1
        }
        return result
    }
}
