//
//  main.swift
//  Remove K Digits
//
//  Created by Andrei Ermoshin on 5/13/20.
//  Copyright © 2020 Andrei Ermoshin. All rights reserved.
//

import Foundation

class Solution {
    func notWorkingRemoveKdigits(_ num: String, _ k: Int) -> String {
        // only 16 test cases from 30
        let count = num.distance(from: num.startIndex, to: num.endIndex)
        let m = count - k
        guard m > 0 else {
            return "0"
        }
        var i = num.startIndex
        var iteration = 0
        var NUM = num
        while iteration < k {
            var j = 0
            var max = Int.min
            var maxIndex = i
            while j < k {
                let cValue = NUM[i].wholeNumberValue!
                if max < cValue {
                    max = cValue
                    maxIndex = i
                }
                i = NUM.index(after: i)
                j += 1
            }
            NUM.remove(at: maxIndex)
            i = NUM.startIndex
            iteration += 1
        }
        if NUM.isEmpty {
            return "0"
        } else {
            while NUM.count > 1 && NUM.first! == "0" {
                NUM.removeFirst()
            }
            return NUM
        }
    }
    
    func removeKdigits(_ num: String, _ k: Int) -> String {
        let count = num.distance(from: num.startIndex, to: num.endIndex)
        if k > count || count == 0 {
            return "0"
        }

        var kDigits = k
        var stack = [Character]()
        var i = num.startIndex
        // some default character
        var digit: Character = " "
        while i < num.endIndex {
            digit = num[i]
            // if previous is bigger than current
            // e.g. 1, 4, 3 and 4 will be removed if 3 is a current one
            while kDigits > 0 && !stack.isEmpty && stack.last! > digit {
                stack.removeLast()
                kDigits -= 1
            }
            i = num.index(after: i)
            stack.append(digit)
        }
    
        // to handle case when k > 0, but nothing was removed
        // during previous step, because it was 1 element
        // or because every new element was bigger than previous one
        for _ in 0..<kDigits {
            stack.removeLast()
        }
        while !stack.isEmpty && stack.first! == "0" {
            stack.removeFirst()
        }
    
        if stack.isEmpty {
            return "0"
        }
        return String(stack)
    }
}

let s = Solution()
let res = s.removeKdigits("10", 1)
print("answer: \(res)")
