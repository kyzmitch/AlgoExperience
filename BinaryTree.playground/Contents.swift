//: Playground - noun: a place where people can play

import Foundation

// Generic protocols
// https://dispatchswift.com/generic-protocols-in-swift-b47414e29bba
// https://milen.me/writings/swift-generic-protocols/

// http://cslibrary.stanford.edu/110/BinaryTrees.html
// Basically, binary search trees are fast at insert and lookup.

protocol Treelike {
    associatedtype Element: Comparable
    func insert(valueForInsertion: Element) -> Self
    func search(for value: Element) -> Self?
    func size() -> Int
}

// Use 'final' keyword for class to meet requirements from compiler
// for returning Self from function
// specifically for search
final class BinaryTreeNodeRefType<T: Comparable> {
    private let value: T
    // parent can be nil if it is root node
    private weak var parent: BinaryTreeNodeRefType?
    // childs should be stored by strong references
    private var left: BinaryTreeNodeRefType?
    private var right: BinaryTreeNodeRefType?
    
    // to protect from empty case
    // private init()
    // even if that init method is never used
    // compiler wants to initialize non optional values
    // but it is not possible or not convinient
    // value = T.init()
    // because for example Int can't be emtpy, but for example String could be
    
    init(newValue: T) {
        value = newValue
    }
}

// When you extend a generic type, you don’t provide a type parameter list as part of the extension’s definition.
// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179
// So, no need to write something like next
// extension BinaryTreeNodeRefType<T: Comparable>: Treelike

extension BinaryTreeNodeRefType: Treelike {
    typealias Element = T

    public func insert(valueForInsertion: Element) -> Self {
        // to maintain balanced binary tree
        // need to search place where to insert firstly from the root node
        if valueForInsertion == value {
            // nothing to insert - the element is already inside tree
            return self
        }
        if valueForInsertion < value {
            if let left = left {
                left.insert(valueForInsertion: valueForInsertion)
            }
            else {
                left = BinaryTreeNodeRefType(newValue: valueForInsertion)
                left?.parent = self
            }
        }
        else {
            if let right = right {
                right.insert(valueForInsertion: valueForInsertion)
            }
            else {
                right = BinaryTreeNodeRefType(newValue: valueForInsertion)
                right?.parent = self
            }
        }
        
        // self but it actually will not be used
        return self
    }
    
    func search(for value: T) -> BinaryTreeNodeRefType? {
        // 'Self' is only available in a protocol or as the result of a method in a class
        // empty case for class implementation is not justified
        // because if describe the value as Optional
        // then it will be very bad for performance to always cast from Optional to real type
        // during search or insert
        
        if value == self.value {
            return self
        }
        else {
            if let left = left {
                if value == left.value {
                    return left
                }
                else if value < left.value {
                    return left.search(for: value)
                }
            }
            if let right = right {
                if value == right.value {
                    return right
                }
                else if value > right.value {
                    return right.search(for: value)
                }
            }
        }
        
        return nil
    }
    
    func size() -> Int {
        return 1 + (left != nil ? left!.size() : 0) + (right != nil ? right!.size() : 0)
    }
}

extension BinaryTreeNodeRefType: CustomStringConvertible {
    var description: String {
        var text: String
        text = "\(value) "
        if let left = left {
            if let right = right {
                text += "{\(left.description), \(right.description)}"
            }
            else {
                text += "{\(left.description), empty}"
            }
        }
        else {
            if let right = right {
                text += "{empty, \(right.description)}"
            }
            else {
                // text += "{empty, empty}"
            }
            
        }
        return text
    }
}

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
        case .node(let l, let v, let r):
            return 1 + l.size() + r.size()
        case .leaf(let v):
            return 1
        case .empty:
            return 0
        }
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

var enumTree = BinaryTreeNodeEnum<Int>(newValue: 0)
enumTree = enumTree.insert(valueForInsertion: -1)
enumTree = enumTree.insert(valueForInsertion: 2)
enumTree = enumTree.insert(valueForInsertion: 4)
enumTree = enumTree.insert(valueForInsertion: -2)
enumTree = enumTree.insert(valueForInsertion: 1)
print("enum: " + enumTree.description)
if let foundNode = enumTree.search(for: 2) {
    print("\(foundNode.description)")
}

print("enum size: \(enumTree.size())")

let refTree = BinaryTreeNodeRefType<Int>(newValue: 0)
refTree.insert(valueForInsertion: -1)
refTree.insert(valueForInsertion: 2)
refTree.insert(valueForInsertion: 4)
refTree.insert(valueForInsertion: -2)
refTree.insert(valueForInsertion: 1)

print("ref type: " + refTree.description)
print("ref size: \(refTree.size())")
