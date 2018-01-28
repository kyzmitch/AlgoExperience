//
//  main.swift
//  StringReverse
//
//  Created by Andrey Ermoshin on 21/01/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

extension String {
    mutating func recursiveReverse() -> Void {
        if count < 2 {
            return
        }
        let middleLength = self.count / 2
        // NOTE: note efficient way to recurse String
        // it is need to create copy by using Array
        // so, it seems there is no possibility
        // to do in-place recursion/mutating
        // because subscript on String is get only
        var tempArray: Array<String.Element> = Array(self)
        internalReverse(0, middleLength, &tempArray)
    }
    
    private mutating func internalReverse(_ i: Int,_ middleIndex: Int,_ array: inout Array<String.Element>) {
        
        let temp = array[i]
        let distance = middleIndex - i
        let j = i + 2 * distance
        array[i] = array[j]
        array[j] = temp
        let nextIndex = i + 1
        if nextIndex == middleIndex {
            self = String(array)
            return
        }
        else {
            internalReverse(nextIndex, middleIndex, &array)
        }
    }
}

var s = "abcde"
s.recursiveReverse()
print("Reverse: \(s)")

func reverseString(_ s: String) -> String {
    var str = Array(s)
    var result = ""
    for i in 0..<str.count {
        result.append(str[str.count - 1 - i])
    }
    return result
}

print("String: \"hello\", reversed: \(reverseString("hello"))")
