//
//  main.swift
//  Ransom Note
//
//  Created by Andrei Ermoshin on 5/3/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        var d: [Character: UInt] = [:]
        for c in magazine {
            guard let n = d[c] else {
                d[c] = 1
                continue
            }
            d[c] = n + 1
        }
        
        for c in ransomNote {
            guard let n = d[c] else {
                return false
            }
            guard n != 0 else {
                return false
            }
            d[c] = n - 1
        }
        return true
    }
}

