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
    var previous: Node?
    var current: Node? = head
    var next: Node?
    while current != nil {
        next = current?.next
        current?.next = previous
        previous = current
        current = next
    }
    return previous!
}

let reversedHead = reverse(head)
print("reversed: \(reversedHead.val)")
