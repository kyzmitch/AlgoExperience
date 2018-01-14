//
//  main.swift
//  NumberOfEmployees
//
//  Created by admin on 14/01/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

// https://www.geeksforgeeks.org/find-number-of-employees-under-every-manager/

/*
Given a dictionary that contains mapping of employee and his manager as a number of (employee, manager) pairs like below.
    
{ "A", "C" },
{ "B", "C" },
{ "C", "F" },
{ "D", "E" },
{ "E", "F" },
{ "F", "F" }

In this example C is manager of A,
C is also manager of B, F is manager
of C and so on.
*/

// Find number of Employees Under every Employee

// It may be assumed that an employee directly reports to only one manager. In the above dictionary the root node/ceo is listed as reporting to himself.

let input = ["A": "C",
             "B": "C",
             "C": "F",
             "D": "E",
             "E": "F",
             "F": "F"]

class Solution {
    static func countEmployees(from input: [String: String]) -> [String: UInt] {
        // Without using hash based data structures
        // just result dictionary
        // in than solution we have only 1 loop
        // and in solution below 2 loops
        var result = Dictionary<String, UInt>()
        var ceoKey = "CEOKey"
        for (em, mg) in input {
            if em == mg {
                if let previousCeoCount = result[mg], let ceoCount = result[ceoKey] {
                    result[mg] = previousCeoCount + ceoCount
                }
                else {
                    result[em] = result[ceoKey]
                }
                result[ceoKey] = nil
                ceoKey = em
                continue
            }
            if let mgCount = result[mg] {
                result[mg] = mgCount + 1
            }
            else {
                result[mg] = 1
            }
            
            if let mgAlsoEmCount = result[em] {
                // This case means that employee already a manager
                // which was found before
                if mgAlsoEmCount == 0 {
                    // this is not happen - more than one manager
                    // for one employee
                }
                else {
                    // do nothing as well
                    // as in test input for key 'C'
                }
            }
            else {
                // by default assuming that it is just employee
                result[em] = 0
                if let ceoCount = result[ceoKey] {
                    result[ceoKey] = ceoCount + 1
                }
                else {
                    result[ceoKey] = 1
                }
            }
        }
        return result
    }
    
    static func countEmployeesUsingHashing(from dictionary: [String: String]) -> [String: UInt] {
        
        var managers = Dictionary<String, UInt>()
        var ceo: String?
        for (em, mg) in input {
            if em == mg {
                // this is CEO
                ceo = em
                continue
            }
            if let oldCount = managers[mg] {
                managers[mg] = oldCount + 1
            }
            else {
                managers[mg] = 1
            }
        }
        
        var result = Dictionary<String, UInt>()
        var unmanagedPeople: UInt = 0
        for (em, _) in input {
            if let count = managers[em] {
                result[em] = count
            }
            else {
                // for not managers
                result[em] = 0
                unmanagedPeople += 1
            }
        }
        if let ceo = ceo {
            if let ceoCount = result[ceo] {
                result[ceo] = ceoCount + unmanagedPeople
            }
        }
        
        // With using MapTable in other words
        // First loop on averadge O(n * 1) where O(1) - search and insert to hash map
        // 2nd loop the same
        return result
    }
}

let output1 = Solution.countEmployeesUsingHashing(from: input)
print("1) solution: \(output1.description)")
let output2 = Solution.countEmployees(from: input)
print("2) solution: \(output2.description)")
