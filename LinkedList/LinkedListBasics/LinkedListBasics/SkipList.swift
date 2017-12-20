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
        return Float(randomNumber(inRange: 1...100))/Float(100)
    }
}

public func randomNumber<T : SignedInteger>(inRange range: ClosedRange<T> = 1...6) -> T {
    let length = Int64(range.upperBound - range.lowerBound + 1)
    let value = Int64(arc4random()) % length + Int64(range.lowerBound)
    return T(value)
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
                
                // TODO: Instead of simple array it's better to use stack
                nodesColumn.append(currentNode)
                if let currentOnLayerBelow = currentNode.downNode {
                    // step down on layer below
                    currentNode = currentOnLayerBelow
                }
            }
            
            if nodesColumn.count == 0 {
                nodesColumn.append(head)
            }
            
            // TODO: search for value will be the same as in search method
            // but for now it is almost copy paste
            
            // after finding of the very bottom layer and nearest node
            // need to check if it is node with a value or
            // check for value in next nodes
            var groundIndexNode: SkipListNode? = currentNode
            var previousNode = currentNode
            var inserted = false
            while groundIndexNode != nil {
                if groundIndexNode!.value == v {
                    return
                }
                else if groundIndexNode!.value > v {
                    // 5, 6, 15 and we want insert 10
                    if previousNode === groundIndexNode! {
                        // unknown case - first element already greater than value
                        // but we don't know previous element, probably it is very first
                        // element like head
                        return
                    }
                    else {
                        // add fresh node on ground level first
                        let freshNode = SkipListNode(v: v)
                        previousNode.nextNode = freshNode
                        freshNode.nextNode = groundIndexNode
                        let levelsAmountForNewNode = randomLevel()
                        var arrayIndex = 1
                        var savedNodeBelow = freshNode
                        // add fresh node on upper levels in accordance with randomly generated
                        // number of levels
                        while arrayIndex <= levelsAmountForNewNode {
                            // existed number of levels could be less than randomly generated
                            // so, need to check out of bound error
                            var upperNode: SkipListNode<T>
                            // TODO: this is actually to hard way of implementation
                            // I've found after this brute force solution
                            // that it is optimal and with less amount of code
                            // need to insert from top levels from fastest level to bottom ground level
                            
                            // SO, better to reimplement insert method from the scratch
                            if arrayIndex > 0 && nodesColumn.count >= arrayIndex {
                                upperNode = nodesColumn[nodesColumn.count - arrayIndex]
                            }
                            else {
                                upperNode = SkipListNode(v: v)
                            }
                            let reservedRightNode = upperNode.nextNode
                            let upperFreshNode = SkipListNode(v: v)
                            upperFreshNode.nextNode = reservedRightNode
                            upperFreshNode.downNode = savedNodeBelow
                            savedNodeBelow = upperFreshNode
                            upperNode.nextNode = upperFreshNode
                            arrayIndex += 1
                        }
                        inserted = true
                    }
                }
                previousNode = groundIndexNode!
                // need to allow exit from the loop
                groundIndexNode = groundIndexNode?.nextNode
            }
            
            if !inserted {
                // it seems it is value which is greater than any value on the level
                let freshNode = SkipListNode(v: v)
                previousNode.nextNode = freshNode
            }
        }
        else {
            // need to insert before head and probably change the head
            // Need to find ground version of head
            var currentNode: SkipListNode? = head
            var headColumn = [SkipListNode<T>]()
            headColumn.append(head)
            while let bottomHeadNode = currentNode?.downNode {
                currentNode = bottomHeadNode
                headColumn.append(bottomHeadNode)
            }
            
            let freshNode = SkipListNode(v: v)
            freshNode.nextNode = currentNode // ground head node
            // now need to change top head to fresh one
            var arrayIndex = 1
            var nodeBelow = freshNode
            // Also need o determine what to do with previous head
            // how many levels need to save for previous old head
            let levelsAmountForOldHead = randomLevel()
            var currentOldHeadLevel = 1
            // declaring outside the loop to have reference to replace head at the end
            var upperFreshNode = freshNode

            while arrayIndex <= headColumn.count {
                let upperHeadNode = headColumn[headColumn.count - arrayIndex]
                upperFreshNode = SkipListNode(v: v)
                currentOldHeadLevel += 1
                // connect with head as a next node from the right
                // by skipping old head on certain level
                if currentOldHeadLevel <= levelsAmountForOldHead {
                    upperFreshNode.nextNode = upperHeadNode
                }
                else {
                    // save old head as a next node from right
                    upperFreshNode.nextNode = upperHeadNode.nextNode
                    // To fix retain cycle of old head nodes on different levels
                    // to delete old heads on some levels
                    upperHeadNode.downNode = nil
                    upperHeadNode.nextNode = nil
                    break
                }
                upperFreshNode.downNode = nodeBelow
                nodeBelow = upperFreshNode
                arrayIndex += 1
            }
            
            // finish
            head = upperFreshNode
        }
    }
}

extension SkipList: CustomStringConvertible {
    var description: String {
        var result = "Description:\n"
        var levelHead: SkipListNode? = head
        while levelHead != nil {
            var next = levelHead?.nextNode
            var levelDesc = "\(levelHead!.value)-"
            while next != nil {
                levelDesc.append("\(next!.value)-")
                next = next?.nextNode
            }
            result.append("\(levelDesc)\n")
            levelHead = levelHead?.downNode
        }
        return result
    }
}
