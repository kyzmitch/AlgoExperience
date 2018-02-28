//
//  main.swift
//  SimpleNumbers
//
//  Created by Andrey Ermoshin on 28/02/2018.
//  Copyright © 2018 andreiermoshin. All rights reserved.
//

import Foundation

func slowPrintSimpleNumbers(_ top: UInt) {
    if top == 0 {
        print("0")
        return
    }
    if top == 1 {
        print("1")
        return
    }
    for i in (2...top) {
        var isItSimple = true
        for j in (2..<i) where i % j == 0 {
            isItSimple = false
            break
        }
        if isItSimple {
            print("\(i)", separator: "", terminator: ", ")
        }
    }
}

func trialDivision1(_ number: UInt) -> Bool {
    var counterOfDivisors = 0
    
    var n = number
    var f: UInt = 2
    while n > 1 {
        if n % f == 0 {
            counterOfDivisors += 1 // found divisor
            if counterOfDivisors > 1 {
                return false
            }
            n /= f
        }
        else {
            f += 1
        }
    }
    
    return counterOfDivisors == 1
}

func printSimpleNumbersWithTrialDivision1(_ top: UInt) {
    if top == 0 {
        print("0")
        return
    }
    if top == 1 {
        print("1")
        return
    }
    // A simple but slow method of checking the primality
    // of a given number called trial division, tests whether
    // is a multiple of any integer between 2 and sqrt(n)
    // https://en.wikipedia.org/wiki/Trial_division
    for i in (2...top) {
        let hasOnlyOneDivisor = trialDivision1(i)
        if hasOnlyOneDivisor {
            print("\(i)", separator: "", terminator: ", ")
        }
    }
}

class Solution {
    
    // https://www.geeksforgeeks.org/sieve-of-eratosthenes/
    // https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
    
    func countPrimes(_ n: Int) -> Int {
        if n < 3 {
            return 0
        }
        var notPrime = Array<Bool>(repeatElement(false, count: n))
        var result = 0
        for i in (2..<n) {
            if notPrime[i] {
                continue
            }
            
            var k = 2
            var product = k * i
            while product < n {
                notPrime[product] = true
                k += 1
                product = k * i
            }
            result += 1
        }
        
        return result
    }
}

printSimpleNumbersWithTrialDivision1(10_000)
print("\n\n--------------------------------\n")
slowPrintSimpleNumbers(10_000)

let solver = Solution()
let n = 1_000
print("number of primes for \(n) is \(solver.countPrimes(n))")
