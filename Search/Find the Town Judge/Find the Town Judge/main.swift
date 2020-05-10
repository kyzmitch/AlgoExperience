//
//  main.swift
//  Find the Town Judge
//
//  Created by Andrei Ermoshin on 5/10/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    func findJudge(_ N: Int, _ trust: [[Int]]) -> Int {
        guard N != 1 else {
            return 1
        }
        var person = 0
        var trustsTo = 0
        var trustedPeople = [Int: Int]()
        var allPeople = Set<Int>()
        
        for j in 0..<trust.count {
            person = trust[j][0]
            allPeople.insert(person)
            trustsTo = trust[j][1]
            if let howMany = trustedPeople[trustsTo] {
                trustedPeople[trustsTo] = howMany + 1
            } else {
                trustedPeople[trustsTo] = 1
            }
        }
        
        // The town judge trusts nobody.
        for p in allPeople {
            trustedPeople[p] = nil
        }
        guard !trustedPeople.isEmpty else {
            return -1
        }
        // Everybody (except for the town judge) trusts the town judge.
        let peopleCount = allPeople.count
        let rightNums = trustedPeople.filter { $0.value == peopleCount}.keys
        // There is exactly one person that satisfies properties 1 and 2.
        guard rightNums.count == 1 else {
            return -1
        }
        return rightNums.first!
    }
}
