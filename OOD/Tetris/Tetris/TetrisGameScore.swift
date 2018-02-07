//
//  TetrisGameScore.swift
//  Tetris
//
//  Created by Andrey Ermoshin on 07/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation


protocol GameScore {
    var points: UInt {get set}
}

struct TetrisGameScore: GameScore {
    var points: UInt = 0
}
