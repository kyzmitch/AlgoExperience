//
//  main.swift
//  BinaryTree InorderTraversal
//
//  Created by admin on 31/01/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

 public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class Solution {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var result = [Int]()
        if let realRoot = root {
            switch (realRoot.left, realRoot.right) {
            case let (l?, r?):
                // it is root
                result.append(contentsOf: inorderTraversal(l))
                result.append(realRoot.val)
                result.append(contentsOf: inorderTraversal(r))
                return result
            case (.some(let l), .none):
                result.append(contentsOf: inorderTraversal(l))
                result.append(realRoot.val)
                return result
            case (.none, .some(let r)):
                result.append(realRoot.val)
                result.append(contentsOf: inorderTraversal(r))
                return result
            case (.none, .none):
                return [realRoot.val]
            }
        }
        else {
            return result
        }
    }
}


