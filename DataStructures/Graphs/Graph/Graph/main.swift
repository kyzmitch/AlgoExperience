//
//  main.swift
//  Graph
//
//  Created by admin on 17/01/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

let g = Graph(4) // don't forget about that vertex (4) !!! it is without edges to neighbours
// and it's not printed using BFS
g.addEdge(from: 0, to: 1)
g.addEdge(from: 0, to: 2)
g.addEdge(from: 1, to: 2)
g.addEdge(from: 2, to: 0)
g.addEdge(from: 2, to: 3)
g.addEdge(from: 3, to: 3)

g.breadthFirstSearch(2) { (value, level) in
    print("\(level) - \(value)")
}

print("DFS")
g.depthFirstSearch { (value) in
    print("\(value)")
}

print("Another graph BFS")
let ga = Graph("s")
ga.addEdge(from: "s", to: "x")
ga.addEdge(from: "a", to: "z")
ga.addEdge(from: "s", to: "a")
ga.addEdge(from: "x", to: "d")
ga.addEdge(from: "x", to: "c")
ga.addEdge(from: "d", to: "c")
ga.addEdge(from: "c", to: "f")
ga.addEdge(from: "d", to: "f")
ga.addEdge(from: "c", to: "l")

ga.breadthFirstSearch("s") { (value, level) in
    print("\(level) - \(value)")
}
