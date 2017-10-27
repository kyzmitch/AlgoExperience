//: Playground - noun: a place where people can play

import Foundation

class BaseTreeNode<T: Comparable> {
    weak var parent: BaseTreeNode?
    public var childNodes: [BaseTreeNode]
    private let value: T
    
    init(theValue: T) {
        value = theValue
        childNodes = [BaseTreeNode]()
    }
    
    public func addChild(_ node: BaseTreeNode<T>) {
        childNodes.append(node)
        node.parent = self
    }
}

extension BaseTreeNode where T: Equatable {
    // Search could be not optimal because tree is not self balanced
    
    func search(value: T) -> BaseTreeNode? {
        if value == self.value {
            return self
        }
        for child in childNodes {
            if let found = child.search(value: value) {
                return found
            }
        }
        return nil
    }
}
