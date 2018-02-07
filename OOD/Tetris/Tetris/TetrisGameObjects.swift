//
//  TetrisGameObjects.swift
//  Tetris
//
//  Created by Andrey Ermoshin on 06/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// one integer is the size of the minimum width or height for tetris figure
struct IntPoint {
    let x: Int
    let y: Int
    init(_ xx: Int, _ yy: Int) {
        x = xx
        y = yy
    }
}

struct IntSize {
    let width: Int
    let height: Int
    init(_ w: Int, _ h: Int) {
        width = w
        height = h
    }
}

protocol Figure2D: class {
    associatedtype Position
    // point with 3rd additional coordinate Z will be used for 3D figure
    var position: Position {get set}
    // TODO: size
    func moveLeft()
    func moveRight()
    func rotateLeft()
    func rotateRight()
    
    init(_ start: Position)
}

// better to use base class for standart methods

class Base2DFigure: Figure2D {
    typealias Position = IntPoint
    var position: IntPoint
    required init(_ start: IntPoint) {
        position = start
    }
    func moveLeft() {
        
    }
    
    func moveRight() {
        
    }
    
    func rotateLeft() {
        
    }
    
    func rotateRight() {
        
    }
}

// better to use reference types even for these kind of
// small model objects because they will be transferred by reference
// a lot of times during game main events loop

class DotFigure2D: Base2DFigure {
    
}

class SquareFigure: Base2DFigure {
    
}

class Line2DFigure: Base2DFigure {
    
}

class G2DFigure: Base2DFigure {
    
}

// To follow solid - interface segregation principle
// it is better to create completely new protocol
// which will not be used by tetris 2d game
// at the same time according open/closed
// it's not needed to change figure for 2d protocol
// but need to extend it
protocol Figure3D: Figure2D {
    func rotateLeft()
    func rotateRight()
    func rotateBack()
    func rotateForward()
}

enum FigureType: UInt8 {
    case dot = 0, square, line, g
}

protocol Tetris2DObjectsAbstractFactory: class {
    // factory method
    func createTetrisFigure(figureType: FigureType, startCoordinate: IntPoint) -> Base2DFigure
    func createRandomFigure(startCoordinate: IntPoint) -> Base2DFigure
}

class CrayzyTetris2DFiguresFactory: Tetris2DObjectsAbstractFactory {
    
    typealias FType = FigureType
    typealias FObjectType = Base2DFigure
    
    func createTetrisFigure(figureType: FigureType, startCoordinate: IntPoint) -> Base2DFigure {
        // TODO: start coordinate strongly coupled to IntPoint
        // and at the same time could be not equal by type
        // with coordinate type used for figure
        // so, need to know how to use swift protocol constraints here
        
        switch figureType {
        case .dot:
            let d = DotFigure2D(startCoordinate)
            return d
        case .square:
            let c = SquareFigure(startCoordinate)
            return c
        case .line:
            let l = Line2DFigure(startCoordinate)
            return l
        case .g:
            let g = G2DFigure(startCoordinate)
            return g
        }
    }
    
    func createRandomFigure(startCoordinate: IntPoint) -> Base2DFigure {
        let randomFigureNumber = arc4random_uniform(3);
        if let enumFigureType = FigureType(rawValue: UInt8(randomFigureNumber)) {
            return createTetrisFigure(figureType: enumFigureType, startCoordinate: startCoordinate)
        }
        else {
            return createTetrisFigure(figureType: .square, startCoordinate: startCoordinate)
        }
    }
}

