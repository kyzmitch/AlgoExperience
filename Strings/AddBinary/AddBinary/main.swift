//
//  main.swift
//  AddBinary
//
//  Created by Andrei Ermoshin on 8/10/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    func addBinary(a: String, _ b: String) -> String {
        var res = ""
        var pA = a.count - 1, pB = b.count - 1
        let listA = Array(a), listB = Array(b)
        var carry = 0
        
        while pA >= 0 || pB >= 0 || carry > 0 {
          let valueA = pA >= 0 ? listA[pA].wholeNumberValue! : 0
          let valueB = pB >= 0 ? listB[pB].wholeNumberValue! : 0

          let sum = valueA + valueB + carry
          carry = (sum > 1) ? 1: 0
          let reminder = "\(sum % 2)"
          res = reminder + res

          pA -= 1
          pB -= 1
        }
        return res
    }
    
    func addBinaryFailedTests(_ a: String, _ b: String) -> String {
        let aa = Array(a)
        let bb = Array(b)
        let an = aa.count
        let bn = bb.count
        let m: Int
        let max: Int
        let aIsMax: Bool
        if an < bn {
            m = an
            max = bn
            aIsMax = false
        } else if an > bn {
            m = bn
            max = an
            aIsMax = true
        } else {
            // equals
            m = bn
            max = bn
            aIsMax = true // doesn't matter how to initialize
        }
        
        var i = m - 1
        
        var tmp = 0
        var result = Array<Character>()
        // first common part with same length
        while i >= 0 {
            let l = aa[aIsMax ? an - m + i : i] == "0" ? 0 : 1
            let r = bb[aIsMax ? i : bn - m + i] == "0" ? 0 : 1
            switch (l, r, tmp) {
                case (1, 1, let n):
                    if n == 0 {
                        tmp += 1
                        result.insert("0", at: 0)
                    } else {
                        tmp += 1
                        result.insert("1", at: 0)
                    }
                    
                case (1, 0, 1), (0, 1, 1):
                    tmp -= 1
                    result.insert("0", at: 0)
                case (1,0,0), (0,1,0):
                    result.insert("1", at: 0)
                case (0, 0, let n):
                    if n == 0 {
                        result.insert("0", at: 0)
                    } else {
                        tmp -= 1
                        result.insert("1", at: 0)
                    }
                case (_, _, _):
                    // not possible case because l and r can't be non 0 or non 1 numbers
                    break
            }
            i -= 1
        }
        
        // remaining part of longest input
        i = max - m - 1
        while i >= 0 {
            let v = (aIsMax ? aa[i] : bb[i]) == "0" ? 0 : 1
            switch (v, tmp) {
            case (1, _):
                if tmp == 0 {
                    result.insert("1", at: 0)
                } else if tmp == 1 {
                    // tmp -= 1 don't remove
                    result.insert("0", at: 0)
                }
            case (0, _):
                if tmp == 0 {
                    if i > 0 {
                        result.insert("0", at: 0)
                    } else {
                        break
                    }
                } else {
                    tmp -= 1
                    result.insert("1", at: 0)
                }
            case (_, _):
                break // not possible
            }
            i -= 1
        }
        
        if tmp != 0 {
            result.insert("1", at: 0)
        }
        return String(result)
    }
}

let sol = Solution()
let r1 = sol.addBinary("100", "110010")
print(r1)

