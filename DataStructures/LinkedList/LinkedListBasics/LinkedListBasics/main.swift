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

let f1 = UnidirectionalLinkedList(v: 1)
f1.append(v: 2)
f1.append(v: 10)
f1.append(v: 15)
f1.append(v: 100)
print(f1.description)
let s1 = UnidirectionalLinkedList(v: 2)
s1.append(v: 3)
s1.append(v: 4)
s1.append(v: 5)
s1.append(v: 15)
s1.append(v: 20)
print(s1.description)

if let r1 = UnidirectionalLinkedList.merge(first: f1, second: s1) {
    print("merged list: \(r1.description)")
}
else {
    print("not merged")
}

let sortedList = UnidirectionalLinkedList(v: 50)
sortedList.push(v: 50)
sortedList.push(v: 30)
sortedList.push(v: 30)
sortedList.push(v: 21)
sortedList.push(v: 11)
sortedList.push(v: 11)
sortedList.push(v: 11)
sortedList.push(v: 5)

sortedList.removeDuplicates()
print(sortedList.description)
