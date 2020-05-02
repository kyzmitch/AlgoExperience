//
//  main.swift
//  Jewels and Stones
//
//  Created by Andrei Ermoshin on 5/2/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    func numJewelsInStones(_ J: String, _ S: String) -> Int {
        return usingHashTable(J, S)
    }
    
    func usingSDKStringType(_ J: String, _ S: String) -> Int {
        var count = 0
        for c in S {
            if J.contains(c) {
                count += 1
            }
        }
        return count
    }
    
    func usingHashTable(_ J: String, _ S: String) -> Int {
        var hashTable = Set<Character>()
        for c in J {
            hashTable.insert(c)
        }
        var count = 0
        for c in S {
            if hashTable.contains(c) {
                count += 1
            }
        }
        return count
    }
}
