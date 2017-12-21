//
//  main.swift
//  LinkedListBasics
//
//  Created by Andrey Ermoshin on 15/11/2017.
//  Copyright © 2017 Andrei Ermoshin. All rights reserved.
//

import Foundation

let list = UnidirectionalLinkedList(v: 1)
for i in stride(from: 10, to: 21, by: 2) {
    list.append(v: i)
}

print("Linked list: \(list.description)")
print("contains loop 1: \(list.containsLoop())")

// To detect loop inside linked list
// https://www.geeksforgeeks.org/detect-loop-in-a-linked-list/
let kindOfMiddleNode = list.node(at: 2)
if let middle = kindOfMiddleNode {
    print("Middle: \(middle.value)")
}

let last = list.lastNode()
last?.next = kindOfMiddleNode
print("contains loop 2: \(list.containsLoop())")

