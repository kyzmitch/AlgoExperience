//
//  SkipList.swift
//  LinkedListBasics
//
//  Created by admin on 30/11/2017.
//  Copyright © 2017 Andrei Ermoshin. All rights reserved.
//

// SkipList is a linked list but it is sorted
// contains several layers for better search and insertion speed
// so it could be compared to binary tree
// and complexity is O(log n)

// https://ru.wikipedia.org/wiki/Список_с_пропусками
// вероятностная структура данных, основанная на нескольких
// параллельных отсортированных связных списках с эффективностью,
// сравнимой с двоичным деревом (порядка O(log n) среднее время для большинства операций).

import Foundation

private class SkipListNode<T> {
    let value: T
    var nextNode: SkipListNode?
    var downNode: SkipListNode?
    
    init(v: T) {
        value = v
    }
    
    public var levelsBelow: UInt8 {
        var levels: UInt8 = 1
        var bottomNode = downNode
        while bottomNode != nil {
            levels += 1
            bottomNode = bottomNode?.downNode
        }
        return levels
    }
}

struct Randomizer {
    static func randomPercent() -> Float {
        return Float(arc4random_uniform(100) / 100)
    }
}

class SkipList<T: Comparable> {
    // if node class declared as private
    // then property must be fileprivate
    // for node I just don't want to allow
    // use it outside skip list class
    // because it's not needed for public API
    
    fileprivate var head: SkipListNode<T>
    let maxLevel: UInt8
    var currentLevel: UInt8 {
        // to protect from changing it - no setter for current level
        return head.levelsBelow
    }
    private let p: Float = 0.5 // probability
    
    init(veryFirstValue: T, maximumLayer: UInt8) {
        head = SkipListNode<T>(v: veryFirstValue)
        maxLevel = maximumLayer
    }
    
    private func randomLevel() -> UInt8 {
        var levelForNewNode: UInt8 = 1
        var random = Randomizer.randomPercent()
        while random < p && levelForNewNode <= maxLevel {
            levelForNewNode += 1
            random = Randomizer.randomPercent()
        }
        return levelForNewNode
    }
    
    func insert(v: T) {
        // first need to find nearest node from which need to insert
        // and also need to decide if we need to create new layer or not
        // or do we need to just insert additional copy of some node on layer above
        
        if head.value == v {
            return
        }
        
        // http://www.geeksforgeeks.org/skip-list-set-2-insertion/
        
        if head.value < v {
            // this means that head will stay the same
            var currentNode = head
            // need to remember column of nodes
            // to use them for references when it will be needed
            // to insert new node on levels which is upper ground level
            var nodesColumn = [SkipListNode<T>]()
            // we need to check each layer
            // it will be done by checking down nodes
            
            while currentNode.downNode != nil {
                while let currentNextNode = currentNode.nextNode {
                    if currentNextNode.value > v {
                        // we found first next top layer node which is near the value
                        // so the value is between curentNode and currentNextNode
                        // we need to search on layer below
                        // and it depends on amount of layers
                        // so it looks similar to recursion
                        break
                    }
                    else {
                        currentNode = currentNextNode
                    }
                }
                
                nodesColumn.append(currentNode)
                if let currentOnLayerBelow = currentNode.downNode {
                    // step down on layer below
                    currentNode = currentOnLayerBelow
                }
            }
            
            // TODO: search for value will be the same as in search method
            // but for now it is almost copy paste
            
            // after finding of the very bottom layer and nearest node
            // need to check if it is node with a value or
            // check for value in next nodes
            var cnNode: SkipListNode? = currentNode
            var previousNode = currentNode
            while let indexNode = cnNode {
                if indexNode.value == v {
                    return
                }
                else if indexNode.value > v {
                    // 5, 6, 15 and we want insert 10
                    if previousNode === indexNode {
                        // unknown case - first element already greater than value
                        // but we don't know previous element, probably it is very first
                        // element like head
                        return
                    }
                    else {
                        // add fresh node on ground level first
                        let freshNode = SkipListNode(v: v)
                        previousNode.nextNode = freshNode
                        freshNode.nextNode = indexNode
                        let levelsAmountForNewNode = randomLevel()
                        var arrayIndex = 1
                        var savedNodeBelow = freshNode
                        // add fresh node on upper levels in accordance with randomly generated
                        // number of levels
                        while arrayIndex <= levelsAmountForNewNode && arrayIndex <= nodesColumn.count {
                            let upperNode = nodesColumn[nodesColumn.count - arrayIndex]
                            let reservedRightNode = upperNode.nextNode
                            let upperFreshNode = SkipListNode(v: v)
                            upperFreshNode.nextNode = reservedRightNode
                            upperFreshNode.downNode = savedNodeBelow
                            savedNodeBelow = upperFreshNode
                            upperNode.nextNode = upperFreshNode
                            arrayIndex += 1
                        }
                    }
                }
                previousNode = indexNode
                cnNode = indexNode.nextNode
            }
        }
        else {
            // need to insert before head and probably change the head
            
        }
    }
}
