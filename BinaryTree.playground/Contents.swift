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
    func maxDepth() -> Int
    func isLeaf() -> Bool
    // for minimum value we could have empty tree case
    // so, for enum implementation at least we need possibility to
    // return nil, so it could be achived only by using Optional return value
    func minValue() -> Element?
    func printTree() -> Void
    func sortedArray() -> [Element]?
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
    
    func isLeaf() -> Bool {
        return (left == nil && right == nil)
    }
    
    func maxDepth() -> Int {
        if isLeaf() {
            return 0
        }
        else {
            let lDepth = (left != nil ? 1 + left!.maxDepth() : 0)
            let rDepth = (right != nil ? 1 + right!.maxDepth() : 0)
            
            if lDepth > rDepth {
                return lDepth
            }
            else {
                // lDepth is the same or less than rDepth
                // so it is ok to return rDepth if they are equals
                return rDepth
            }
        }
    }
    
    func minValue() -> T? {
        // minimum in that binary search tree should be on the left subtree or minimum is a root node
        
        if let left = left {
            return left.minValue()
        }
        else {
            return value
        }
    }
    
    class func printTree(node: BinaryTreeNodeRefType?) {
        // Need to print tree values in increasing order
        // so, first need to find minimum value (node)
        // and after that need to move up and check right nodes
        
        guard let node = node else { return  }
        
        if let left = node.left {
            printTree(node: left)
        }
        print("\(node.value)")
        if let right = node.right {
            printTree(node: right)
        }
    }
    
    func sortedArray() -> [T]? {
        if left == nil && right == nil {
            return [value]
        }
        else {
            var result = [T]()
            if let left = left, let leftArray = left.sortedArray() {
                result.append(contentsOf: leftArray)
            }
            result.append(value)
            if let right = right, let rightArray = right.sortedArray() {
                result.append(contentsOf: rightArray)
            }
            return result
        }
    }
    
    func printTree() {
        BinaryTreeNodeRefType.printTree(node: self)
    }

    func nodeWithMinValue() -> BinaryTreeNodeRefType? {
        if let left = left {
            return left.nodeWithMinValue()
        }
        else {
            return self
        }
    }
    
    func nodeWithMaxValue() -> BinaryTreeNodeRefType? {
        if let right = right {
            return right.nodeWithMaxValue()
        }
        else {
            return self
        }
    }
}

extension BinaryTreeNodeRefType: CustomStringConvertible {
    var description: String {
        var text: String = "\(value) "
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
enumTree.printTree()
let sortedEnumArray = enumTree.sortedArray()
//print("enum: " + enumTree.description)
//if let foundNode = enumTree.search(for: 2) {
//    print("\(foundNode.description)")
//}
//
//print("enum size: \(enumTree.size())")
//print("enum max depth: \(enumTree.maxDepth())")
//if let min = enumTree.minValue() {
//    print("min value: \(min)")
//}

let refTree = BinaryTreeNodeRefType<Int>(newValue: 0)
refTree.insert(valueForInsertion: -1)
refTree.insert(valueForInsertion: 2)
refTree.insert(valueForInsertion: 4)
refTree.insert(valueForInsertion: -2)
refTree.insert(valueForInsertion: 1)
refTree.printTree()
let array = refTree.sortedArray()
//
//print("ref type: " + refTree.description)
//print("ref size: \(refTree.size())")
//print("ref max depth: \(refTree.maxDepth())")
//if let minRef = refTree.minValue() {
//    print("min value: \(minRef)")
//}
//
//
//// Modern way to write for loop
//let worstCaseForTree = BinaryTreeNodeRefType<Int>(newValue: 0)
//let n = 10
//for i in 1..<n {
//    worstCaseForTree.insert(valueForInsertion: -i)
//}
//print("worst case for inserting: " + worstCaseForTree.description)

