//
//  main.swift
//  CarBuyerProblemSolver
//
//  Created by admin on 08/11/2017.
//  Copyright © 2017 kyzmitch. All rights reserved.
//

import Foundation
// import Darwin

func getDataFromStdinUsingFileHandles() -> String? {
    let stdin = FileHandle.standardInput
    let inputString = String(data: stdin.availableData, encoding: .utf8)
    
    return inputString
}

func parseArguments() {
    let args = CommandLine.arguments
    print(#function + ": \(args.count)")
}

func getDataFromStdin() -> String {
    var result = ""
    while let line = readLine() {
        result.append(line)
    }
    return result
}

func generateSampleInput() -> String {
    // “Use three double quotes (""") for strings that take up multiple lines.”
    
    let sample = """
30 500.0 15000.0 3
0 .10
1 .03
3 .002
12 500.0 9999.99 2
0 .05
2 .1
60 2400.0 30000.0 3
0 .2
1 .05
12 .025
-99 0 17000 1
"""
    return sample
}

func parseInput(input: String) -> [Loan] {
    var loans = [Loan]()
    let lines = input.split(separator: Character("\n"))
    var loan: Loan?
    for line in lines {
        let elements = line.split(separator: " ")
        if elements.count == 4 {
            // this is loan
            if let loan = loan {
                // previous loan is ready for adding
                loans.append(loan)
            }
            if let months = Int8(elements[0]),
                let payment = Float(elements[1]),
                let amount = Float(elements[2]),
                let recordsNumber = UInt8(elements[3]) {
                loan = Loan(monthsDuration: months, paymentPerMonth: payment, amount: amount, depreciationRecordsNumber: recordsNumber, depreciations: [(UInt, Float)]())
            }
        }
        else if elements.count == 2 {
            // this is depreciation Record
            if let duration = UInt(elements[0]), let percentage = Float(elements[1]) {
                let record = (duration, percentage)
                loan?.depreciations.append(record)
            }
        }
        else {
            // not correct format of loan
            loan = nil
            break
        }
        
        // add last one if it is without records
        if let currentIndex = lines.index(of: line) {
            if currentIndex == lines.count - 1 {
                if let loan = loan {
                    // previous loan is ready for adding
                    loans.append(loan)
                }
            }
        }
    }
    
    return loans
}

func calculateFirstMonth(loan: Loan) -> UInt? {
    if loan.depreciations.count == 0 {
        return nil
    }
    
    var carValue = loan.amount
    var money = loan.amount
    var month: UInt = 0
    for i in 0..<loan.monthsDuration {
        let neededRecords = loan.depreciations.filter {
            $0.0 <= i
        }
        if neededRecords.count == 0 {
            return nil
        }
        let neededPercentage = neededRecords.last!.1
        
        carValue = carValue * (1 - neededPercentage)
        money = money - loan.paymentPerMonth
        if money < carValue {
            break
        }
        
        month += 1
    }
    return month
}

// MARK: execution

// https://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&category=608&page=show_problem&problem=1055

let loans = parseInput(input: generateSampleInput())
print("Valid loans: \(loans.count)")
for loan in loans {
    if let m = calculateFirstMonth(loan: loan) {
        print("\(m) month" + (m > 1 ? "s" : ""))
    }
    
}


