//
//  DataStructures.swift
//  CarBuyerProblemSolver
//
//  Created by Andrey Ermoshin on 09/11/2017.
//  Copyright © 2017 kyzmitch. All rights reserved.
//

import Foundation

struct Loan {
    let monthsDuration: Int8 // because maximum is 100 and can be negative to describe end of input
    let paymentPerMonth: Float
    let amount: Float
    let depreciationRecordsNumber: UInt8
    
    // month number from 0 and percentage (from 0 to 1)
    var depreciations = [(UInt, Float)]()
}
