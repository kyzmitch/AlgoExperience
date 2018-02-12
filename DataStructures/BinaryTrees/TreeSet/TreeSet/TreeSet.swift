//
//  TreeSet.swift
//  TreeSet
//
//  Created by Andrey Ermoshin on 13/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

class TreeSet {
    var left: TreeSet?
    var right: TreeSet?
    var element: Element
    init(_ i: Int, _ v: Int) {
        element = ([i], v)
    }
    
    typealias Element = (indexes: [Int], value: Int)
    
    func insert(_ i: Int, _ v: Int) {
        if element.value == v {
            element.indexes.append(i)
            return
        }
        if v < element.value {
            if let left = left {
                left.insert(i, v)
            }
            else {
                left = TreeSet(i, v)
            }
        }
        else {
            if let right = right {
                right.insert(i, v)
            }
            else {
                right = TreeSet(i, v)
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

