//
//  main.swift
//  TreeSet
//
//  Created by Andrey Ermoshin on 12/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

class TreeSet {
    var left: TreeSet?
    var right: TreeSet?
    let element: Element
    init(_ i: Int, _ v: Int) {
        element = (i, v)
    }
    
    typealias Element = (index: Int, value: Int)
    
    func insert(_ node: TreeSet) {
        let valueForInsertion = node.element.value
        if element.value == valueForInsertion {
            return
        }
        if valueForInsertion < element.value {
            if let left = left {
                left.insert(node)
            }
            else {
                left = node
            }
        }
        else {
            if let right = right {
                right.insert(node)
            }
            else {
                right = node
            }
        }
    }
    
    func ceiling(_ e: Int) -> Element? {
        return ceilingHelper(e, nil)
    }
    
    func ceilingHelper(_ e: Int,_ currentMinimum: Element?) -> Element? {
        switch (left, right) {
        case (nil, nil):
            if element.value >= e {
                return element
            }
            else {
                return currentMinimum
            }
        case let (nil, r?):
            if element.value >= e {
                return element
            }
            else {
                // most likely previous node minimum is nil actually
                return r.ceilingHelper(e, currentMinimum)
            }
        case let (l?, nil):
            if element.value >= e {
                return l.ceilingHelper(e, element)
            }
            else {
                return currentMinimum
            }
        case let (l?, r?):
            return element.value >= e ? l.ceilingHelper(e, element) : r.ceilingHelper(e, nil)
        }
    }
    
    func floor(_ e: Int) -> Element? {
        // Returns the greatest element in this set less than
        // or equal to the given element, or null if there is no such element.
        return floorHelper(e, nil)
    }
    
    func floorHelper(_ e: Int, _ currentMaximum: Element?) -> Element? {
        switch (left, right) {
        case (nil, nil):
            if element.value <= e {
                return element
            }
            else {
                return currentMaximum
            }
        case let (nil, r?):
            if element.value <= e {
                // trying to find closest/greatest value which is <= e
                // we can pass element because it is <= e
                // TODO: most likely this additional
                // recursion is not needed
                // and need just return current element
                return r.floorHelper(e, element)
            }
            else {
                // need to return previous correct node
                return currentMaximum
            }
        case let (l?, nil):
            if element.value <= e {
                // need to return current value
                return element
            }
            else {
                // we can't pass element because it's not <= e
                // but probably we can pass previous value
                // TODO: most likely previous value in this case
                // is always nil
                return l.floorHelper(e, currentMaximum)
            }
        case let (l?, r?):
            return element.value <= e ? r.floorHelper(e, element) : l.floorHelper(e, nil)
        }
    }
}

let array = [5, 3, 8, 4, -1, 8, 6]
var root: TreeSet?
for (i, x) in array.enumerated() {
    if let r = root {
        r.insert(TreeSet(i, x))
    }
    else {
        root = TreeSet(i, x)
    }
}

//let f1 = root!.floor(-2)
//print("floor \(f1)") // nil
//let f2 = root!.floor(9)
//print("floor \(f2)") // 8
//let f3 = root!.floor(2)
//print("floor \(f3)") // -1
//let f4 = root!.floor(7)
//print("floor \(f4)") // 6
//let f5 = root!.floor(4)
//print("floor \(f5)") // 4
//let f6 = root!.floor(1)
//print("floor \(f6)") // -1


let c1 = root!.ceiling(-2)
print("ceiling \(c1)") // -1
let c2 = root!.ceiling(9)
print("ceiling \(c2)") // nil (10?)
let c3 = root!.ceiling(2)
print("ceiling \(c3)") // 3
let c4 = root!.ceiling(7)
print("ceiling \(c4)") // 8
let c5 = root!.ceiling(4)
print("ceiling \(c5)") // 4
let c6 = root!.ceiling(1)
print("ceiling \(c6)") // 3

