//
//  main.swift
//  Valid Parentheses
//
//  Created by Andrey Ermoshin on 12/03/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// Given a string containing just the characters '(', ')', '{', '}', '[' and ']',
// determine if the input string is valid.
//
// The brackets must close in the correct order,
// "()" and "()[]{}" are all valid but "(]" and "([)]" are not.

extension Character {
    func isOpenBracket() -> Bool {
        if self == "[" || self == "(" || self == "{" {
            return true
        }
        else {
            return false
        }
    }
    
    
}

class Solution {
    func isValid(_ s: String) -> Bool {
        var stack = [Character]()
        for c in s {
            if let last = stack.last {
                switch c {
                case let x where x.isOpenBracket() == true:
                    stack.append(x)
                    continue
                case "]":
                    if last != "[" {
                        return false
                    }
                case ")":
                    if last != "(" {
                        return false
                    }
                case "}":
                    if last != "{" {
                        return false
                    }
                default:
                    // unsupported character
                    return false
                }
                stack.removeLast()
            }
            else {
                if c.isOpenBracket() {
                    stack.append(c)
                }
                else {
                    // defenetly not valid because closed bracket in that case
                    // is not possible to remove
                    return false
                }
            }
        }
        
        return stack.count == 0
    }
}

let solver = Solution()
let input1 = "()[]{}"
print("Valid Parentheses \(input1) is \(solver.isValid(input1))") // true
let input22 = "(]"
print("Valid Parentheses \(input22) is \(solver.isValid(input22))") // false
let input2 = "([)]"
print("Valid Parentheses \(input2) is \(solver.isValid(input2))") // false
let input3 = "([{}])"
print("Valid Parentheses \(input3) is \(solver.isValid(input3))") // true?
let input4 = "({[])"
print("Valid Parentheses \(input4) is \(solver.isValid(input4))") // false
let input5 = "({[]()})"
print("Valid Parentheses \(input5) is \(solver.isValid(input5))") // true
