//
//  main.swift
//  Tetris
//
//  Created by Andrey Ermoshin on 31/01/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

let tetrisObjectsFactory = CrayzyTetris2DFiguresFactory()
let tetrisArea = CrayzyTetrisGameArea2D(areaSize: IntSize(100, 512))
let tetris = Crayzy2DTetrisGame(objectsFactory: tetrisObjectsFactory, area: tetrisArea)

while true {
    tetris.start()
}
