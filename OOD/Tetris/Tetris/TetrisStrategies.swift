//
//  TetrisStrategies.swift
//  Tetris
//
//  Created by Andrey Ermoshin on 06/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

// The next classes are actually seem like complication.
// If we want to have different behaviour for the game,
// for example, new figure can be selected randomly or
// it can be always the same.
// And also moving of the figure could be not only
// just by applying gravity force which changes Y coordinate to Y - 1
// and user actions like moving figure to the left or right
// but it could be sometimes jumping back on upper level
// (Y + 1) when player activates some bonus.

protocol Tetris2DGameStrategy {
    weak var dataSource: Tetris2DGameDataSource? {get set}
    
    func figureStartPosition(gameAreaSize: IntSize) -> IntPoint
    func createFigure(_ startPosition: IntPoint) -> Base2DFigure
    // all user actions (button presses), gravity and some abstract bonus forces
    func applyForcesTo(figure: Base2DFigure)
    
    func distanceFromFiguresHeapToAreaTopBorder() -> Int
}

// class protocol because I need to use weak reference for data source
protocol Tetris2DGameDataSource: class {
    func gameObjectsFactory() -> Tetris2DObjectsAbstractFactory
    func figuresHeap() -> Tetris2DFiguresHeap
}

class SimpleTetris2DStrategy: Tetris2DGameStrategy {
    
    weak var dataSource: Tetris2DGameDataSource?

    // MARK: Tetris2DGameStrategy
    
    func figureStartPosition(gameAreaSize: IntSize) -> IntPoint {
        let startPosition = IntPoint(gameAreaSize.width/2, gameAreaSize.height)
        return startPosition
        
    }
    
    func createFigure(_ startPosition: IntPoint) -> Base2DFigure {
        let newFigure = dataSource!.gameObjectsFactory().createRandomFigure(startCoordinate: startPosition)
        return newFigure
    }
    
    func applyForcesTo(figure: Base2DFigure) {
        // moving figure - new position and rotations
    }
    
    func distanceFromFiguresHeapToAreaTopBorder() -> Int {
        let figuresHeap = dataSource!.figuresHeap()
        return figuresHeap.maximumHeight()
    }
}

class Tetris2DContext<Strategy: Tetris2DGameStrategy>: Tetris2DGameDataSource {
    
    // unfortunately strategy field was changed from let to var
    // because changing data source of it during initialization is
    // not allowed by compiler even if it is optional
    var strategy: Strategy
    let objectsFactory: Tetris2DObjectsAbstractFactory
    let tetrisFiguresHeap: Tetris2DFiguresHeap
    let gameAreaSize: IntSize
    let gameArea: TetrisGameArea2D
    
    init(_ strat: Strategy, _ gameObjectsFactory: Tetris2DObjectsAbstractFactory, _ tetrisGameArea: TetrisGameArea2D) {
        gameArea = tetrisGameArea
        gameAreaSize = gameArea.size
        tetrisFiguresHeap = gameArea.figuresHeap()
        objectsFactory = gameObjectsFactory
        strategy = strat
        strategy.dataSource = self
    }
    
    func canContinuePlay() -> Bool {
        let heapHeight = strategy.distanceFromFiguresHeapToAreaTopBorder()
        if heapHeight >= gameAreaSize.height {
            return false
        }
        else {
            return true
        }
    }
    
    func playRound() {
        let roundStartPosition = strategy.figureStartPosition(gameAreaSize: gameAreaSize)
        let figure = strategy.createFigure(roundStartPosition)
        while gameArea.canMove(figure: figure) {
            
        }
    }
    
    // MARK: Tetris2DGameDataSource
    
    func gameObjectsFactory() -> Tetris2DObjectsAbstractFactory {
        return objectsFactory
    }
    
    func figuresHeap() -> Tetris2DFiguresHeap {
        return tetrisFiguresHeap
    }
}

