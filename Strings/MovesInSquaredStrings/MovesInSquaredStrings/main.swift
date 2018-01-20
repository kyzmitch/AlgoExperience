//
//  main.swift
//  MovesInSquaredStrings
//
//  Created by Andrey Ermoshin on 20/01/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

func horMirror(_ s: String) -> String {
    // create an array to allow change characters by index
    var result = Array(s)
    guard let lineEndIndex = s.index(of: "\n") else {
        return ""
    }
    let distance = s.distance(from: s.startIndex, to: lineEndIndex)
    let lineLength = Int(distance)
    let totalLength = result.count // Int(s.count)
    // print(#function + ": input count = \(s.count) vs array count = \(result.count)")
    let eol = Character("\n")
    let half = totalLength/2
    var skippedSymbolsAmount = 0
    for i in (0..<half) {
        let temp = result[i]
        if temp == eol {
            skippedSymbolsAmount += 1
            continue
        }
        let j = computeHorizontalMirroredIndex(for: i, totalLength, lineLength, skippedSymbolsAmount)
        result[i] = result[j]
        result[j] = temp
    }
    return String(result)
}
func vertMirror(_ s: String) -> String {
    // your code
    return ""
}
// replace the dots with function parameter
func oper( _ s: String) -> String {
    // your code
    return ""
}

func computeHorizontalMirroredIndex(for i: Int,_ totalLength: Int, _ lineLength: Int,_ skippedSymbolsAmount: Int) -> Int {
    // NOTE: need to make sure that '\n' characters
    // should not move on other places
    let shift = (i - skippedSymbolsAmount) / lineLength
    // - shift because skipped "\n"
    // to have identical indexes from left for example i = 0
    // so newI need to have also 0
    let newI = (i - skippedSymbolsAmount) % lineLength
    let j = totalLength - (1 + shift) * lineLength - skippedSymbolsAmount + newI
    return j
}

// Tests
let e = "ab\ncd"
let eHor = horMirror(e)
print("Horizontal mirror of string:\n\(e)\n\nis\n\n\(eHor)\n")

let s = "abcd\nefgh\nijkl\nmnop"
let hor = horMirror(s)
// Expected => "mnop\nijkl\nefgh\nabcd"
print("Horizontal mirror of string:\n\(s)\n\nis\n\n\(hor)")

