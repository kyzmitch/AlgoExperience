//
//  main.swift
//  Roman to Integer
//
//  Created by Andrei Ermoshin on 21/10/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

import Foundation

// I can be placed before V (5) and X (10) to make 4 and 9.
// X can be placed before L (50) and C (100) to make 40 and 90.
// C can be placed before D (500) and M (1000) to make 400 and 900.

/*
 Example 1:

 Input: "III"
 Output: 3
 Example 2:

 Input: "IV"
 Output: 4
 Example 3:

 Input: "IX"
 Output: 9
 Example 4:

 Input: "LVIII"
 Output: 58
 Explanation: L = 50, V= 5, III = 3.
 Example 5:

 Input: "MCMXCIV"
 Output: 1994
 Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
 */

class Solution {
    private enum Digit: RawRepresentable {
        var rawValue: Character {
            switch self {
            case .M: return "M"
            case .D: return "D"
            case .C: return "C"
            case .L: return "L"
            case .X: return "X"
            case .V: return "V"
            case .I: return "I"
            }
        }

        typealias RawValue = Character

        case M // 1000
        case D // 500
        case C // 100
        case L // 50
        case X // 10
        case V // 5
        case I // 1

        init?(rawValue: Character) {
            switch rawValue {
            case "M": self = .M
            case "D": self = .D
            case "C": self = .C
            case "L": self = .L
            case "X": self = .X
            case "V": self = .V
            case "I": self = .I
            default: return nil
            }
        }
    } // enum

    func romanToInt(_ s: String) -> Int {
        var result: Int = 0
        var i = s.startIndex
        var prevC: Digit?
        while i != s.endIndex {
            let c = Digit(rawValue: s[i])
            switch c {
            case .I?:
                result += 1
            case .V?:
                switch prevC {
                case .I?:
                    result += 3
                default:
                    result += 5
                }
            case .X?:
                switch prevC {
                case .I?:
                    result += 8
                default:
                    result += 10
                }
            case .L?:
                switch prevC {
                case .X?:
                    result += 30
                default:
                    result += 50
                }
            case .C?:
                switch prevC {
                case .X?:
                    result += 80
                default:
                    result += 100
                }
            case .D?:
                switch prevC {
                case .C?:
                    result += 300
                default:
                    result += 500
                }
            case .M?:
                switch prevC {
                case .C?:
                    result += 800
                default:
                    result += 1000
                }
            default:
                print("unexpected char \(s[i])")
                break
            } //switch

            prevC = c
            i = s.index(i, offsetBy: 1)
        } // while
        return result
    }
}

let s = Solution()
print("\(s.romanToInt("III"))")
print("\(s.romanToInt("IV"))")
print("\(s.romanToInt("IX"))")
print("\(s.romanToInt("LVIII"))") // 58
print("\(s.romanToInt("MCMXCIV"))") // 1994

