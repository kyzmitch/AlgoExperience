//
//  TetrisGame.swift
//  Tetris
//
//  Created by Andrey Ermoshin on 31/01/2018.
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
    var position: IntPoint {get set}
    // TODO: size
    func moveLeft()
    func moveRight()
    func rotateLeft()
    func rotateRight()
    
    init(_ start: IntPoint)
}

// better to use base class for standart methods

class BaseFigure: Figure2D {
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

class DotFigure2D: BaseFigure {
    
}

class SquareFigure: BaseFigure {
    
}

class Line2DFigure: BaseFigure {
    
}

class G2DFigure: BaseFigure {
    
}

protocol Figure3D {
    associatedtype Position // point with 3rd additional coordinate Z
    func moveLeft()
    func moveRight()
    func moveForward()
    func moveBack()
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
    func createTetrisFigure(figureType: FigureType, startCoordinate: IntPoint) -> BaseFigure
    func createRandomFigure(startCoordinate: IntPoint) -> BaseFigure
}

class CrayzyTetris2DFiguresFactory: Tetris2DObjectsAbstractFactory {
    
    typealias FType = FigureType
    typealias FObjectType = BaseFigure
    
    func createTetrisFigure(figureType: FigureType, startCoordinate: IntPoint) -> BaseFigure {
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
    
    func createRandomFigure(startCoordinate: IntPoint) -> BaseFigure {
        let randomFigureNumber = arc4random_uniform(3);
        if let enumFigureType = FigureType(rawValue: UInt8(randomFigureNumber)) {
            return createTetrisFigure(figureType: enumFigureType, startCoordinate: startCoordinate)
        }
        else {
            return createTetrisFigure(figureType: .square, startCoordinate: startCoordinate)
        }
    }
}

protocol TetrisFiguresHeap {
    // to check every x of the figure if at least one of lowest y of x (figure border)
    // touches heap border
    func willTouch(figure: Figure2D) -> Bool
    // make heap bigger with using points used by figure
    // but only if it touches the heap
    func merge(with figure: Figure2D, on position: IntPoint)
    
}

protocol TetrisGameArea2D {
    var size: IntSize {get set}
    init(areaSize: IntSize)
    func occupiedMaxLevelFor(_ x: Int) -> Int
}

struct CrayzyTetrisGameArea2D: TetrisGameArea2D {
    var size: IntSize
    var maxLevels: Array<Int>
    init(areaSize: IntSize = IntSize(100, 700)) {
        size = areaSize
        // must be array with constant amount of elements == width of the area
        // so, probably better to prepare adapter around simple Array
        maxLevels = Array(repeating: 0, count: size.width)
    }
    func occupiedMaxLevelFor(_ x: Int) -> Int {
        return maxLevels[x]
    }
    
    
}

protocol TetrisGame {
    func start()
    func finish()
    func pause()
}

protocol GameScore {
    var points: UInt {get set}
}

struct TetrisGameScore: GameScore {
    var points: UInt = 0
}

enum Direction {
    case left, right
}

enum ControlAction {
    case move(Direction)
    case rotate(Direction)
}

enum ArrowKeys {
    case left, right, up, down
}

// Need to pass Crayzy2DTetrisGame or another game object
// implementation to some another object which conforms to ActionsListener
// protocol to get events(button presses) from OS
protocol ActionsListener {
    func handleKey(key: ArrowKeys)
}

class Crayzy2DTetrisGame: TetrisGame, ActionsListener {
    private let score: GameScore
    enum TetrisState {
        case paused, playing, readyForNewGame
    }
    private var state: TetrisState = .readyForNewGame
    private let gameObjectsFactory: Tetris2DObjectsAbstractFactory
    private let gameArea: TetrisGameArea2D
    private var actionsQueue = Queue<ControlAction>()
    // to allow async adding actions to that queue above
    // and read it without race condition
    private let actionsLock = DispatchQueue(label: "actionsqueue")
    
    func handleKey(key: ArrowKeys) {
        if key == .left || key == .right {
            actionsLock.async { [weak self] in
                let direction = (key == .left ? Direction.left : Direction.right)
                self?.actionsQueue.enqueue(.move(direction))
            }
        }
        else if key == .up || key == .down {
            actionsLock.async { [weak self] in
                let direction = (key == .down ? Direction.left : Direction.right)
                self?.actionsQueue.enqueue(.rotate(direction))
            }
        }
    }
    
    init(objectsFactory: Tetris2DObjectsAbstractFactory, area: TetrisGameArea2D, previousScore: GameScore? = nil) {
        if let cachedScore = previousScore {
            score = cachedScore
        }
        else {
            score = TetrisGameScore()
        }
        gameObjectsFactory = objectsFactory
        gameArea = area
    }
    
    func start() {
        // do until game over - no space for figures on area
        while true {
            // 1) check if it's possible to continue play the game
            
            // drop one figure
            let startPosition = IntPoint(gameArea.size.width/2, gameArea.size.height)
            let newFigure = gameObjectsFactory.createRandomFigure(startCoordinate: startPosition)
            
        }
    }
    
    func finish() {
        
    }
    
    func pause() {
        
    }
    
    
}
