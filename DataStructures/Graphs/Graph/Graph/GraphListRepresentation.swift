//
//  GraphListRepresentation.swift
//  Graph
//
//  Created by admin on 17/01/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

// This class represents a directed graph using
// adjacency list representation

class ListNode<T> {
    var edgeTo: T
    var next: ListNode?
    init(value: T) {
        edgeTo = value
    }
    
    func last() -> ListNode {
        var n: ListNode = self
        while n.next != nil  {
            n = n.next!
        }
        return n
    }
}

class NeighboursList<T> {
    var head: ListNode<T>?
    var end: ListNode<T>?
    
    func append(neighbourVertex: T) {
        let node = ListNode(value: neighbourVertex)
        if head == nil {
            head = node
            end = node
        }
        else {
            head?.last().next = node
            end = node
        }
    }
}

class Graph<T: Hashable> {
    var verticesCount: UInt = 0
    var adj = Dictionary<T, NeighboursList<T>>() // list of neighbors
    
    init(_ firstVertex: T) {
        verticesCount = 1
        adj[firstVertex] = NeighboursList()
    }
    
    func addEdge(from f: T, to s: T) {
        var list = adj[f]
        if list == nil {
            list = NeighboursList()
            adj[f] = list
            verticesCount += 1
        }
        list?.append(neighbourVertex: s)
    }
    
    func breadthFirstSearch(_ initialVertex: T, vertexHandler: ((T, UInt) -> Void)? = nil) {
        // handler should be not escaping
        
        // traversing, not real search
        // https://www.geeksforgeeks.org/breadth-first-traversal-for-a-graph/
        // https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-006-introduction-to-algorithms-fall-2011/lecture-videos/MIT6_006F11_lec13.pdf
        // time = E , E - number of edges for directed graphs
        // time = 2E for unidirected graphs
        // O(E)
        // O(V + E) , V - vertices, E - edges
        
        var level: [T: UInt] = [initialVertex: 0]
        var parent: [T : T?] = [initialVertex: nil]
        
        guard let handler = vertexHandler else { return  }
        handler(initialVertex, 0) // level
        
        var i = UInt(1)
        var frontier = [initialVertex] // # previous level, i − 1
        while frontier.count != 0 {
            var next = [T]() // next level, i
            for u in frontier {
                let neighboursList = adj[u]
                var nextNeigbourNode = neighboursList?.head
                while let v = nextNeigbourNode {
                    // check if vertex already visited on previous levels or not
                    if !level.keys.contains(v.edgeTo) {
                        level[v.edgeTo] = i
                        parent[v.edgeTo] = u
                        next.append(v.edgeTo)
                        handler(v.edgeTo, i)
                    }
                    nextNeigbourNode = v.next
                }
            }
            frontier = next
            i += 1
        }
    }
    
    private func dfsVisit(_ initialVertex: T, visitedVerticies: inout Dictionary<T, T?>, vertexHandler: @escaping (T) -> Void) {
        
        let neighboursList = adj[initialVertex]
        var nextNeigbourNode = neighboursList?.head
        while let n = nextNeigbourNode {
            if !visitedVerticies.keys.contains(n.edgeTo) {
                visitedVerticies[n.edgeTo] = initialVertex
                vertexHandler(n.edgeTo)
                dfsVisit(n.edgeTo, visitedVerticies: &visitedVerticies, vertexHandler: vertexHandler)
            }
            nextNeigbourNode = n.next
        }
    }
    
    func depthFirstSearch(vertexHandler: @escaping (T) -> Void) {
        // to visit all vertices
        var parent = Dictionary<T, T?>() // some vertex - is a key and value is parent

        for v in adj.keys {
            if !parent.keys.contains(v) {
                // let empty: T? = nil
                // parent[v] = empty // this works for Dictionary
                // but next doesn't and autocomplete prints T?? - double Optional
                // parent[v] = nil
                // and next works as needed
                parent[v] = Optional<T>.none
                vertexHandler(v)
                dfsVisit(v, visitedVerticies: &parent, vertexHandler: vertexHandler)
            }
        }
    }
    
    func bidirectionalSearch(from a: T, to b: T) -> [T] {
        // should return path with verticies
        // bidirectional search uses BFS
        
    }
}
