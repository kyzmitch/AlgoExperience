//
//  TetrisGameArea.swift
//  Tetris
//
//  Created by Andrey Ermoshin on 07/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation


protocol Tetris2DFiguresHeap: class {
    init(width: Int)
    func maximumHeight() -> Int
    func occupiedMaxLevelFor(_ x: Int) -> Int
}

class Crayzy2DTetrisFiguresHeap: Tetris2DFiguresHeap {
    var maxLevels: Array<Int>
    let heapWidth: Int
    
    required init(width: Int) {
        heapWidth = width
        // must be array with constant amount of elements == width of the area
        // so, probably better to prepare adapter around simple Array
        maxLevels = Array(repeating: 0, count: width)
    }
    
    func maximumHeight() -> Int {
        var max: Int = 0
        for level in maxLevels {
            if level > max {
                max = level
            }
        }
        return max
    }
    
    func occupiedMaxLevelFor(_ x: Int) -> Int {
        return maxLevels[x]
    }
}

// Probably game area should operate only
// by figure and heap
// and heap should operate by points
// because one figure can contains several points
// for example square == 4 points
// and need to take into account positions
// of these points because they are different for
// square and for line and for others

protocol TetrisGameArea2D: class {
    var size: IntSize {get set}
    func figuresHeap() -> Tetris2DFiguresHeap
    init(areaSize: IntSize)
    func canMove(figure: Base2DFigure) -> Bool
}

class CrayzyTetrisGameArea2D: TetrisGameArea2D {
    var size: IntSize
    let heap: Crayzy2DTetrisFiguresHeap
    
    required init(areaSize: IntSize = IntSize(100, 512)) {
        size = areaSize
        heap = Crayzy2DTetrisFiguresHeap(width: size.width)
    }
    
    func figuresHeap() -> Tetris2DFiguresHeap {
        return heap
    }
    
    func canMove(figure: Base2DFigure) -> Bool {
        
    }
}

