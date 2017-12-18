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

class UnidirectionalLinkedList<T> {
    private var head: UnidirectionalListNode<T>
    
    init(v: T) {
        head = UnidirectionalListNode<T>(v: v)
    }
    
    func append(v: T) {
        var index = head
        
        while index.next != nil {
            index = index.next!
        }
        
        index.next = UnidirectionalListNode(v: v)
    }
    
    func print() {
        var index = head
        var s = "\(index.value) "
        while index.next != nil {
            index = index.next!
            s.append("\(index.value) ")
        }
        Swift.print("\(s)")
    }
}

