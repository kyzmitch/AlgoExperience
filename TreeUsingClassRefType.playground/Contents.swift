//: Playground - noun: a place where people can play

import Foundation

class BaseTreeNode<T> {
    weak var parent: BaseTreeNode?
    public var childNodes: [BaseTreeNode]
    private let value: T
    
    init(theValue: T) {
        value = theValue
        childNodes = [BaseTreeNode]()
    }
}
