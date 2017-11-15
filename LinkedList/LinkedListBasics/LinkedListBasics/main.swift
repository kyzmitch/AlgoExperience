//
//  main.swift
//  LinkedListBasics
//
//  Created by Andrey Ermoshin on 15/11/2017.
//  Copyright © 2017 Andrei Ermoshin. All rights reserved.
//

import Foundation

class LinkedListNode<T> {
    let value: T
    var next: LinkedListNode?
    init(v: T) {
        value = v
    }
    
    func append(v: T) {
        var index = self
        
        while index.next != nil {
            index = index.next!
        }
        
        index.next = LinkedListNode(v: v)
    }
    
    func print() {
        var index = self
        var s = "\(index.value) "
        while index.next != nil {
            index = index.next!
            s.append("\(index.value) ")
        }
        Swift.print("\(s)")
    }
}

let list = LinkedListNode(v: 1)
list.append(v: 2)
list.print()

