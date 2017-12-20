//
//  UnidirectionalList.swift
//  LinkedListBasics
//
//  Created by admin on 18/12/2017.
//  Copyright © 2017 Andrei Ermoshin. All rights reserved.
//

// FIFO

import Foundation

class UnidirectionalListNode<T> {
    let value: T
    var next: UnidirectionalListNode?
    init(v: T) {
        value = v
    }
}

// Typical linked list could be used to implement
// stack or queue

class UnidirectionalLinkedList<T> {
    // use optionals because list could be empty
    private var head: UnidirectionalListNode<T>?
    private var last: UnidirectionalListNode<T>?
    
    init(v: T) {
        head = UnidirectionalListNode<T>(v: v)
        last = head
    }
    
    func push(v: T) {
        // Places an object on the top of the stack.
        let freshNode = UnidirectionalListNode(v: v)
        freshNode.next = head
        head = freshNode
        if last == nil {
            last = head
        }
    }
    
    func count() -> UInt {
        var index = head
        var count: UInt = 0
        while let current = index {
            // already +1
            if let secondNode = current.next {
                // now it's +2
                index = secondNode
                count += 2
            }
            else {
                // end of the list
                count += 1
                break
            }
        }
        return count
    }
    
    func pop() -> T? {
        // Removes an object from the top of the stack and produces that object.
        let result = head
        if head === last {
            last = nil
            head = nil
        }
        else {
            head = head?.next
        }
        
        return result?.value
    }
    
    func append(v: T) {
        // Not for FIFO
        // just to add at the end
        // so, it's not typical task for common linked list
        
        let freshNode = UnidirectionalListNode(v: v)
        last?.next = freshNode
        last = freshNode
    }
    
    func containsLoop() -> Bool {
        // https://www.geeksforgeeks.org/detect-loop-in-a-linked-list/
        
        return false
    }
}

extension UnidirectionalLinkedList: CustomStringConvertible {
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

// Just for tests and tasks
extension UnidirectionalLinkedList {
    func lastNode() -> UnidirectionalListNode<T>? {
        return last
    }
    
    func node(at index: UInt) -> UnidirectionalListNode<T>? {
        var currentIx = 0
        var nodeIx = head
        while nodeIx != nil && currentIx < index {
            nodeIx = nodeIx?.next
            currentIx += 1
        }
        return nodeIx
    }
}

