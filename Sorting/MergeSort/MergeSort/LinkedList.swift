//
//  LinkedList.swift
//  MergeSort
//
//  Created by Andrey Ermoshin on 02/01/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

class ListNode<T: Comparable> {
    var next: ListNode?
    let value: T
    init(payload: T) {
        value = payload
    }
    
    func middleNode() -> (middle: ListNode, beforeMiddle: ListNode) {
        var slow = self
        var fast: ListNode? = self
        var beforeSlow: ListNode = self
        while fast != nil {
            if let slowNext = slow.next {
                beforeSlow = slow
                slow = slowNext
                fast = slowNext.next
            }
        }
        return (slow, beforeSlow)
    }
}

class LinkedList<T: Comparable> {
    var head: ListNode<T>?
    init(payload: T) {
        head = ListNode(payload: payload)
    }
    
    init(headNode: ListNode<T>) {
        head = headNode
    }
    
    func copy() -> LinkedList? {
        // O(n)
        guard let head = head else { return nil }
        let copyHead = ListNode(payload: head.value)
        var newListIndex: ListNode<T>? = copyHead
        var oldListIndex: ListNode<T>? = head.next
        while let originalNode = oldListIndex {
            let newNode = ListNode(payload: originalNode.value)
            newListIndex?.next = newNode
            newListIndex = newListIndex?.next
            oldListIndex = oldListIndex?.next
        }
        return LinkedList(headNode: copyHead)
    }
    
    func mergeSorted() -> LinkedList? {
        // https://en.wikipedia.org/wiki/Merge_sort
        // Worst-case performance    O(n log n)
        if head == nil {
            return nil
        }
        
        // making a copy of existing list because reference semantics is used
        // and algorithm breaks links in original list
        // so, O(n) by space
        // so, better to have MERGE SORT only Inplace
        if let copiedList = copy() {
            let headToSortedResult = mergeSort(head: copiedList.head!)
            return LinkedList(headNode: headToSortedResult)
        }
        else {
            return nil
        }
    }
    
    func mergeSort() {
        if head == nil {
            return
        }
        
        let headToSortedResult = mergeSort(head: head!)
        head = headToSortedResult
    }
    
    private func mergeSort(head: ListNode<T>) -> ListNode<T> {
        if head.next == nil {
            return head
        }
        
        // 1. need to find middle node of the list
        let middleTouple = head.middleNode()
        // need to break list on two
        middleTouple.beforeMiddle.next = nil
        // now need to continue recursion
        let leftHead = mergeSort(head: head)
        let rightHead = mergeSort(head: middleTouple.middle)
        return merge(l1Head: leftHead, l2Head: rightHead)
    }
    
    private func merge(l1Head: ListNode<T>, l2Head: ListNode<T>) -> ListNode<T> {
        var l1index: ListNode<T>? = l1Head
        var l2index: ListNode<T>? = l2Head
        var resultHead: ListNode<T>
        var resultIndex: ListNode<T>
        // next code just to initialize new head
        // before linking other nodes for united list
        if l1Head.value <= l2Head.value {
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
            if node1.value <= node2.value {
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
    
    func bottomUpMergeSort() {
        // implementation above doesn't work for Big amount of elements
        // because of stack overflow for recursion, so:
        
        // As commented below, bottom up merge sort for linked list is faster,
        // eliminating the need to scan lists in order to split them.
        // The small fixed size array used would take up less space
        // than the stack overhead for a large list. Bottom up merge sort for
        // linked lists is explained in the same wiki article linked to in the original example:
        
        // https://en.wikipedia.org/wiki/Merge_sort#Bottom-up_implementation_using_lists
        
        
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        var result = "Description: \n"
        guard let head = head else {
            return result
        }
        var index = head
        result.append("\(index.value), ")
        while index.next != nil {
            index = index.next!
            result.append("\(index.value), ")
        }
        return result
    }
}
