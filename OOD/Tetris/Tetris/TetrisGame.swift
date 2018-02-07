//
//  TetrisGame.swift
//  Tetris
//
//  Created by Andrey Ermoshin on 31/01/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

protocol TetrisGame {
    func start()
    func finish()
    func pause()
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
    private let gameContext: Tetris2DContext<SimpleTetris2DStrategy>
    private var actionsQueue = Queue<ControlAction>()
    // to allow async adding actions to that queue above
    // and read it without race condition
    private let actionsLock = DispatchQueue(label: "actionsqueue")
    
    init(objectsFactory: Tetris2DObjectsAbstractFactory, area: TetrisGameArea2D, previousScore: GameScore? = nil) {
        if let cachedScore = previousScore {
            score = cachedScore
        }
        else {
            score = TetrisGameScore()
        }
        
        let strategy = SimpleTetris2DStrategy()
        gameContext = Tetris2DContext(strategy, objectsFactory, area)
    }
    
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
    
    func start() {
        // do until game over - no space for figures on area
        while true {
            if !gameContext.canContinuePlay() {
                break
            }
            gameContext.playRound()
        }
    }
    
    func finish() {
        
    }
    
    func pause() {
        
    }
    
    
}

