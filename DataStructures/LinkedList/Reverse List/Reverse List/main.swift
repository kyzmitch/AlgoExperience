//
//  main.swift
//  Reverse List
//
//  Created by admin on 21/02/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

class Node {
    var next: Node?
    let val: Int
    init(_ value: Int, _ next: Node?) {
        val = value
        self.next = next
    }
}

let head = Node(1, Node(2, Node(3, nil)))

func reverse(_ head: Node) -> Node {
    var current: Node? = head
    var previous: Node?
    var next: Node?
    
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
    
    return previous!
}

let reversedHead = reverse(head)
print("reversed: \(reversedHead.val)")
