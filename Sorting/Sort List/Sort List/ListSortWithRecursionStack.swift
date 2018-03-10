//
//  ListSortWithRecursionStack.swift
//  Sort List
//
//  Created by Andrey Ermoshin on 10/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// https://www.geeksforgeeks.org/merge-sort-for-linked-list/

class RecursiveListSortSolution {
    func findListMiddleNode(_ head: ListNode) -> (middle: ListNode, beforeMiddle: ListNode) {
        var slow = head
        var fast: ListNode? = head
        var beforeSlow: ListNode = head
        while fast != nil {
            if let slowNext = slow.next {
                beforeSlow = slow
                slow = slowNext
                fast = slowNext.next
            }
        }
        return (slow, beforeSlow)
    }
    
    private func merge(l1Head: ListNode, l2Head: ListNode) -> ListNode {
        var l1index: ListNode? = l1Head
        var l2index: ListNode? = l2Head
        var resultHead: ListNode
        var resultIndex: ListNode
        // next code just to initialize new head
        // before linking other nodes for united list
        if l1Head.val <= l2Head.val {
            resultHead = l1Head
            l1index = l1Head.next
        }
        else {
            resultHead = l2Head
            l2index = l2Head.next
        }
        resultIndex = resultHead
        
        // now re-link/merge nodes from two lists to one sorted
        while let node1 = l1index, let node2 = l2index {
            if node1.val <= node2.val {
                l1index = node1.next
                resultIndex.next = node1
            }
            else {
                l2index = node2.next
                resultIndex.next = node2
            }
            resultIndex = resultIndex.next!
        }
        
        while let n1 = l1index {
            l1index = n1.next
            resultIndex.next = n1
            resultIndex = resultIndex.next!
        }
        while let n2 = l2index {
            l2index = n2.next
            resultIndex.next = n2
            resultIndex = resultIndex.next!
        }
        
        return resultHead
    }
    
    private func mergeSort(head: ListNode) -> ListNode {
        if head.next == nil {
            return head
        }
        
        let middleTouple = findListMiddleNode(head)
        // need to break list on two
        middleTouple.beforeMiddle.next = nil
        // now need to continue recursion
        let leftHead = mergeSort(head: head)
        let rightHead = mergeSort(head: middleTouple.middle)
        return merge(l1Head: leftHead, l2Head: rightHead)
    }
    
    func sortList(_ head: ListNode?) -> ListNode? {
        guard let head = head else {
            return nil
        }
        return mergeSort(head: head)
    }
}
