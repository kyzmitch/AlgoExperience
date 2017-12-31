//
//  BinaryTreeNodeEnum.swift
//  BinaryTree
//
//  Created by Andrey Ermoshin on 31/12/2017.
//  Copyright © 2017 Andrey Ermoshin. All rights reserved.
//

import Foundation

// tree implementation using enumeration

enum BinaryTreeNodeEnum<T: Comparable> {
    case empty
    case leaf(T)
    indirect case node(BinaryTreeNodeEnum, T, BinaryTreeNodeEnum)
    
    init() {
        self = .empty
    }
    
    init(newValue: T) {
        self = .leaf(newValue)
    }
}

extension BinaryTreeNodeEnum: Treelike {
    typealias Element = T
    public func insert(valueForInsertion: Element) -> BinaryTreeNodeEnum {
        
        switch self {
        case .empty:
            return .leaf(valueForInsertion)
        case .leaf(let currentValue):
            if valueForInsertion < currentValue {
                return .node(BinaryTreeNodeEnum(newValue: valueForInsertion), currentValue, .empty)
            }
            else {
                return .node(.empty, currentValue, BinaryTreeNodeEnum(newValue: valueForInsertion))
            }
        case .node(let l, let currentValue, let r):
            if valueForInsertion < currentValue {
                return .node(l.insert(valueForInsertion: valueForInsertion), currentValue, r)
            }
            else {
                return .node(l, currentValue, r.insert(valueForInsertion: valueForInsertion))
            }
        }
    }
    
    func search(for value: T) -> BinaryTreeNodeEnum<T>? {
        switch self {
        case .empty:
            return nil
        case .leaf(let val):
            if val == value {
                return self
            }
            else {
                return nil
            }
        case .node(let l, let val, let r):
            if val == value {
                return self
            }
            else if val > value {
                return l.search(for: value)
            }
            else if val < value {
                return r.search(for: value)
            }
        }
        return nil
    }
    
    func size() -> Int {
        switch self {
        case .node(let l, _, let r):
            return 1 + l.size() + r.size()
        case .leaf(_):
            return 1
        case .empty:
            return 0
        }
    }
    
    func isLeaf() -> Bool {
        switch self {
        case .leaf(_):
            return true
        default:
            return false
        }
    }
    
    func maxDepth() -> Int {
        switch self {
        case .leaf(_), .empty:
            return 0
        case .node(let l, _, let r):
            let lDepth: Int = {
                // https://appventure.me/2015/10/17/advanced-practical-enum-examples/
                
                // warning: 'let' pattern has no effect; sub-pattern didn't bind any variables
                // But I can't add definition of variable because it will not be used
                // so, compiler again will say that it is better to replace variable with _ if
                // it is not used
                if case .node(_, _, _) = l {
                    return 1 + l.maxDepth()
                }
                else {
                    return 1
                }
            }()
            let rDepth: Int = {
                if case .node(_, _, _) = r {
                    return 1 + r.maxDepth()
                }
                else {
                    return 1
                }
            }()
            print("node(value) - l(\(lDepth)) - r(\(rDepth))")
            if lDepth > rDepth {
                return lDepth
            }
            else {
                return rDepth
            }
        }
    }
    
    func minValue() -> T? {
        if case .empty = self {
            // what if enum has empty state, we can't return generic type default value
            // because T doesn't have definition for init()
            // so replacing it with optional
            return nil
        }
        else if case let .leaf(v) = self {
            return v
        }
        else if case let .node(l, _, _) = self {
            // only interested in left node because it is binary search tree
            return l.minValue()
        }
        else {
            print(#function + ": not handled case")
            return nil
        }
    }
    
    func printTree() {
        BinaryTreeNodeEnum.printTree(rootNode: self)
    }
    
    static func printTree(rootNode: BinaryTreeNodeEnum) {
        if case let .node(l, v, r) = rootNode{
            BinaryTreeNodeEnum.printTree(rootNode: l)
            print("\(v)")
            BinaryTreeNodeEnum.printTree(rootNode: r)
        }
        else if case let .leaf(v) = rootNode {
            print("\(v)")
        }
    }
    
    func sortedArray() -> [T]? {
        if case let .node(l, v, r) = self {
            var result = [T]()
            if let lResult = l.sortedArray() {
                result.append(contentsOf: lResult)
            }
            result.append(v)
            if let rResult = r.sortedArray() {
                result.append(contentsOf: rResult)
            }
            return result
        }
        else if case let .leaf(v) = self {
            return [v]
        }
        else {
            return nil
        }
    }
    
    func printPostorder() {
        // not implemented
    }
}

extension BinaryTreeNodeEnum: CustomStringConvertible {
    var description: String {
        var text: String
        switch self {
        case .leaf(let value):
            text = "\(value)"
        case .empty:
            text = "empty"
        case .node(let left, let value, let right):
            text = "\(value) {\(left.description), \(right.description)}"
        }
        return text
    }
}

