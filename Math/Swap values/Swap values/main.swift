//
//  main.swift
//  Swap values
//
//  Created by Andrey Ermoshin on 15/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

func customSwap(_ l: inout Int, _ r: inout Int) {
    l = l + r
    r = l - r
    l = l - r
}

var m = 5
var n = 8
print("Before swap: m = \(m) n = \(n)")
customSwap(&m, &n)
print("Before swap: m = \(m) n = \(n)")

