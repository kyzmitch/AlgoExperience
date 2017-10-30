//: Playground - noun: a place where people can play

import Foundation

// Generic protocols
// https://dispatchswift.com/generic-protocols-in-swift-b47414e29bba
// https://milen.me/writings/swift-generic-protocols/

protocol Insertable{
    associatedtype Element: Comparable
    func insert(valueForInsertion: Element) -> Self
}

class BinaryTreeNodeRefType<T: Comparable> {
    private let value: T
    // parent can be nil if it is root node
    private weak var parent: BinaryTreeNodeRefType?
    // childs should be stored by strong references
    private var left: BinaryTreeNodeRefType?
    private var right: BinaryTreeNodeRefType?
    
    init(newValue: T) {
        value = newValue
    }
}

// When you extend a generic type, you don’t provide a type parameter list as part of the extension’s definition.
// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179
// So, no need to write something like next
// extension BinaryTreeNodeRefType<T: Comparable>: Insertable

extension BinaryTreeNodeRefType: Insertable {
    typealias Element = T
    public func insert(valueForInsertion: Element) -> Self {
        // to maintain balanced binary tree
        // need to insert first from root node
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
}

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

extension BinaryTreeNodeEnum: Insertable {
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
            text = "\(value) {\(left.description), \(right.description) } "
        }
        return text
    }
}

var enumTree = BinaryTreeNodeEnum<Int>(newValue: 0)
enumTree = enumTree.insert(valueForInsertion: -1)
enumTree = enumTree.insert(valueForInsertion: 2)
enumTree = enumTree.insert(valueForInsertion: 4)
print(enumTree.description)
