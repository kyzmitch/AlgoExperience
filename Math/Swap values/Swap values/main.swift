//
//  main.swift
//  Swap values
//
//  Created by Andrey Ermoshin on 15/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

func customSwap(_ l: inout Int, _ r: inout Int) {
    // WARNING: will not work with integer overflow
    l = l + r
    r = l - r
    l = l - r
    // in the C programming language always works even in case
    // of integer overflow, since, according to the C standard,
    // addition and subtraction of unsigned integers follow the
    // rules of modular arithmetic
}

func customXorSwap(_ l: inout Int, _ r: inout Int) {
    // https://en.wikipedia.org/wiki/XOR_swap_algorithm

/*
    A    B    XOR
    0    0    0
    0    1    1
    1    0    1
    1    1    0
 */
    l = l ^ r // eg l = 1 (01), r = 2 (10), l = 11
    r = r ^ l // r = 10 ^ 11 = 01 - returns back initial value of l
    l = l ^ r // l = 11 ^ 01 = 10 - returns original value of r
}

var m = 5
var n = 8
print("Before swap: m = \(m) n = \(n)")
customSwap(&m, &n)
print("After swap: m = \(m) n = \(n)")
customXorSwap(&m, &n)
print("After xor swap: m = \(m) n = \(n)")

var x = 3
var y = 3
print("Before swap: \(x) \(y)")
customSwap(&x, &y)
print("After swap: \(x) \(y)")
customXorSwap(&x, &y)
print("After xor swap: \(x) \(y)")

// but can't use for very big values
var i = Int.max - 2
var j = Int.max
print("Before swap: \(i) \(j)")
swap(&i, &j)
// most likely native swap uses temp variable
print("After native swap: \(i) \(j)")
swap(&i, &j)
// NOTE: can't do inplace swap for very big integers
// because sum can exceed Int.max and the same for negatives
customSwap(&i, &j)
print("After swap: \(i) \(j)")
