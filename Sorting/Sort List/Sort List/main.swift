//
//  main.swift
//  Sort List
//
//  Created by Andrey Ermoshin on 10/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// Sort a linked list in O(n log n) time using constant space complexity.

public class ListNode {
      public var val: Int
      public var next: ListNode?
      public init(_ val: Int) {
          self.val = val
          self.next = nil
      }
}

let solver = Solution()
let list = ListNode(10)

let input =   [652,6686,827,12361,3255,16237,12521,18119,-3734,16499,15868,10684,17520,5995,7791,5454,-2519,139,7650,17842,4898,7022,-7290,-8893,-1605,-1522,3352,4825,12509,922,4716,17811,15247,-680,2387,4844,-7911,623,3397,2932,-8086,3556,12464,7139,11727,4978,370,4633,5889,17123,3020,-294,-4909,5537,-5309,-7190,11247,2711,13295,-5719,-5152,10938,4060,11278,17722,-833,9783,17235,2167,19751,7056,9085,3664,1247,3943,8885,-8637,10813,7472,3877,-9668,2242,730,-9561,-6595,10001,10945,9377,-9871,-1332,1615,-4710,12800]

var iterator: ListNode? = list
for x in input {
    iterator?.next = ListNode(x)
    iterator = iterator?.next
}

let sortedList = solver.sortList(list)
print("after sorting")
