//
//  main.swift
//  RemoveDuplicatesInSortedList
//
//  Created by Andrey Ermoshin on 08/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    func push(_ v: Int) {
        var i: ListNode? = self
        var last: ListNode = self
        while let index = i {
            last = index
            i = index.next
        }
        let freshNode = ListNode(v)
        last.next = freshNode
    }
}

class Solution {
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        // This works only for sorted list
        var index = head
        while index != nil {
            if let newNext = index!.next {
                if index!.val == newNext.val {
                    // need to find fixed next node for current index
                    var secondIndex: ListNode? = newNext
                    var fixedNext: ListNode?
                    while let second = secondIndex {
                        if let secondNext = second.next {
                            if second.val != secondNext.val {
                                fixedNext = secondNext
                                break
                            }
                            else {
                                secondIndex = secondIndex?.next
                                // next iteration on 2nd cycle
                            }
                        }
                        else {
                            // it is when you found duplicate
                            // but after it nil is following
                            // so it is end
                            fixedNext = nil
                            break
                        }
                    }
                    index?.next = fixedNext
                    index = fixedNext
                    // next iteration on 1st cycle
                }
                else {
                    // continue
                    index = newNext
                }
            }
            else {
                break
            }
        }
        return head
    }
}

extension ListNode: CustomStringConvertible {
    public var description: String {
        var result = "Description: \n"

        var index = self
        result.append("\(index.val), ")
        while index.next != nil {
            index = index.next!
            result.append("\(index.val), ")
        }
        return result
    }
}

let sortedList = ListNode(50)
sortedList.push(50)
sortedList.push(30)
sortedList.push(30)
sortedList.push(21)
sortedList.push(11)
sortedList.push(11)
sortedList.push(11)
sortedList.push(5)

let solver = Solution()
if let resultList = solver.deleteDuplicates(sortedList) {
    print(resultList.description)
}

