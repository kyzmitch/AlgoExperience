//
//  main.swift
//  SameTree
//
//  Created by Andrey Ermoshin on 14/11/2017.
//  Copyright © 2017 Andrei Ermoshin. All rights reserved.
//

class TreeNode {
    fileprivate let val: Int
    private weak var parent: TreeNode?
    fileprivate var left: TreeNode?
    fileprivate var right: TreeNode?
    
    init(newValue: Int) {
        val = newValue
    }
    
    public func insert(valueForInsertion: Int) {
        if valueForInsertion == val {
            return
        }
        if valueForInsertion < val {
            if let left = left {
                left.insert(valueForInsertion: valueForInsertion)
            }
            else {
                left = TreeNode(newValue: valueForInsertion)
                left?.parent = self
            }
        }
        else {
            if let right = right {
                right.insert(valueForInsertion: valueForInsertion)
            }
            else {
                right = TreeNode(newValue: valueForInsertion)
                right?.parent = self
            }
        }
    }
    
    func isLeaf() -> Bool {
        return left == nil && right == nil
    }
    
    func isSame(node: TreeNode) -> Bool {
        
        if val != node.val {
            return false
        }
        var lSame: Bool
        switch (left, node.left) {
        case (nil, nil):
            lSame = true
            break
        case let (l?, nl?):
            lSame = l.isSame(node: nl)
            break
        default:
            lSame = false
        }
        
        var rSame: Bool
        switch (right, node.right) {
        case (nil, nil):
            rSame = true
            break
        case let (r?, nr?):
            rSame = r.isSame(node: nr)
            break
        default:
            rSame = false
        }
        return lSame && rSame
    }
}
extension TreeNode: CustomStringConvertible {
    var description: String {
        var text: String = "\(val) "
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

class Solution {
    static func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        
        if let p = p, let q = q {
            if p.val != q.val {
                return false
            }
            
            var lSame: Bool
            switch (p.left, q.left) {
            case (nil, nil):
                lSame = true
                break
            case let (l?, nl?):
                lSame = isSameTree(l, nl)
                break
            default:
                lSame = false
            }
            
            var rSame: Bool
            switch (p.right, q.right) {
            case (nil, nil):
                rSame = true
                break
            case let (r?, nr?):
                rSame = isSameTree(r, nr)
                break
            default:
                rSame = false
            }
            return lSame && rSame
        }
        else {
            switch (p, q) {
            case (nil, nil):
                return true
            default:
                return false
            }
        }
    }
}

let tree = TreeNode(newValue: 0)
tree.insert(valueForInsertion: -1)
tree.insert(valueForInsertion: 2)
tree.insert(valueForInsertion: -2)
tree.insert(valueForInsertion: 5)
tree.insert(valueForInsertion: 3)
print(tree.description)
let eert = TreeNode(newValue: 0)
eert.insert(valueForInsertion: -1)
eert.insert(valueForInsertion: 2)
eert.insert(valueForInsertion: -2)
eert.insert(valueForInsertion: 1)
eert.insert(valueForInsertion: 3)
print(eert.description)
print("\(tree.isSame(node: eert))")

print("Is same: \(Solution.isSameTree(tree, eert))")
