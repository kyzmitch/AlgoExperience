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
        var beforeSlow: ListNode
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
    
    func mergeSort() {
        // https://en.wikipedia.org/wiki/Merge_sort
        // Worst-case performance    O(n log n)
        guard let head = head else {
            return
        }
        
        mergeSort(head: head)
    }
    
    private func mergeSort(head: ListNode<T>) {
        if head.next == nil {
            return
        }
        
        // 1. need to find middle node of the list
        let middleTouple = head.middleNode()
        // need to break list on two
        middleTouple.beforeMiddle.next = nil
        // now need to continue recursion
        mergeSort(head: head)
        mergeSort(head: middleTouple.middle)
        merge(l1Head: head, l2Head: middleTouple.middle)
    }
    
    private func merge(l1Head: ListNode<T>, l2Head: ListNode<T>) {
        var l1index: ListNode? = l1Head
        var l2index: ListNode? = l2Head
        while l1index != nil && l2index != nil {
            
        }
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
