//: Playground - noun: a place where people can play

import Foundation

let cityNames = ["San Diego", "Los Angeles", "Cincinnati", "Dallas", "New York", "Moscow", "Sain Petersburg", "Tel Aviv", "Pula", "Nizhny Novgorod", "Ivanovo", "Vladimir", "Zagreb"]

let sorted2 = cityNames.sorted(by: <)
let sorted1 = cityNames.sorted { $0 < $1}
print(sorted1)

for i in 0...(cityNames.count/2) {
    print("\(i) - \(cityNames[i])")
}

// Test of closure
// http://www.codingexplorer.com/closures-capturing-values-swift/

func yellSomethingLouder(subject: String) -> ()->String {
    var exclamationPoints = 0
    
    let result = { () -> String in
        exclamationPoints += 1
        
        let workingString = subject + String(repeating: Character("!"), count: exclamationPoints)
        
        return workingString
    }
    return result
}

let yellComputer = yellSomethingLouder(subject: cityNames[0])

print(yellComputer())  // Output: "Computer!"
print(yellComputer())  // Output: "Computer!!"
print(yellComputer())  // Output: "Computer!!!"

let yellAtOtherComputer = yellComputer

print(yellAtOtherComputer())  // Output: "Computer!!!!"

// Even if exclamationPoints variable is not static variable
// it can save value:

// When we just set yellAtOtherComputer to the value of yellComputer,
// it kept counting up on those exclamation points!  Much like classes,
// in Swift, closures are actually reference types.

class Closure {
    typealias EmptyClosureType = () -> ()
    var internalClosure: EmptyClosureType
    var generatedClosure: EmptyClosureType?
    
    init(closure: @autoclosure @escaping () -> ()) {
        internalClosure = closure
    }
    
    func generate() -> Void {
        generatedClosure = {[weak self] () -> Void in self?.internalClosure()}
    }
}

let closure = Closure(closure: print("From initialized closure"))
closure.generate()
closure.internalClosure()
if let generated = closure.generatedClosure {
    generated()
}

