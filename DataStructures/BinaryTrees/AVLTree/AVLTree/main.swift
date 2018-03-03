//
//  main.swift
//  AVLTree
//
//  Created by Andrey Ermoshin on 01/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

print("BST")
let bst = BSTTree(BTNode(10))
bst.insert(20)
bst.insert(30)
bst.insert(40)
bst.insert(50)
bst.insert(25)
bst.inorderPrint()
bst.delete(30)
bst.inorderPrint()

print("AVL")
let avl = AVLTree(BTNode(10))
avl.insert(20)
avl.insert(30)
avl.insert(40)
avl.insert(50)
avl.insert(25)

bst.inorderPrint()

