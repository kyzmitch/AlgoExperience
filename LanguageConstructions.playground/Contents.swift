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

// Example of reduce function

struct Planet {
    let name: String
    let distanceFromSun: Double
}

let planets = [
    Planet(name: "Mercury", distanceFromSun: 0.387),
    Planet(name: "Venus", distanceFromSun: 0.722),
    Planet(name: "Earth", distanceFromSun: 1.0),
    Planet(name: "Mars", distanceFromSun: 1.52),
    Planet(name: "Jupiter", distanceFromSun: 5.20),
    Planet(name: "Saturn", distanceFromSun: 9.58),
    Planet(name: "Uranus", distanceFromSun: 19.2),
    Planet(name: "Neptune", distanceFromSun: 30.1)
]

// The format of the reduce function is 1st argument is initial value
// we can assume that return type determined by that initial value type
// $0 is previous value (accumjulated) and $1 next value from the sequence

let result2 = planets.reduce(0) { $0 + $1.distanceFromSun }

func countUniques<T: Comparable>(array: Array<T>) -> Int {
    let sorted = array.sorted(by: <)
    let initial: (T?, Int) = (.none, 0)
    // accessing Tuple arguments by dot/digit syntax
    // $0 - is a result type in our case it is tuple
    // $1 - is a shortcut for item from array
    // If next element is not equal to current then +1
    // we can do that because array already sorted
    let reduced = sorted.reduce(initial) { ($1, $0.0 == $1 ? $0.1 : $0.1 + 1) }
    return reduced.1
}

countUniques(array: [1, 2, 3, 3])

func divide(dividend: Double?, by divisor: Double?) -> Double? {
    guard let dividend = dividend, let divisor = divisor, divisor != 0 else { return nil }
    return dividend / divisor
}

let divisionResult = divide(dividend: 10, by: 2)

// http://faq.sealedabstract.com/structs_or_classes/#ground-rules
// Against the Structs Philosophy
// If you need interoperability with Objecive-c classes you should use classes
// "You wanted to use structs but you needed to implement MFMailComposeViewControllerDelegate so you can't."

// It is bad to use struct and protocols if you for example want to implement unit test mock object
// and it can't work if it needs mutating method, but protocol doesn't

// YOU SHOULD NOT USE STRUCTS WHEN:

//File I/O
//Networking
//Message passing
//Heap memory allocation
//etc.
// you shouldn't wrap any singleton in a struct
//Location stuff (you have 1 GPS)
//Screen-drawing stuff (you have 1 display)
//Stuff that talks to UIApplication.sharedApplication()
//etc.
// Fast alghorithms implementations (due to high memory usage for copy values)
//If data going to have highly mutating interface (mutating functions)

// WHEN TO USE STRUCTS:

//CGRect. Stuff that is pure data. The "dumb models" in your MVC. etc.


let unsignedInt = UInt(bitPattern: -1)
let usualUint = UInt(1)
print("\(usualUint) and \(unsignedInt)")


