//
//  main.swift
//  TreeSet
//
//  Created by Andrey Ermoshin on 12/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation


let array = [5, 3, 8, 4, -1, 8, 6]
var root: TreeSet?
for (i, x) in array.enumerated() {
    if let r = root {
        r.insert(i, x)
    }
    else {
        root = TreeSet(i, x)
    }
}

//let f1 = root!.floor(-2)
//print("floor \(f1)") // nil
//let f2 = root!.floor(9)
//print("floor \(f2)") // 8
//let f3 = root!.floor(2)
//print("floor \(f3)") // -1
//let f4 = root!.floor(7)
//print("floor \(f4)") // 6
//let f5 = root!.floor(4)
//print("floor \(f5)") // 4
//let f6 = root!.floor(1)
//print("floor \(f6)") // -1


let c1 = root!.ceiling(-2)
print("ceiling \(c1)") // -1
let c2 = root!.ceiling(9)
print("ceiling \(c2)") // nil (10?)
let c3 = root!.ceiling(2)
print("ceiling \(c3)") // 3
let c4 = root!.ceiling(7)
print("ceiling \(c4)") // 8
let c5 = root!.ceiling(4)
print("ceiling \(c5)") // 4
let c6 = root!.ceiling(1)
print("ceiling \(c6)") // 3

